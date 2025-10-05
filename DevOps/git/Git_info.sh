# 提交时间

@echo off
git config --global user.date +0800
echo time   tag    name   hash   module branch > update_time.txt
git -C ieai-devops\ideal-dependencies log --date=local -1 --pretty=tformat:"%%ci    %%(describe:tags=true,abbrev=0)    %%aN   %%h    ideal-dependencies %%(decorate)" >> update_time.txt
git -C ieai-devops-ui\ieai-system-management-ui rev-list --count HEAD
git describe --tags -abbrev=0

git branch --show-current