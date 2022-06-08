# requestIdleCallback和requetAnimationFrame

* 通常来说界面要达到60帧才能实现相应的不卡顿
* 每一帧里都包含了用户的交互、js的执行和requestAnimationFrame的调用，布局计算和页面的重绘等工作，
* 如果某一帧的任务不多，就会剩余一定的空闲时间，这时候就可以用工作者线程来解决
* 执行requestIdleCallback回调

## 注意
* rIC执行重计算而非紧急任务
* 空闲回调执行时间应该小于50ms，或者更少
* 空闲回调中不要执行DOM操作

## 应用 
react schedule