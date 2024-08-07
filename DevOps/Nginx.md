# Nginx

配置结构：events/http/mail/stream -> server -> location

### 使用 alias 便于本地文件夹可以不用和 location 同名
- root，实际的路径就是：root值 + location值。
- alias，实际的路径就是：alias值。

### 不要用 root 启动避免后面非 root 报 Premature EOF

在 nginx.conf 中配置 user 启动用户

### 修复漏洞更新时不用重启命令
访问 404 网页看到的仍是旧版

### 设置 Nginx 的 body 大小避免请求失败
```
client_max_body_size 8m;
```
说明：
```
默认：client_max_body_size 1m;
默认：client_body_timeout 60s;
默认：proxy_connect_timeout 60s; # 通常不超过 75 秒
默认：proxy_read_timeout 60s;
默认：proxy_send_timeout 60s;
语境：http, server, location

默认：client_header_timeout 60s;
语境：http, server
```
https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size

spring 配置
```yml
spring:
  servlet:
    multipart:
      max-file-size: 1MB
      max-request-size: 10MB
```

### 设置 X-Forwarded-For 以便服务能根据请求头获取到请求 IP

最外层 Nginx：
```
proxy_set_header X-Forwarded-For $remote_addr;
```
里层 Nginx：
```
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```
说明:
```
默认：
proxy_set_header Host $proxy_host;
proxy_set_header Connection close;
语境：http, server, location
```

https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_header

## 配置指南

一级成员

| contexts | 说明           |
|----------|--------------|
| events   | 一般连接处理       |
| http     | HTTP 流量      |
| mail     | 邮件流量         |
| stream   | TCP 和 UDP 流量 |

    server {
        # configuration of HTTP virtual server 1       
        location /one {
            # configuration for processing URIs starting with '/one'
        }
        location /two {
            # configuration for processing URIs starting with '/two'
        }
    }

