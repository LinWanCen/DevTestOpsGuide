# Redis 全中文总结

一个C编写的 Key-Value 存储系统，和 Memcached 类似，
支持存储的 value 类型相对更多，性能更好

## key 键

```
del/exists/keys/randomkey/type/rename
renamenx 键 不存在的新键名
dump 需序列化键
restore 键 有效秒0不设 需序列化值 可选替换REPLACE

expire 键 有效秒
expireat 键 unix时间戳
ttl 键 (返回剩余秒)
pexpire 键 有效毫秒
pexpireat 键 unix毫秒时间戳
pttl 键 (返回剩余毫秒)
persist 键 (持久，移除有效秒)

migrate (迁移) IP 端口 键 库号 超时 可选复制COPY 可选替换REPLACE
move 键 库号
object
sort 键
[BY pattern]
[LIMIT offset count]
[GET pattern [GET pattern ...]]
[ASC | DESC] 默认ASC从小到大
[ALPHA] 配置字符串默认数字
[STORE 保存目标键]

scan 游标 (返回游标和迭代的多个元素)
可选 [MATCH pattern]
可选 [COUNT count]
```

## string

```
set/setnx 键 值
(not exist 如果不存在)
setex 键 有效秒 值
setrange 键 开始替换位置 值
mset/msetnx 键 值 键 值 ...
get/mget/getset(设置返回旧值) 键
getrange 键 左位置 右位置
(range 区间，负表示右边开始，超出按最大)
incr 自增并返回int 不存在时原值0
incrby 自增指定数值
decr/decrby/append/strlen

## hashes 哈希表
hset/hsetnx/hmset/hget/hmget
(hmset 键 hash键 值 hash键 值 ...)
hincrby/hexists/hlen/hdel/hkeys/hvals
hgetall 全部的 filed 及 value

## lists 链表
压入弹出：
lpush/rpush/lpop/rpop/rpoplpush
增删改查：
linsert 键 before 前一个值 值
lrem 键 删除位置，重复时从左开始删
lset 键 位置(0开始负右边开始) 值
lindex 键 位置
llen
ltrim 键 截取开始位置 结束位置
```

## sets 不重复集合

```
sadd/srem
smembers 返回键中所有元素
spop 键中随机返回并删除该元素
srandmember 键中随机返回
sdiff 被减集 减集
sdiffstore 存集 被减集 减集
sinter/sinterstore (交集)
sunion/sunionstore (并集)
smove 出集 入集 元素
scard 元素个数
sismember 键 测试存在成员
```

## sortedsets 有序集合
```
zadd 键 score分 值(以最后一次为准)
zrem/zremrangebyrank/zremrangebyscore

zrange 键 小开始 大结束 withscores
zrevrange 键 大开始 小结束 withscores

zrank 键 元素score从小到大排名
zrevrank 键 元素score从大到小排名

zcount 键 开始 结束
zcard 元素个数
zscore 键 需返回分值的元素
zrangebyscore 键 开始 结束 withscores
zincrby (存在则score增加否则添加元素)

## hyperloglog 基数(不重复元素)
pfadd 键 对象 对象 ... (没对象时创建空基数)
pfcount 键 键 ... (近似基数)
pfmerge 模板键 源键 源键 ...
```

## geo 地理位置
```
geoadd
geopos
geodist
georadius
georadiusbymember
geohash
```

## pub/sub（发布/订阅）
```
subscribe 订阅频道1 频道2 ...
unsubscribe 退订频道1 频道2 ...
punsubscribe 退订模式1 模式2 ...

publish 发布频道 消息
pubsub
CHANNELS [pattern] (列出活跃频道)
PUBSUB NUMSUB [channel-1 ... channel-N] (订阅数量)
PUBSUB NUMPAT (订阅模式数量)
```

## Transaction（事务）
```
multi 开启事务(多语句)
watch 键 (乐观锁，如果被更新了就不修改)
exec 提交事务/乐观锁(崩溃不回滚)
discard 回滚事务

config get * 获取配置
monitor (显示操作)
```

## script（脚本）

```
eval
evalsha
script exists
script flush
script kill
script load
```

## Connection（连接）

```
select 选择库号
程序 -a 设置连接口令
requirepass 设置连接口令
auth 验证连接口令
ping (测试连接)
quit (退出连接)
echo 显示消息
```

## server（服务器）

```
dbsize/info/time/shutdown
client getname/client setname/client list/client kill

config get/config set
config resetstat
config rewrite 记录到redis.conf文件

debug object 需返回信息的键
debug segfault 让其崩溃
flushall 删除所有库所有key
flushdb 删除当前库所有key

monitor (实时显示接收到的命令)
slaveof 主服IP地址 6379 (伺服)
slowlog
sync
psync (继续同步2.8以上)
```

### Redis 持久化

```
Snapshotting（快照，默认）
默认文件名：dump.rdb
save 秒 多少个键被修改时快照
save (不推荐，因为会阻塞)
bgsave (后台异步保存当前数据库)
lastsave (最后成功保存时间)

Append-only file（添加，缩写 aof）
默认文件名：appendonly.aof
appendonly yes // 启用
# appendfsync always // 立即，最慢
# appendfsync everysec // 每秒，默认
# appendfsync no
bgrewriteaof (重刷)
```

## Jedis

```
JRedis jredis = new JRedisClient("localhost", 6379);

批量发送请求：
ConnectionSpec spec = DefaultConnectionSpec
.newSpec("localhost", 6379, 0, null);
JRedis jredis = new JRedisPipelineService(spec);
```

参考资料：
Redis实战《红丸出品》.PDF
Redis 命令参考： http://redisdoc.com/index.html