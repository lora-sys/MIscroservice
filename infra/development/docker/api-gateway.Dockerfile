# 1. 基础镜像使用您已经拉取成功的 alpine
FROM docker.m.daocloud.io/library/alpine:latest

# 2. 安装 entr (alpine 自带，无需从 restart-helper 复制)
RUN apk add --no-cache entr

# 3. 设置工作目录
WORKDIR /app

# 4. 准备重启触发文件
RUN touch /tmp/.restart-proc && chmod 666 /tmp/.restart-proc

# 5. 复制您的代码
ADD shared shared
ADD build build

# 6. 直接使用 entr 监听文件变化并重启进程
# 这行命令的效果等同于之前的 restart-helper
ENTRYPOINT ["sh", "-c", "echo /tmp/.restart-proc | entr -n -r /app/build/api-gateway"]
