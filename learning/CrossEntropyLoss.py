import torch
import torch.nn as nn

# 假设模型输出和真实标签
outputs = torch.tensor([[2.0, 1.0, 0.1],  # 样本1的预测值
                        [0.5, 2.0, 0.3],  # 样本2的预测值
                        [0.1, 0.2, 3.0]]) # 样本3的预测值
batch_labels = torch.tensor([0, 1, 2])  # 样本1的真实标签是0，样本2是1，样本3是2

# 定义损失函数
criterion = nn.CrossEntropyLoss()

# 计算损失
pytorch_loss = criterion(outputs, batch_labels)



def softmax(x):
    """计算 Softmax"""
    exp_x = torch.exp(x - torch.max(x, dim=1, keepdim=True).values)  # 减去最大值，防止数值溢出
    return exp_x / torch.sum(exp_x, dim=1, keepdim=True)


def cross_entropy_loss(outputs, labels):
    """
    手动实现 CrossEntropyLoss
    :param outputs: 模型的输出 (batch_size, num_classes)
    :param labels: 真实标签 (batch_size,)
    :return: 损失值
    """
    # Step 1: 计算 Softmax
    probs = softmax(outputs)
    
    # Step 2: 选择真实类别对应的概率
    batch_size = outputs.shape[0]
    true_class_probs = probs[torch.arange(batch_size), labels]
    
    # Step 3: 计算负对数似然损失
    loss = -torch.log(true_class_probs)
    
    # Step 4: 计算平均损失
    return torch.mean(loss)

# 手动实现的 CrossEntropyLoss
manual_loss = cross_entropy_loss(outputs, batch_labels)


print(f"手动实现的 CrossEntropyLoss: {manual_loss.item()}")
print(f"PyTorch 自带的 CrossEntropyLoss: {pytorch_loss.item()}")





# 模拟数据
batch_size = 4  # 批次大小
feature_dim = 5  # 每张图像的特征维度
num_classes = 3  # 类别数量

# 模拟图像特征 (batch_size, feature_dim)
features = torch.randn(batch_size, feature_dim)

# 模拟真实标签 (batch_size,)
labels = torch.tensor([0, 1, 2, 0])  # 4 张图像的类别：猫、狗、鸟、猫

# 定义一个简单的全连接神经网络
class SimpleClassifier(nn.Module):
    def __init__(self, input_dim, num_classes):
        super(SimpleClassifier, self).__init__()
        self.fc = nn.Linear(input_dim, num_classes)  # 全连接层

    def forward(self, x):
        return self.fc(x)

# 初始化模型
model = SimpleClassifier(feature_dim, num_classes)

# 模型输出 (outputs)
outputs = model(features)

# 定义损失函数
criterion = nn.CrossEntropyLoss()

# 计算损失
loss = criterion(outputs, labels)

print("模拟图像特征 (features):")
print(features)
print("\n模拟真实标签 (labels):")
print(labels)
print("\n模型输出 (outputs):")
print(outputs)
print("\n计算损失 (loss):")
print(loss.item())