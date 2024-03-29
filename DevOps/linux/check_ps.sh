# 启动进程检查
# 启动进程正则 KEY_PATTERN=java|tomcat
# 启动进程数 ROWS=1
ps -ef | grep -E "PID|$KEY_PATTERN" | grep -v grep
echo
# COMMAND 可能被截断影响 grep，仅用于查看
ps aux | grep -E "PID|$KEY_PATTERN" | grep -v grep
echo
echo "其中STAT状态位常见的状态字符有"
echo "S | 处于休眠状态"
echo "R | 正在运行可中在队列中可过行的"
echo "l | 多线程"
echo "+ | 位于后台的进程组"
echo "D | 无法中断的休眠状态, 通常是 IO"
echo "T | 停止或被追踪"
echo "Z | 僵尸进程"
echo
pgrep -f "$KEY_PATTERN" | xargs -l -i echo top -n 1 -bHp {}

GREP_TEXT=`ps -ef | grep -E "$KEY_PATTERN" | grep -v grep |`
GREP_ROWS=`echo "$GREP_TEXT" | wc -l`

GREP_LEN=${#GREP_TEXT}
if [ "$GREP_LEN" = 0 ] ; then
  GREP_ROWS=0;
fi

if [ "$GREP_ROWS" != $ROWS ] ; then
  exit 1;
fi