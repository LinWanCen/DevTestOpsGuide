## Java 结构

### 按功能划分包而不是按层划分包

https://phauer.com/2020/package-by-feature/


### 不应该在一个文件中有多个方法，除非方法之间没有依赖，或者由上到下依赖

方法依赖的公共方法可以用包可见封装到多个文件中，
包可见也便于单元测试


### 使用`package-info.java`配合文档注释说明包的作用