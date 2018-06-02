#基础镜像：仓库是java，tag是8
FROM java:8
#设置时区
ENV TZ Asia/Shanghai
#创目录
VOLUME /tmp
VOLUME /u01/app/kafka-offset-monitor/logs
#将打包好的spring程序拷贝到容器中的指定位置
ADD kafka-offset-monitor/*  /u01/app/kafka-offset-monitor/
#容器对外暴露8080端口
EXPOSE 8086
#CMD 外部docker run 可替代里面参数
CMD ["sh","-c","java -version;cd /u01/app/kafka-offset-monitor/;touch logs/system_out.log;sh start.sh;tail -100f logs/system_out.log"]
