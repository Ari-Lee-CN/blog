# git

## 常用基础操作

git commit 提交一次修改

git branch +分支名称  建立分支

git checkout +名称  切换到

创建一个新的分支的同时切换到新创建的分支
git checkout -b <your-branch-name>来实现

git merge +分支名称 将另一个分支合并到自己这里

git rebase +分支名称 复制并且合并到
git rebase 分支1 分支2 将分支二复制到分支一

相对引用：^表示向上移动1个提交记录，~表示向上移动多个提交记录

修改提交：git branch -f main HEAD~3表示将main分支强制指向HEAD的第三级父提交。

git reset  撤回修改

git revert  下面跟一个修改之前的提交

## 进阶操作

标签：git tag v1 C1 将C1标签命名为V1

git cherry-pick 挑选提交复制过来

交互式rebase： git rebase -i +位置

git describe:描述离你最近的标签

![image-20211115153726115](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211115153726115.png)

选择父提交记录：可以在^后加数字选择父记录

### 提交

### 技巧

#### 1，修改之前的一个提交

思路：

1，先用 git rebase -i 将提交重新排序，然后把我们想要修改的提交记录挪到最前面

2，然后用 git commit --amend 来进行小修改

3，接着再用git rebase-i来将他们调回原来的顺序

4, 最后我们把面移动到修改的最前端

#### 2,git cherry-pick的结局思路

思路：

1，类似上面的吧

## 代码社交化

### 基本操作

git clone

git fetch 更新远程仓库到本地仓库，

git pull   gitpull实际上就是giit fetch 与git merge 两步的缩写

git push 将变更上传到指定的远程仓库，并在远程仓库上合并新的提交记录

git pull --rebase就是fetch与rebase的缩写



### 小知识

1，远程分支命名规范：<remote name>/<branch name>，表示某某仓库的某某分支

2，远程仓库默认为origin。远程分支放映了远程仓库在你最后一次与它通信时的状态

3，远程分支的特别属性：在你检出时自动进入分离HEAD状态。Git这么做是出于不能直接在这些分支上进行操作的原因，你必须在别的地方完成你的工作，（更新了远程分支之后，再用远程分享你的工作成果）

4，使用fetch操作，fetch并不会更新main分支，也不会修改磁盘文件，因此他只是下载了所缺数据，并没有修改本地文件

5，可以像操作本地分支一样来操作远程分支，只不过要使用远程分支命名规范

6，git push 不带任何参数时的行为与Git的一个名为push.default的配置有关。它的默认值取决于你正在使用的Git版本。

7，任务偏离，

![image-20211115191633613](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211115191633613.png)

解决方案就是让我的工作基于最新的远程分支，使用git pull --rebase

## 代码社交化高级

### 合并特性分支

### 不用merge

##### rebase与merge优劣比较：

优点：rebase使得提交树变得干净，所有提交都在一条线上

缺点：rebase修改了提交树的历史，从上到下的工作不一定是时间顺序

### 远程追踪

main与o/main的关联关系是由分支的“remote tracking”属性决定的

#### 可以自己指定追踪：

一，通过远程分支检出一个新的分支

git checkout -b totallyNotMain o/main

可以创建一个铭文totallyNotMain的分支，它跟踪远程分支o/main

![image-20211115211431294](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211115211431294.png)

二，使用git branch -u 命令执行：

git branch -u o/main foo

如此，foo就会追踪o/main 如果当前正处于foo分支上，还可以省略foo

### git push

git push <remote><place> git push语法

![image-20211115213320505](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211115213320505.png)

##### place参数详解

git push origin <source>:<destination>

指定来源于目的地

### git fetch

#### git fetch origin foo

Git会到远程仓库的foo分支上，获取所有本地不存在的提交，防到本地的o/foo上

git fetch origin <source><destination>
与git push相反，scource指的是远程仓库中的位置，destination才是放置提交的本地仓库的位置

### <source>属性

可以对该属性留空：
git push origin :side    将空push到仓库，删除远程仓库分支
git fetch origin :bugFix  将空fetch到本地，会在本地创建一个新分支

### git pull

git pull实际上就是fetch后跟merge

## 文档学习

![image-20211116101755827](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211116101755827.png)

















