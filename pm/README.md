# 项目管理


## Excel 应用

### 使用在线 Excel 而不是离线方便统一修改更新

### 通过表名拼接的形式设计统计表
```
=COUNTA(INDIRECT("'"&$A2&"'!"&"$G:$G"))-1
=COUNTIF(INDIRECT("'"&$A2&"'!"&"$G:$G"), B$1)
```

### 需统计完成时间的可以用`Ctrl + ;`输入日期代表完成