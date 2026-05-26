# Java 启动参数调优
```
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
$JVM_OPTIONS \
-javaagent:/opt/jmx-exporter/jmx_prometheus_javaagent-0.18.0.jar=6060:/opt/jmx-exporter/simple-config.yml \
-XX:+UseG1GC \
-XX:MaxGCPauseMillis=100 \
-XX:-OmitStackTraceInFastThrow \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-Xloggc:/applog/ACA/app_gc_ACA_${HOSTNAME}_8030.$(date +"%Y%m%d%H%M%S") \
-XX:+UseGCLogFileRotation \
-XX:NumberOfGCLogFiles=5 \
-XX:GCLogFileSize=20M \
-Dfile.encoding=utf-8 \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:+ExitOnOutOfMemoryError \
-XX:HeapDumpPath=/heapdump/heapdump_ACA_${HOSTNAME}_8030.$(date +"%Y%m%d%H%M%S")

# JDK 8u40 之前有 轮转失效、文件描述符泄露 的 bug
## 简略 GC 日志（类似 -XX:+PrintGC）
-verbose:gc \
## 详细日志
-XX:+PrintGCDetails \
## 防止业务代码中 System.gc()
-XX:+DisableExplicitGC \
```