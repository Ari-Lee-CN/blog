# canvas



## 零碎知识点

* 用js操作dom是跨线程的，因此会导致执行速度很慢，性能不好，所以需要原生的canvasAPI
* div元素替换为canvas元素出现滚动条
  原因：canvas默认为inline元素，没法指定宽高
* vh 视口高度 vw视口宽度
* 使用截图获取相应的px值
* pc端 是mouse  移动端是touch
  移动端存在多次touch事件和pc端有些区别

## canvas标签特性

> canvas类似于img 初始设置为inline 
>
> 通过width和height在html标签上设置宽高，一旦在css上覆盖样式，会在现有基础上进行拉伸，因此效果很不好。
>
> 可以通过js设置宽高，或者可以通过dom操作获取宽高，动态显示

~~~js
//教学示例及思路：
question：如何实现canvas全屏

通过控制台自行摸索学习猜测属性值
利用DOM操作动态获取视口宽高
利用js动态设置canvas的html标签宽高值
console.log打点检查程序进展

question：查询是否支持

实地操作
var supportsTouch = (typeof Touch = "object");
console.log(supportsTouch)

question：
抽象思维，三角形实例变为函数
点连线，设置变量存储上一次位置，随时更新

课程讲解思路：
1，原生实现js   跨线程不好用，解决
2，html使用，不用渲染了
3，canvas标签有哪些神奇的地方
4，如何使用官方文档自学canvas 
console.log 改变属性看变化
宽高全屏、事件监听鼠标动作、抽象化设置参数、微调定位、改正方形为圆，再次看文档，鉴别移动端与pc端区别，查询方法是否可用、再次看文档、媒体查询、解决连线断点问题，转折有缺口
~~~

### [方方怎么查阅文档学习做canvas](https://xiedaimala.com/tasks/76fb32ad-4a1b-4efe-8a84-c80c4ad1435e/video_tutorials/73637a9f-6af6-44e4-976e-ffc5f5cf967b)

