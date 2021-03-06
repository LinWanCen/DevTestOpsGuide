# 分支管理 Branch

原文：https://martinfowler.com/articles/branching-patterns.html


### 高频率同步合并，让合并更简单

源代码管理系统是一种通信工具。它允许看到团队中其他人在做什么。


### 开发人员一旦有可以共享的健康提交，就进行主线集成，不应该有超过一天的工作在你的本地存储库中未整合。

大多数持续集成的实践者每天集成多次，乐于整合一小时或更少的工作

持续集成几乎不可能偶尔为开源工作贡献者提供，但却是商业工作的现实选择。


### 在每次提交时，执行自动检查（编译测试）以确保分支上没有缺陷

理想情况下，应在每次提交时运行所有测试。如果测试速度很慢，则不实用。


### 制定及时审查承诺的纪律非常重要。

如果开发人员完成了一些工作，并投入到另一个工作中一段时间，等到审核回复时，他们脑海中的具体细节已经不那么清晰了。

结对编程提供连续的代码评审过程，其反馈周期比等待代码审阅要快。

许多使用审阅提交的团队都不够快。他们可以提供的宝贵反馈来得太晚，没有用处。

审核提交可能是一种有价值的做法，但它绝不是通往健康代码库的必要途径，尤其是如果您希望发展一个平衡的团队，而不是过于依赖其初始领导者。

文化因素影响整合摩擦，尤其是团队成员之间的信任。**消除前审查**，鼓励了更高的集成频率。


### 模块化

对模块化较差的系统进行小更改，必须了解几乎所有系统。

良好模块化的系统中更改不容易导致冲突。

但在开始编程之前，构建良好的模块化体系结构极其困难，我们需要不断观察我们的系统，重构是实现此目的的关键。

需要良好的开发实践、设计模式，以及从代码库的经验中学习。


### 不要使用环境分支模式。

必须与在每个环境中运行的可执行文件相同。

如果需要配置更改，则必须通过显式配置文件或环境变量等机制隔离配置更改，从而减少 Bug 滋生的空间。


### 版本列车模式：按月度创建分支发布
