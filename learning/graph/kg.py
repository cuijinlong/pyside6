import json
import networkx as nx
import matplotlib.pyplot as plt

# 读取 JSON 文件
with open("../model/rehabilitation_knowledge.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 创建有向图
G = nx.DiGraph()

# 添加节点
for node in data["nodes"]:
    G.add_node(node["id"], type=node["type"])

# 添加边
for edge in data["edges"]:
    G.add_edge(edge["source"], edge["target"], relation=edge["relation"])

# 打印图的节点和边
print("Nodes:", G.nodes(data=True))
print("Edges:", G.edges(data=True))

# 可视化图
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, node_color='lightblue', node_size=2000, font_size=10, edge_color='gray')
edge_labels = nx.get_edge_attributes(G, 'relation')
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)
plt.show()