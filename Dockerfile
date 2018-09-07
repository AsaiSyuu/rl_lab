FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER wuzihang <wuzihang@pku.edu.cn> 

# basic dependencies
RUN apt-get update -q && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-utils \
  curl \
  git \
  wget \
  unzip \
  vim \
  net-tools \
  cmake \
  libglew-dev \
  libosmesa6-dev \
  libgtk2.0-0 \
  libav-tools \
  x11vnc \
  xorg-dev \
  libglu1-mesa \
  libgl1-mesa-dev \
  xvfb \
  libxinerama1 \
  libgl1-mesa-glx \
  libxcursor1 \
  lxde-core \
  lxterminal \
  tightvncserver \
  xpra \
  tmux \
  xserver-xorg-dev \
  python-numpy \
  python-scipy \
  python-matplotlib \
  ipython \
  ipython-notebook \
  python-pandas \
  python3-pip

# split into two parts to use cache :)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-opencv \
  python-numpy python-dev cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig

# Install MuJoCo
RUN mkdir -p /root/.mujoco && \
  wget https://www.roboti.us/download/mjpro150_linux.zip -O mujoco.zip && \
  unzip mujoco.zip -d /root/.mujoco && \
  rm mujoco.zip
COPY src/mjkey.txt /root/.mujoco/
ENV LD_LIBRARY_PATH /root/.mujoco/mjpro150/bin:$LD_LIBRARY_PATH

# patchelf
RUN curl -o /usr/local/bin/patchelf https://s3-us-west-2.amazonaws.com/openai-sci-artifacts/manual-builds/patchelf_0.9_amd64.elf \
  && chmod +x /usr/local/bin/patchelf

# change pip source to tsinghua
RUN cd /root && mkdir .pip && cd .pip && echo "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > pip.conf
# install gym
RUN git clone https://github.com/openai/gym.git && cd gym && pip3 install -e .
# install mujoco_py
RUN pip3 install -U 'mujoco-py<1.50.2,>=1.50.1'
# install tensorflow
RUN pip3 install --upgrade --user tensorflow-gpu
# install pytorch
#RUN pip3 install torch torchvision
# install sklearn
RUN pip3 install -U scikit-learn
