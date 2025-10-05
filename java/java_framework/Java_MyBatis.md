# Java MyBatis

### MyBatis 默认开启一级缓存，查询返回的是同个对象，修改对象会影响下次相同查询

- 数据库出来的命名可以有后缀，如 DDD 的 PO，
- 按规范 PO 不出仓储层，为了性能可以出，在仓储层修改 PO 内容时需警惕是否要新建
- update/insert/delete 后会清空缓存数据
- 缓存是 SQLSession 维度的，新开事务？

### update_time > #{updateTime} 时会把自己也筛选出来

- datetime(n) 精确到微秒
- java.util.Date 精确到毫秒

### MyBatis 执行拦截器会对一个 SQL 重复执行，改 SQL 需做防重，或者在预编译拦截器中添加

### MyBatis 拦截器改 SQL 加 traceId 会导致某些数据库 SQL 指纹不同
- MySQL /*!99999
- Oracle 无法解决