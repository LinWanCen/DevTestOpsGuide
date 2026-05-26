# Redis

## Redis 的 zset 有序集合用来排名
- 字符串 `String`
  - 缓存
  - 计数器 `INCR` `DECR`
  - 分布式锁 `SET key value NX EX` SETNX DEL
  - 限速器 `INCR` + `EXPIRE`
- 哈希 `Hash`
  - 对象存储 `HSETuser:1 name "Alice" age 30`
  - 购物车
- 列表 `List`
  - 消息队列 `LPUSH` + `BRPOP`
  - 消息队列 `LPUSH` + `LTRIM` 0 9
  - 阻塞队列 `BRPOP`
- 集合 `Set`
  - 标签 `SADD article:1:tags tech redis`
  - 共同好友 `SINTER user:A:friends user:B:friends`
  - 去重
- 有序集合 `zset`
  - 【排名】 `ZADD leaderboard 100 "Player` `ZREVRANGE`
  - 延迟队列 `ZPOPMIN`
  - 权重元素存储
- 二进制 `Bitmaps`
  - 用户签到 `SETBIT sign:user:202310 5 1`
  - 活跃用户统计
- 基数统计 `HyperLogLog`
  - UV统计 `PFADD uv:20231001 user1 user2` `PFCONUNT`
- 位置 `GEO`
  - 附近的人 `GEOADD locations 116.40 39.90 user1` `GEORADIUS`
- 流 `Stream`
  - 消息总线 `XADD` `XREADGROUP`
  - 时间溯源

# 内存淘汰机制
2020下案例3：定期删除惰性删除失效，内存使用率越来越高，三种内存淘汰机制

1. 从己设置过期时间的数据集最近最少使用的数据淘汰。
2. 从己设置过期时间的数据集将要过期的数据淘汰。
3. 从己设置过期时间的数据集任意选择数据淘汰。
4. 从数据集最近最少使用的数据淘汰。
5. 从数据集任意选择数据淘汰。
