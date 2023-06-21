FROM alpine:3.18.0


RUN apk add --no-cache wget
WORKDIR /frp

# 设置环境变量 CPU_ARCH 并初始化为空
ENV CPU_ARCH=
ENV IS_MAC=

# 判断当前 CPU 架构并设置 CPU_ARCH 的值
RUN uname -m | \
    if grep -q arm; \
    then \
        export CPU_ARCH=arm; \
    else \
        export CPU_ARCH=x86; \
    fi

# 判断当前平台是否为 macOS
RUN if [ "$(uname)" = "Darwin" ]; \
    then \
        export IS_MAC=true; \
    fi


# 执行不同平台下的操作
RUN if [ "$IS_MAC" = "true" ]; \
    then \ 
        wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.49.0/frp_0.49.0_darwin_amd64.tar.gz; \
    elif [ "$CPU_ARCH" = "arm" ]; \
    then \ 
        wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.49.0/frp_0.49.0_linux_arm64.tar.gz; \
    else \ 
        wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.49.0/frp_0.49.0_linux_amd64.tar.gz; \
    fi


RUN tar -xzf frp.tar.gz -C /frp --strip-components=1
RUN rm /frp/frp.tar.gz

RUN mv frps.ini frps.ini.bck
COPY frps.ini frps.ini

CMD ["./frps", "-c", "./frps.ini"]

EXPOSE 3100 3101 3102