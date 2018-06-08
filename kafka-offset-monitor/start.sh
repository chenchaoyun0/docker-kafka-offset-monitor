#!/bin/bash
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
export KAFKA_BROKERS=$KAFKA_BROKERS
export ZK_HOSTS=$ZK_HOSTS
export REFRESH_SECENDS=$REFRESH_SECENDS
export RETAIN_DAYS=$RETAIN_DAYS
java -Xms800m -Xmx2048m -Xmn1024m -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection \
     -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -XX:+CMSClassUnloadingEnabled \
     -XX:SurvivorRatio=8 -XX:+DisableExplicitGC -Xss1024K -XX:PermSize=256m -XX:MaxPermSize=1024m \
     -cp kafka-offset-monitor-assembly.jar \
     com.quantifind.kafka.offsetapp.OffsetGetterWeb \
     --offsetStorage kafka \
     --kafkaBrokers $KAFKA_BROKERS \
     --kafkaSecurityProtocol PLAINTEXT \
     --zk $ZK_HOSTS \
     --port 8086 \
     --refresh $REFRESH_SECENDS.seconds \
     --retain $RETAIN_DAYS.days \
     --dbName offsetapp_kafka >> ./logs/system_out.log 2>&1 &
echo $!> ./.pid
echo "================kafka 地址为：$KAFKA_BROKERS"
echo "================zookeeper 地址为：$ZK_HOSTS"
echo "================刷新间隔 为：$REFRESH_SECENDS"
echo "================保留天数 为：$RETAIN_DAYS"
echo "================正在启动 kafka-offset-monitor..."
