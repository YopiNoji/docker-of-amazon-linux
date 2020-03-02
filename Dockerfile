FROM amazonlinux:latest
MAINTAINER Masaki Yoshiiwa <yopinoji@gmail.com>

# install dev tool
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install \ 
           which \ 
           kernel-devel \
           kernel-headers \
           gcc-c++ \
           patch \
           libyaml-devel \
           libffi-devel \
           autoconf \
           automake \
           make \
           libtool \
           bison \
           tk-devel \
           zip \
           wget \
           tar \
           gcc \
           zlib \
           zlib-devel \
           bzip2 \
           bzip2-devel \
           readline \
           readline-devel \
           sqlite \
           sqlite-devel \
           openssl \
           openssl-devel \
           git \
           gdbm-devel \
           python-devel 

# install Python with make
WORKDIR /root
RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
RUN tar xzvf Python-3.7.2.tgz

WORKDIR ./Python-3.7.2
RUN ./configure --with-threads
RUN make install

# install pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

# update & install 
RUN ["/bin/bash", "-c", "curl -s https://rpm.nodesource.com/setup_4.x | bash -"]
RUN ["/bin/bash", "-c", "yum install -y gcc-c++ nodejs"]

# install awscli
RUN pip install awscli
RUN pip install --user --upgrade aws-sam-cli
ENV PATH $PATH:/root/.local/bin

# set work dir
WORKDIR /usr/src
COPY . .

CMD ["/bin/bash"]