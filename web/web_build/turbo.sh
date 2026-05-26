# 从备份移动回来
mv ~/turbo-cache ./.turbo
# 备份到固定目录
mv ./.turbo ~/turbo-cache
# 保留最后几次缓存
ls -t|sed -n '5,$p'|xargs -I {} rm -rf {}