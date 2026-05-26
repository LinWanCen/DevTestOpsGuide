# CPU

### CPU 五状态
- 运行态 Running
- 就绪态 Ready
- 阻塞态 Blocked/Waiting 等待外部事件
- 挂起态 Suspended 内存不足时换出到外存（磁盘）
- 终止态 Terminated/Exit

### CPU 调度算法
- FCFS 先来先服务 First-Come, First-Served
- SJF 短作业优先 Shortest Job First
- RR 轮转 Round Robin
- SRTF 最短剩余时间优先 Shortest Remaining Time First
- M(L)FQ 多级反馈队列 Multilevel Feedback Queue
- MQS 多级队列调度 Multilevel Queue Scheduling
- PS 优先级调度 Priority Scheduling
- HRRN 最高响应比优先 Highest Response Ratio Next
- FSS 公平共享调度 Fair Share Scheduling
- LS 彩票调度 Lottery Scheduling
- CFS 完全公平调度器 Completely Fair Scheduler 选择 vruntime 最小的进程来运行，即“欠账”最多的进程