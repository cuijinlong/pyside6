import numpy as np

# 定义图的节点数量
num_nodes = 4

# 创建一个空的邻接矩阵 (4x4)
adj_matrix = np.zeros((num_nodes, num_nodes))

# 定义图的边
edges = [
    (0, 1),  # 节点 0 连接到节点 1
    (0, 2),  # 节点 0 连接到节点 2
    (1, 3),  # 节点 1 连接到节点 3
    (2, 0),  # 节点 2 连接到节点 0
    (3, 1)   # 节点 3 连接到节点 1
]

# 填充邻接矩阵
for edge in edges:
    node1, node2 = edge
    adj_matrix[node1][node2] = 1  # 无向图，两边都需要设置
    adj_matrix[node2][node1] = 1

# 打印邻接矩阵
print("邻接矩阵:")
print(adj_matrix)