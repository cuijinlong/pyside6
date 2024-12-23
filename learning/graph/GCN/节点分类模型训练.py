import os
import torch
import numpy as np
import torch_geometric.transforms as T
from torch_geometric.data import Data, InMemoryDataset

torch.device('cpu')

def load_cora(root):
   # 读取节点特征和标签
    with open(os.path.join(root, 'cora.content'), 'r') as f:
        data = f.read().splitlines()
    x = []
    y = []
    node_map = {}
    for idx, line in enumerate(data):
        parts = line.strip().split('\t')
        node_id = parts[0]
        features = list(map(float, parts[1:-1]))
        print(parts[-1])
        label = parts[-1]
        x.append(features)
        y.append(label)
        node_map[node_id] = idx

    # 将标签转换为类别索引
    label_set = list(set(y))
    y = [label_set.index(label) for label in y]
    # 读取边
    edge_index = []
    with open(os.path.join(root, 'cora.cites'), 'r') as f:
        data = f.read().splitlines()
    for line in data:
        parts = line.strip().split('\t')
        src = node_map[parts[0]]
        dst = node_map[parts[1]]
        edge_index.append([src, dst])
        edge_index.append([dst, src])  # 无向图，添加反向边

    # 转换为 PyTorch 张量
    x = torch.tensor(x, dtype=torch.float)
    y = torch.tensor(y, dtype=torch.long)
    edge_index = torch.tensor(edge_index, dtype=torch.long).t().contiguous()

    num_classes = torch.max(y).item() + 1

    # 创建 train_mask
    num_nodes = x.size(0)
    train_mask = torch.zeros(num_nodes, dtype=torch.bool)
    train_mask[:int(num_nodes * 0.8)] = True  # 前 20% 的节点作为训练集

    test_mask = torch.zeros(num_nodes, dtype=torch.bool)  # 初始化 test_mask
    # 设置测试集的节点索引（例如后 20% 的节点作为测试集）
    test_mask[int(num_nodes * 0.2):] = True

    
    # 创建 Data 对象
    data = Data(x=x, y=y, edge_index=edge_index, num_classes=num_classes, train_mask=train_mask, test_mask=test_mask)
    return data

# 加载 Cora 数据集
data = load_cora(root='/Users/cuijinlong/Documents/pyworkspace/pyside6/learning/datasets/Cora/raw')
# print(data)
# 打印数据集信息
# print(f"节点数: {data.num_nodes}")
# print(f"边数: {data.num_edges}")
# print(f"特征维度: {data.num_features}")
# print(f"布尔张量: {data.train_mask}")
# print(f"类别数: {data.num_classes}")



import torch.nn.functional as F
from torch_geometric.nn import GCNConv

class GCN(torch.nn.Module):
    def __init__(self, input_dim, hidden_dim, output_dim):
        super(GCN, self).__init__()
        self.conv1 = GCNConv(input_dim, hidden_dim)  # 第一层 GCN
        self.conv2 = GCNConv(hidden_dim, output_dim)  # 第二层 GCN

    def forward(self, x, edge_index):
        # 第一层 GCN
        x = self.conv1(x, edge_index)
        x = F.relu(x)  # 激活函数
        x = F.dropout(x, training=self.training)  # Dropout

        # 第二层 GCN
        x = self.conv2(x, edge_index)
        return F.log_softmax(x, dim=1)  # 输出分类概率
    

import torch.optim as optim

# 初始化模型
model = GCN(input_dim=data.num_features, hidden_dim=16, output_dim=data.num_classes)
optimizer = optim.Adam(model.parameters(), lr=0.01, weight_decay=5e-4)

# 训练函数
def train():
    model.train()
    optimizer.zero_grad()
    out = model(data.x, data.edge_index)
    loss = F.nll_loss(out[data.train_mask], data.y[data.train_mask])  # 只计算训练集的损失
    loss.backward()
    optimizer.step()
    return loss.item()

# 加载模型的函数
def load_model(model, optimizer, load_path):
    checkpoint = torch.load(load_path)
    model.load_state_dict(checkpoint['model_state_dict'])  # 加载模型参数
    optimizer.load_state_dict(checkpoint['optimizer_state_dict'])  # 加载优化器状态
    start_epoch = checkpoint['epoch']  # 获取上次训练的轮数
    return model, optimizer, start_epoch

def save_model(model, optimizer, epoch, save_path):
    torch.save({
        'epoch': epoch,  # 当前训练的轮数
        'model_state_dict': model.state_dict(),  # 模型的参数
        'optimizer_state_dict': optimizer.state_dict(),  # 优化器的状态
    }, save_path)


# 训练过程
start_epoch = 0
if start_epoch == 0:
    # 从头开始训练
    for epoch in range(1, 2001):
        loss = train()
        print(f'Epoch {epoch}, Loss: {loss:.4f}')
        if epoch % 500 == 0:
            save_model(model, optimizer, epoch, f'/Users/cuijinlong/Documents/pyworkspace/pyside6/learning/model/checkpoints/model_epoch_{epoch}.pt')
else:
    # 加载模型继续训练
    model, optimizer, start_epoch = load_model(model, optimizer, f'/Users/cuijinlong/Documents/pyworkspace/pyside6/learning/model/checkpoints/model_epoch_{start_epoch}.pt')
    for epoch in range(start_epoch + 1, start_epoch + 801):
        loss = train()
        print(f'Epoch {epoch}, Loss: {loss:.4f}')
        if epoch % 50 == 0:
            save_model(model, optimizer, epoch, f'/Users/cuijinlong/Documents/pyworkspace/pyside6/learning/model/checkpoints/model_epoch_{epoch}.pt')

# def test(model, data):
#     model.eval()
#     with torch.no_grad():
#         out = model(data.x, data.edge_index)
#         pred = out.argmax(dim=1)  # 获取预测的类别
#         correct = (pred[data.test_mask] == data.y[data.test_mask]).sum().item()  # 计算正确预测的数量
#         acc = correct / data.test_mask.sum().item()  # 计算准确率
#         return acc

# model, optimizer, start_epoch = load_model(model, optimizer, f'/Users/cuijinlong/Documents/pyworkspace/pyside6/learning/model/checkpoints/model_epoch_2000.pt')
# accuracy = test(model, data)
# print(f'Test Accuracy: {accuracy:.4f}')