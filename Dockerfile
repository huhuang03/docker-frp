FROM alpine:3.18.0

WORKDIR /frp

RUN apk add --no-cache wget
RUN wget -O /frp/frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.49.0/frp_0.49.0_linux_arm64.tar.gz

RUN tar -xzf /frp/frp.tar.gz -C /frp --strip-components=1
RUN rm /frp/frp.tar.gz

CMD ["./frps", "start"]

# RUN useradd -m th
# RUN echo "th: " | chpasswd
# RUN adduser th root
# RUN usermod -a -G sudo th
# WORKDIR /home/th
# USER th