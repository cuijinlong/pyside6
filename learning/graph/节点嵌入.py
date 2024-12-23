import torch
import torch.nn.functional as F
from torch_geometric.data import Data
from torch_geometric.nn import GCNConv

# GNN 
# GNN 你的朋友的工资平均值等于你的工资，
# GNN流程：聚合 -> 更新 -> 循环

# -------------------------- 聚合 --------------------------------
# 本质：就是将它邻居的特征信息添加的自身上来,实现了特征的补足。
# GCN于GNN的不同在于聚合
# GNN聚合邻居信息N=a*(2,2,2,2,2,2) + b*(3,3,3,3,3,3) + c*(4,4,4,4,4,4,4) 
# 问题来了，a,b,c的值如何设定
# 所以GCN就是解决a,b,c值设定问题
# 聚合法1，平均法：aggregate(Xi) = AX  D(度矩阵)^-1*A*X推导 ∑(j=1,N)(Aij/∑(k=1,N)Aik)Xj, 分母：总度数，我有多少个邻居,分子：一个邻居节点的特征
# 问题 你和朋友是个大网红的差距！！！ B（马云，度贼高）A(我，只认识B一个人)
# 公式：∑(j)1/(开根号(A自己的度*B自己度),拉普拉斯矩阵,解决了度的归一化，解决了马云的度不会影响我)AijHj
# A飘号：邻接矩阵A的对角线(也叫单位阵) D飘号:度矩阵

# -------------------------- 更新 --------------------------------
# 本质：激活函数[relu，sigmoid](W[权重:是模型需要训练的参数](我自己的特征+a(倍数)*N(邻居特征)))

# -------------------------- 循环 --------------------------------
# 本质：多次循环来聚合多层信息
# 作用：判断A节点分类，算loss,优化前面提到的w,是否是有钱人
#      关联预测，A和E的两个节点特征一拼，拿去做分类，一样的算loss, 优化
#      归根到底，GNN就是个提取特征的方法
torch.device('cpu')

# 1. 定义图的结构
# 节点特征矩阵 (4个节点，每个节点有2个特征)
#
x = torch.tensor([[1.0, 0.0], 
                  [0.0, 1.0], 
                  [1.0, 1.0], 
                  [0.0, 0.0]
                 ], dtype=torch.float)

# 邻接矩阵 (4个节点，无向图)
edge_index = torch.tensor([[0, 1, 1, 2, 2, 3],  # 边的起点
                           [1, 0, 2, 1, 3, 2]], dtype=torch.long)  # 边的终点

# 创建图数据对象
data = Data(x=x, edge_index=edge_index)

# 2. 定义图卷积网络 (GCN)
class GCN(torch.nn.Module):
    def __init__(self):
        super(GCN, self).__init__()
        self.conv1 = GCNConv(data.num_node_features, 4)  # 输入特征维度为2，输出特征维度为4
        self.conv2 = GCNConv(4, 2)  # 输入特征维度为4，输出特征维度为2

    def forward(self, data):
        x, edge_index = data.x, data.edge_index

        # 第一层GCN
        x = self.conv1(x, edge_index)
        x = F.relu(x)  # 激活函数

        # 第二层GCN
        x = self.conv2(x, edge_index)

        return x

# 3. 初始化模型
model = GCN()

# 4. 前向传播，获取节点嵌入
with torch.no_grad():  # 不计算梯度
    node_embeddings = model(data)

# 5. 打印节点嵌入
print("节点嵌入:")
print(node_embeddings)