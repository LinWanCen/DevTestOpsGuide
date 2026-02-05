# MySQL binlog 查看

```shell
ll -rth 找到大于事件时间的第一个文件
mysqlbinlog --base64-output=DECODE-ROWS mysql-bin.000001 | less
/表名 回车
/BEGIN 回车 Shift + N
# 找到 # at position 格式的起始和结束位置，用如下命令导出 -v 是虚拟SQL
mysqlbinlog --base64-output=DECODE-ROWS mysql-bin.000001 -v --start-position= --end-position= > 2025-10-30.sql
```

生成回滚SQL：https://github.com/LinWanCen/mysql-binlog-tool/releases/tag/1.0

