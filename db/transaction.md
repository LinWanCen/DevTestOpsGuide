# 事务


## ACID
- 原子性 atomicity
- 一致性 consistency
- 隔离性 isolation
- 持久性 durability


## 隔离级别
| 隔离级别    | 脏读 | 不可重读 | 幻读 | 英文名           | 默认  |
| ----------- | ---- | -------- | ---- | ---------------- | ----- |
| RU 读未提交 | √    | √        | √    | Read uncommitted |       |
| RC 读已提交 | ×    | √        | √    | Read committed   | 其他  |
| RR 可重读   | ×    | ×        | √    | Repeatable read  | MySQL |
| S  串行化   | ×    | ×        | ×    | Serializable     |       |

- **读未提交 = 脏读**，没有隔离性，Saga 分布式事务的缺点
- **读已提交 = 不可重读：更新**，一个事务两次读取内容不一样
- **幻读：插入**，一个事务两次读取条数不一样，MySQL 用 MVCC 解决
- 多版本并发控制 MVCC Multiversion Concurrency Control
    - DB_TRX_ID 最近增改事务ID
    - DB_ROLL_PTR 回滚指针，上一版本 0x...
    - DB_ROW_ID 自增ID，没有主键时的聚簇索引，select _rowid
    - DELETED_BIT 删除


## CAP
- 一致性 Consistency
- 可用性 Availability
- 分区容错性 Partition tolerance

一般要求AP，C只需要保证最终一致性，所以有日终对账程序


## 与缓存一致性
- 先更新数据库，避免刚删完缓存就被其他线程刷入旧数据
- 缓存使用删除而不是更新，避免更新时数据库内容已经变了

## 缓存问题
- 缓存穿透：反复攻击不存在的数据，解决：不存在就set key null ex 30
- 缓存击穿：并发去库里查一个
- 缓存雪崩：大批量失效查库

## 缓存淘汰
全部/已设置过期时间 × 最少使用，最不经常使用，随机 + 已设置过期即将过期

## Redis 事务

| Redis   | MySQL    |
| ------- | -------- |
| multi   | begin    |
| exec    | commit   |
| discard | rollback |
| watch   | (lock)   |


## 分布式锁

都是创建+删除的方式

| 问题 | 数据库        | Redis                    | Zookeeper                    |
|------|---------------|--------------------------|------------------------------|
| 实现 | insert delete | set 键 id ex 秒 nx       |                              |
| 异常 |               | 靠ex                     | 客户端挂掉时节点就自动删除了 |
| 阻塞 | 轮询          | 轮询                     | 顺序创建、通知               |
| 重入 |               | MAC + jvm进程ID + 线程ID | 与当前最小节点对比           |
| 单点 |               | 集群部署                 | 集群部署                     |


## 分布式事务算法与实现

三种核心算法方案
- 2PC - Two-Phase Commit，prepare 锁定资源不提交，第二阶段提交或回滚，强一致性，电商下单，库存扣减等短事务
- 3PC - Three-Phase Commit，增加 CanCommit 并引入超时默认提交，减少阻塞和降低单点故障影响范围，少用
- TCC - Try-Confirm-Cancel，资源预留（如冻结余额），业务侵入强，最终一致性，主流实践方案，金融交易

- XA  - eXtended Architecture （X/Open DTP)，2PC 工业标准化实现，死锁概率高，协调者宕机全局锁死，传统低频金融系统
  - 数据库层标准（ISO/IEC 10026规范）
  - DTP -  Distributed Transaction Processing
- AT  - Auto Transaction (天猫 Seata) 应用层伪 2PC，框架代理SQL，失败自动生成 UNDO_LOG 无侵入，弱隔离，电商订单，库存管理
- Saga ，无隔离，补偿事务，最终一致性，如订单退款，物流调度链
- 基于消息，无隔离，最终一致性，如支付成功通知


- AP (Application)：业务程序（定义事务边界，如调用 BEGIN/COMMIT）。
- TM (Transaction Manager)：全局事务协调者（例如Java中的 TransactionManager）。
- RM (Resource Manager)：本地资源管理器（如MySQL、Oracle数据库）。
- TX 接口：AP 与 TM 的交互接口（例如Java JTA中的 UserTransaction）。 
- XA 接口：TM 与 RM 的交互接口（数据库驱动实现，如MySQL Connector/J 的 XAResource）。

- TC（Transaction Coordinator）Seata-AT 的独立事务协调器

## 分布式事务容错设计

- TCC：需解决三大问题——空回滚（未Try却调用Cancel）、幂等（网络重试）、业务悬挂（Cancel后Try才到达）
- 消息队列：依赖事务状态表+定时校对，防止消息丢失
- Saga：补偿事务需幂等，且失败时需人工介入

- 分支事务执行时要拒绝回滚执行
- 已经失败的事务直接返回回滚成功
- 多次收到分支事务要幂等