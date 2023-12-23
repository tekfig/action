# 使用基于 JDK 17 的官方 Maven 镜像作为基础镜像
FROM maven:3.8.4-openjdk-11-slim AS build

# 将代码复制到容器中
COPY . /app

# 在容器中创建一个工作目录（例如，/app）
WORKDIR /app

# 执行 Maven 构建
RUN mvn clean package

# 创建一个新的基础镜像，只包含 JRE（没有 Maven）
FROM openjdk:11-jre-slim

# 在容器中创建一个工作目录
# WORKDIR /app

# 从构建阶段中复制编译好的 JAR 文件到容器中
COPY --from=build /app/target/Hello.jar /app/Hello.jar

# 指定运行时命令
ENTRYPOINT ["java", "-jar", "Hello.jar"]