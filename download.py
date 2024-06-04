import gdown

url = "https://drive.google.com/uc?id=14nbJUUg80Jkg_SaWma7kE4elpkmzEEVT"
output = "NVIDIA-Linux-x86_64-550.54.15.run"
gdown.download(url, output)

url = "https://drive.google.com/uc?id=11id1RRBsKc8epbdsoTxYOzdfecSpzJ-z"
output = "cudnn-linux-x86_64-8.9.2.26_cuda12-archive.tar.xz"

gdown.download(url, output)
