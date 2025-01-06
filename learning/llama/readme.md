
colab一键训练脚本
https://colab.research.google.com/drive/1MfP3vt9YrOkjg70dKPPFvB174PBnaPSB?usp=sharing

unslo本地安装包下载
百度网盘：https://pan.baidu.com/s/17XehOXC2LMbnLnVebV79lQ?pwd=rycn
谷歌网盘：https://drive.google.com/drive/folders/1BhhBWfOSqCqhmpi8M_dq-nn0eMEZxR-I?usp=sharing
训练的模型下载：https://drive.google.com/file/d/1REtJuRGg2dzRLZ8HyEqfJn8oYuClht8P/view?usp=sharing

相关项目
unsloth：https://github.com/unslothai/unsloth
gpt4all：https://gpt4all.io/
triton：https://github.com/openai/triton
llama.cpp：https://github.com/ggerganov/llama.cpp

Windows本地部署条件
1、Windows10/Windows11
2、英伟达卡8G显存、16G内存，安装CUDA12.1、cuDNN8.9，C盘剩余空间20GB、unsloth安装盘S40GB
3、依赖软件：CUDA12.1+cuDNN8.9、Python11.9、Git、Visual Studio 2022、llvm(可选）
4、HuggingFace账号，上传训练数据集

Windows部署步骤
一、下载安装包
1、安装cuda12.1，配置cuDNN8.9
2、安装Visual Studio 2022
3、解压unsloth
4、安装python11
5、安装git
6、设置llvm系统环境变量(可选）

二、安装unsloth
1、使用python11创建虚拟环境
python311\python.exe -m venv venv
2、激活虚拟环境
call venv\scripts\activate.bat
3、安装依赖包
pip install torch==2.2.2 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
pip install datasets==2.19.0
pip install tokenizers==0.19.1
pip install tyro==0.8.3
pip install tbb==2021.11.0
pip install --no-deps trl==0.8.6 
pip install --no-deps peft==0.10.0
pip install --no-deps accelerate==0.29.3
pip install --no-deps bitsandbytes==0.43.1
pip install deepspeed-0.13.1+unknown-py3-none-any.whl
pip install  triton-2.1.0
# pip install  triton-2.1.0-cp311-cp311-win_amd64.whl
pip install xformers==0.0.25.post1
pip install huggingface-hub==0.22.2
pip install datasets==2.19.0
pip install deepspeed==0.13.1+unknown
pip install peft==0.10.0
pip install numpy==1.26.3
pip install pillow==10.2.0
pip install protobuf==3.20.3
pip install sentencepiece==0.2.0
4、测试安装是否成功
nvcc  --version
python -m xformers.info
python -m bitsandbytes
5、运行脚本
python test-unlora.py   测试微调之前推理
下载模型科学上网
```
https://eastmonster.github.io/2022/10/05/clash-config-in-wsl/
```
设置环境变量
```
PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True,max_split_size_mb:128"
```
python fine-tuning.py   用数据集微调
test-lora.py   测试微调之后推理
废弃：save-16bit.py  合并保存模型16位
废弃：save-gguf-4bit.py  4位量化gguf格式
三、4位量化需要安装llama.cpp，步骤如下：
1、git clone https://github.com/ggerganov/llama.cpp
2、按官方文档编译
apt install cmake
cd llama.cpp
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release
cd llama.cpp
python convert_hf_to_gguf.py /opt/unsloth/outputs/
测试
/opt/llama.cpp/build/bin/llama-cli -m /opt/unsloth/outputs/llama-3-8B-bnb-4bit-F16.gguf -cnv -p "海绵宝宝是谁" -ngl 9999



