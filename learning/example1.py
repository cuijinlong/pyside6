import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset
import numpy as np
from transformers import BertTokenizer, BertModel  # 用于文本特征
import torchvision.models as models  # 用于图像特征

torch.device('cpu')

class CustomDataset(Dataset):
    def __init__(self, numerical_features, text_features, image_features, labels):
        self.numerical_features = numerical_features
        self.text_features = text_features
        self.image_features = image_features
        self.labels = labels

    def __len__(self):
        return len(self.labels)

    def __getitem__(self, idx):
        numerical = torch.tensor(self.numerical_features[idx], dtype=torch.float32)
        text = self.text_features[idx]
        image = torch.tensor(self.image_features[idx], dtype=torch.float32)
        label = torch.tensor(self.labels[idx], dtype=torch.long)  # 显式指定为torch.long
        return numerical, text, image, label

# 示例数据
numerical_features = np.random.rand(100, 10)  # 100个样本，每个样本10维数值特征
text_features = ["This is a sample sentence."] * 100  # 100个样本，每个样本一个文本
image_features = np.random.rand(100, 3, 64, 64)  # 100个样本，每个样本3通道64x64图像
labels = np.random.randint(0, 2, 100)  # 100个样本，二分类标签

dataset = CustomDataset(numerical_features, text_features, image_features, labels)
dataloader = DataLoader(dataset, batch_size=32, shuffle=True)


class MultiFeatureTransformer(nn.Module):
    def __init__(self, numerical_dim, text_dim, image_dim, num_classes, d_model, nhead, num_encoder_layers, dim_feedforward, dropout):
        super(MultiFeatureTransformer, self).__init__()
        
        # 数值特征嵌入
        self.numerical_embedding = nn.Linear(numerical_dim, d_model)
        
        # 文本特征嵌入（使用BERT）
        self.text_embedding = BertModel.from_pretrained('bert-base-uncased')
        self.text_projection = nn.Linear(768, d_model)  # BERT输出维度是768
        
        # 图像特征嵌入（使用预训练的ResNet）
        self.image_embedding = models.resnet18(pretrained=True)
        self.image_embedding.fc = nn.Linear(512, d_model)  # ResNet18输出维度是512
        
        # Transformer编码器
        encoder_layer = nn.TransformerEncoderLayer(d_model=d_model, nhead=nhead, dim_feedforward=dim_feedforward, dropout=dropout)
        self.transformer_encoder = nn.TransformerEncoder(encoder_layer, num_layers=num_encoder_layers)
        
        # 分类器
        self.classifier = nn.Linear(d_model, num_classes)
    
    def forward(self, numerical, input_ids, attention_mask, image):
        # 数值特征嵌入
        numerical_embedded = self.numerical_embedding(numerical)
        
        # 文本特征嵌入
        text_embedded = self.text_embedding(input_ids=input_ids, attention_mask=attention_mask).last_hidden_state.mean(dim=1)  # 取BERT输出的均值
        text_embedded = self.text_projection(text_embedded)
        
        # 图像特征嵌入
        image_embedded = self.image_embedding(image)
        
        # 拼接特征
        combined_features = torch.stack((numerical_embedded, text_embedded, image_embedded), dim=1)
        
        # Transformer编码
        transformer_output = self.transformer_encoder(combined_features)
        
        # 取第一个时间步的输出作为分类依据
        output = self.classifier(transformer_output[:, 0, :])
        
        return output

# 模型参数
numerical_dim = 10
text_dim = 768  # BERT输出维度
image_dim = 512  # ResNet18输出维度
num_classes = 2
d_model = 64
nhead = 4
num_encoder_layers = 2
dim_feedforward = 128
dropout = 0.1

model = MultiFeatureTransformer(numerical_dim, text_dim, image_dim, num_classes, d_model, nhead, num_encoder_layers, dim_feedforward, dropout)


criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)


num_epochs = 10

# BERT分词器
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')

for epoch in range(num_epochs):
    model.train()
    for batch_numerical, batch_text, batch_image, batch_labels in dataloader:
        # 确保数据类型正确
        batch_numerical = batch_numerical.float()  # 数值特征转换为float32
        batch_image = batch_image.float()  # 图像特征转换为float32
        batch_labels = batch_labels.long()  # 标签转换为long（int64）
        
        # 文本特征分词
        batch_text = tokenizer(batch_text, return_tensors='pt', padding=True, truncation=True)
        input_ids = batch_text['input_ids'].to('cpu')  # 将input_ids移动到GPU（如果有）
        attention_mask = batch_text['attention_mask'].to('cpu')  # 将attention_mask移动到GPU（如果有）
        
        # 前向传播
        outputs = model(batch_numerical, input_ids, attention_mask, batch_image)
        loss = criterion(outputs, batch_labels)
        
        # 反向传播和优化
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
    
    print(f'Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}')