# 软件配置管理 SCM（版本控制&变更控制）

## `SVN`与`Git`

### `SVN`迁移`Git`可以保留提交记录，尽量保留提交记录迁移

```shell
git svn clone svn地址 --username=用户名
```

### 使用`.gitignore`文件忽略编译后的文件和本地运行时产生的日志等

IDEA 提示”部分忽略的目录未从索引和搜索中排除“时，\
点击查看目录，排除掉以免搜索到不需要的日志，\
并减少建立索引的时间，**提升性能**

从svn迁移过来的一般在`.gitignore`文件最上面会添加忽略
```gitignore
.svn
```


### 使用`.gitkeep`空文件在`Git`中保留空文件夹

### 提交时注意作者和邮箱是否正确，避免不统一

https://git-scm.com/book/zh/v2/Git-工具-重写历史

### `Git`可以按目录拉取，可以拆分并保留提交记录

```shell
git config core.sparsecheckout true
echo "subDir/" >> .git/info/sparse-checkout
git pull origin master
```
https://git-scm.com/docs/git-sparse-checkout

## 避免冲突

### 把会出现多人同时添加的公共文件拆分成多个

比如每个服务一个配置文件而不是在同个文件中，避免同时添加或不同分支合并出现冲突


### 分工时依据修改添加哪些文件分工，必要时指定清楚

否则两个人都添加或修改了同一处就会出现冲突

### 发现问题不只是改正，要对全量代码和历史数据做全面排查
