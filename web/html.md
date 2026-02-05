# HTML

### 所有`target="_blank"`的链接都应添加`rel="noopener noreferrer"`

兼顾安全与隐私，避免`csrf error`报错
```html
<a href="" target="_blank" rel="noopener noreferrer"/>
```

- `nofollow`   告知搜索引擎不要追踪此链接（不传递权重）。
- `noopener`   阻止新打开的页面通过 `window.opener` 访问原页面，**增强安全性**。
- `noreferrer` 隐藏来源页面的 URL（不发送 `Referer` 头），**保护隐私**。
- `opener`     默认行为（与 `noopener` 相反），允许新页面访问原页面的 `window` 对象。
- `external`   声明链接指向外部站点，提示浏览器或 SEO 系统。
- `sponsored`  标记广告或赞助链接（SEO 用途）。
- `ugc`        标记用户生成内容中的链接（如评论区链接）。
- `alternate`  提供当前页面的替代版本（如不同语言版本）。
- `help`       链接到帮助文档。
- `license`    链接到版权许可证信息。