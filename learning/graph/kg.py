import json
import networkx as nx
import matplotlib.pyplot as plt
import matplotlib
matplotlib.rcParams["font.family"] = "SimSong"
matplotlib.rcParams["font.sans-serif"] = ["SimSong"]

# 读取 JSON 文件
with open("learning/model/rehabilitation_knowledge.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 创建有向图
G = nx.DiGraph()

# 添加节点
for node in data["nodes"]:
    G.add_node(node["id"], type=node["type"])

# 添加边
for edge in data["edges"]:
    G.add_edge(edge["source"], edge["target"], relation=edge["relation"], weight=edge["weight"])

# 打印图的节点和边
# print("Nodes:", G.nodes(data=True))
print("Edges:", G.edges(data=True))

# --------------------------------------------------推荐学习路径（从数学基础到深度学习）---------------------------------------------------------------------------
start_node = "脑外伤后遗症"
end_node = "认知能力提升"
# 使用 Dijkstra 算法推荐最短路径
try:
    path = nx.shortest_path(G, source=start_node, target=end_node, weight="weight")
    print(f"Dijkstra 推荐的学习路径: {path}")
except nx.NetworkXNoPath:
    print(f"无法从 {start_node} 到 {end_node} 找到路径")


# --------------------------------------------------定义启发式函数（估计从当前节点到目标节点的代价）---------------------------------------------------------------------------
def heuristic(n1, n2):
    # 假设启发式函数为节点名称的字符串长度差
    return abs(len(n1) - len(n2))
try:
    path = nx.astar_path(G, source=start_node, target=end_node, heuristic=heuristic, weight="weight")
    print(f"定义启发式函数推荐的学习路径 (A*): {path}")
except nx.NetworkXNoPath:
    print(f"无法从 {start_node} 到 {end_node} 找到路径")
# -----------------------------------------------floyd算法(依次将每个点作为『中间点』去做更新)-------------------------------------------------------------
# 设置无穷大
import json
import sys
# 第一步: 构建邻接矩阵
# 获取节点列表
INF = sys.maxsize
nodes = [node["id"] for node in data["nodes"]]
# 初始化邻接矩阵
V = len(nodes)
def floyd_graph():
    graph = [[INF] * V for _ in range(V)]
    # 初始化节点到索引的映射
    node_to_index = {node: idx for idx, node in enumerate(nodes)}
    # 填充邻接矩阵
    for edge in data["edges"]:
        src = node_to_index[edge["source"]]
        dst = node_to_index[edge["target"]]
        weight = edge["weight"]
        graph[src][dst] = weight
        
    # 设置节点到自身的距离为 0
    for i in range(V):
        graph[i][i] = 0

    print("邻接矩阵：")
    for row in graph:
        print([x if x != INF else "INF" for x in row])
    return graph

# 第二步： Floyd算法计算最短路径
def floyd_warshall(graph):
    V = len(graph)
    dist = [[graph[i][j] for j in range(V)] for i in range(V)]
    for k in range(V):
        for i in range(V):
            for j in range(V):
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
    
    return dist
graph = floyd_graph()
result = floyd_warshall(graph)
print("\n任意两个节点之间的最短路径：")
for i in range(V):
    for j in range(V):
        if result[i][j] == INF:
            print(f"{nodes[i]} -> {nodes[j]}: 不可达", end="\t")
        else:
            print(f"{nodes[i]} -> {nodes[j]}: {result[i][j]}", end="\t")
    print()
# -------------------------------------- 拓扑排序（所有点在按照先后顺序排成序列）----------------------------------------------------------------------------------------
# 每次选入度为0的点，然后删除这个点和它的出边（不能存在有环的情况）,（有向无环图）
try:
    topological_order = list(nx.topological_sort(G))
    print("\n拓扑排序顺序：")
    print(topological_order)
except nx.NetworkXUnfeasible:
    print("图中存在环，无法进行拓扑排序。")

# -------------------------------------- AOE 网(Activity on edge network)(活动=任务) 用来描述一个工程的（有向无环图）-----------------------------------------------------------------
# 源点：入度为0 的顶点 汇点:出度为 0 的顶点 ，完成整个工程至少需要花多长时间->哪条路径最耗时？关键路径
# 关键活动不能拖延的活动最早开始时间=最晚开始时间
# v-vertex e-early l-late
# ve:时间的最早开始事件
# vl:事件的最晚开始事件
# e: 活动的最早开始时间
# l: 活动的最晚开始时间










# --------------------------------------------------社区检测---------------------------------------------------------------------------
from networkx.algorithms import community
# 使用 Girvan-Newman 算法检测社区
communities = community.girvan_newman(G)
for com in next(communities):
    print("社区:", com)

# --------------------------------------------------中心性分析---------------------------------------------------------------------------
# 计算节点的度中心性
degree_centrality = nx.degree_centrality(G)
print("度中心性:", degree_centrality)


# 绘制图
pos = nx.spring_layout(G)
nx.draw_networkx_nodes(G, pos, node_size=2000, node_color='lightblue')
nx.draw_networkx_edges(G, pos, width=[d['weight'] for (u, v, d) in G.edges(data=True)], edge_color='gray')
nx.draw_networkx_labels(G, pos, font_size=10)
plt.title("1sss11")
plt.show()

# # 可视化图
# pos = nx.spring_layout(G)
# nx.draw(G, pos, with_labels=True, node_color='lightblue', node_size=2000, font_size=10, edge_color='gray')
# edge_labels = nx.get_edge_attributes(G, 'relation')
# nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)
# plt.show()