# 使用 JDK 17 作为基础镜像
FROM adoptopenjdk:17-jdk-hotspot

# 在容器中创建一个工作目录
WORKDIR /app

# 安装 Git 客户端
RUN apt-get update && apt-get install -y git

# 从 GitHub 上克隆代码（使用您的代码库的URL替换<repository-url>）
RUN git clone https://github.com/tekfig/action.git .

# 执行 Maven 构建
RUN mvn clean install

# 指定运行时命令
CMD ["java", "-jar", "target/Hello.jar"]