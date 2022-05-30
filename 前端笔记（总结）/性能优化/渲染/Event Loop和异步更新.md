# Event Loop与异步更新

##  宏任务和微任务

常见的 macro-task 比如： setTimeout、setInterval、 setImmediate、script（整体代码）、 I/O 操作、UI 渲染等。
		常见的 micro-task 比如: process.nextTick、Promise、MutationObserver 等。

## EventLoop过程解析

* 初始状态：调用栈为空，micro队列为空，macro队列中只有一个script脚本（