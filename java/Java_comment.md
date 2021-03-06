## Java 注释

### 使用文档注释，文档注释中使用`HTML`格式化，使用链接便于快速跳转查看

例如换行应该使用<br/>等

### 使用`{@link package.class＃member label}`便于在相关程序中快速跳转

### 测试案例链接到测试类应使用`@see`，不加`package`，因为在同一个包里，使链接保持简短

```java
/**
 * @see IncludeTest
 */
public class IncludeTest {}
```


### 不要在开发工具(`IDE`)中设置自动注释格式，只需做必要的注释。

设置自动注释格式而没有对应的内容时会在代码中留下很多无用的内容，
而且不存在的标签在`IntelliJ IDEA`中默认会报红提示。
好的代码在参数、返回字段等地方应该是不言自明的，
但是类似返回的值为空是哪些情况等需要说明的地方还是需要手动注释。


### 使用`// FIXME 测试挡板`标注临时代码

- 原则上不应编写临时挡板
- 如果是单次的可以用远程调试下编辑编译的方式单次热替换
- 常规挡板应使用数据库或配置文件判断去实现（如 spring 和 maven的 profile）

因为在某些项目中`IDE`生成的代码带有`TODO`标签，所以用`FIXME`，并且用中文让审核代码的同事也能一眼关注到