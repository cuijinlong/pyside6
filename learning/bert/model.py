from torch import nn
import torch
from torch.nn import functional as F
from transformer import EncoderLayer

torch.device('cpu')

class BERTEncoder(nn.Module):

    def __init__(self, vocab_size, e_dim, h_dim, n_heads, n_layers, max_len=1024):
        '''
        :param vocab_size: 词汇数量
        :param e_dim: 词向量维度
        :param h_dim: Transformer编码层中间层的维度
        :param n_heads: Transformer多头注意力的头数
        :param n_layers: Transformer编码层的层数
        :param max_len: 序列最长长度
        '''
        super(BERTEncoder, self).__init__()
        # 将 token 转换为词向量。
        self.token_embedding = nn.Embedding(vocab_size, e_dim)
        # 将 segment（句子标记）转换为向量。
        self.segment_embedding = nn.Embedding(2, e_dim)
        # 位置编码，用于表示 token 的位置信息。
        # 将生成的张量包装为一个可学习的参数。这意味着在模型训练过程中，self.pos_embedding 会被优化（即通过梯度下降更新）。可以更灵活地捕捉序列中的位置信息。
        self.pos_embedding = nn.Parameter(torch.randn(1, max_len, e_dim))
        # 多层 Transformer 编码器
        self.encoder_layers = nn.ModuleList([EncoderLayer(e_dim, h_dim, n_heads) for _ in range( n_layers )])

    # 前向传播
    def forward(self, tokens, segments):
        # 将 token 和 segment 的 embedding 相加。
        X = self.token_embedding(tokens) + self.segment_embedding(segments)
        # X.shape: (batch_size, seq_len, e_dim)
        # 加上位置编码。
        X = X + self.pos_embedding.data[:, :X.shape[1], :]
        # 通过多层 Transformer 编码器进行编码。
        for layer in self.encoder_layers:
            X = layer(X)
        return X
    
# 掩码语言模型 (MaskLM)
class MaskLM(nn.Module):
    # vocab_size：词汇表大小。
    # h_dim：中间层的维度。
    # e_dim：输入向量的维度。
    def __init__(self, vocab_size, h_dim, e_dim):
        super(MaskLM, self).__init__()
        # 多层感知机，用于预测被掩码的 token。
        self.mlp = nn.Sequential(nn.Linear(e_dim, h_dim),
                                 nn.ReLU(),
                                 nn.LayerNorm(h_dim),
                                 nn.Linear(h_dim, vocab_size),
                                 nn.Softmax())

    # 前向传播
    # 根据 pred_positions 提取被掩码的 token 的向量。
    # 通过 MLP 预测这些 token 的概率分布。
    def forward(self, X, pred_positions):
        # 存储每个序列中需要预测的 token 数量
        # pred_positions.shape: [24, 3]
        num_pred_positions = pred_positions.shape[1]
        # pred_positions.shape: [72]  24*3 = 72 展平为一维张量
        pred_positions = pred_positions.reshape(-1)
        batch_size = X.shape[0]
        batch_idx = torch.arange(0, batch_size)
        # 为了让batch_idx于num_pred_positions保持对应，所以每个${batch_idx}会重复${num_pred_positions}次
        batch_idx = torch.repeat_interleave(batch_idx, num_pred_positions)
        # X.shape (batch_size, seq_len, e_dim)
        # masked_X.shape (pred_positions, mlm_h_dim)
        masked_X = X[batch_idx, pred_positions]
        masked_X = masked_X.reshape((batch_size, num_pred_positions, -1))
        mlm_Y_hat = self.mlp(masked_X)
        return mlm_Y_hat

# 下一句预测 (NextSentencePred)
# NextSentencePred 是 BERT 的下一句预测任务，用于判断两个句子是否是连续的。
class NextSentencePred(nn.Module):
    # e_dim：输入向量的维度。
    def __init__(self, e_dim):
        super(NextSentencePred, self).__init__()
        # output：线性层，输出二分类结果。
        self.output = nn.Linear(e_dim, 2)
    
    # 对输入向量进行线性变换。
    # 通过 softmax 输出概率分布。
    def forward(self, X):
        return F.softmax(self.output(X))

class BERTModel(nn.Module):

    def __init__( self, vocab_size, e_dim, transformer_h_dim, mlm_h_dim, n_heads, n_layers, max_len = 1024 ):
        '''
        :param vocab_size:  词汇数量
        :param e_dim: 词向量维度
        :param transformer_h_dim: transformer中间隐藏层的维度
        :param mlm_h_dim: mlm网络中间隐藏层维度
        :param n_heads: Transformer多头注意力的头数
        :param n_layers: Transformer编码层的层数
        :param max_len: 序列最长长度
        '''
        super(BERTModel, self).__init__()
        # encoder：BERT 编码器。
        self.encoder = BERTEncoder(vocab_size, e_dim, transformer_h_dim, n_heads, n_layers, max_len=max_len)
        # mlm：掩码语言模型。
        self.mlm = MaskLM(vocab_size, mlm_h_dim, e_dim)
        # nsp：下一句预测任务。
        self.nsp = NextSentencePred(e_dim)

    # 通过编码器获取上下文相关的向量表示。
    # 通过 MLM 预测被掩码的 token。
    # 通过 NSP 预测下一句是否连续。
    def forward(self, tokens, segments, pred_positions=None):
        encoded_X = self.encoder(tokens, segments) #[batch_size, seq_len, e_dim]  [24, 12, 768]
        # pred_positions： [25, 3] 每个序列中需要预测的 token 数量
        mlm_Y_hat = self.mlm(encoded_X, pred_positions)
        nsp_Y_hat = self.nsp(encoded_X[:, 0, :])
        return encoded_X, mlm_Y_hat, nsp_Y_hat

if __name__ == '__main__':
    net = BERTModel(vocab_size=100, e_dim=768, transformer_h_dim=768, mlm_h_dim=768, n_heads=3, n_layers=12, max_len = 1024)
    batch_size = 24
    # 这里的 12 就是 seq_len，表示每个输入序列有 12 个 token。
    tokens = torch.randint(0,100,(batch_size,12)) # [batch_size: 24, seq_len:12]
    #tensor([[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1],
    #          .......                  
    #        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1]], dtype=torch.int32)
    # 生成一个形状为 (batch_size, 7) 的张量，所有元素值为 0， 生成一个形状为 (batch_size, 5) 的张量，所有元素值为 1,将两个张量在维度 1（即序列长度维度）上拼接。
    segments = torch.cat([torch.zeros(batch_size,7,dtype=int),torch.ones(batch_size,5,dtype=int)],dim=1)
    # 每个批次里面从0-11中随机找到3个位置， 需要预测的token的位置
    pred_positions = torch.randint(0,12,(batch_size,3))
    encoded_X, mlm_Y_hat, nsp_Y_hat = net(tokens,segments,pred_positions)

    print(encoded_X.shape) # encoded_X：编码后的向量，形状为 (batch_size, seq_len, e_dim)。
    print(mlm_Y_hat.shape) # mlm_Y_hat：MLM 的输出，形状为 (batch_size, num_pred_positions, vocab_size)。
    print(nsp_Y_hat.shape) # NSP 的输出，形状为 (batch_size, 2)。