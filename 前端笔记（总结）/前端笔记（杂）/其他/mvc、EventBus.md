# 浅析MVC

模块化：将逻辑分块、各自封装、相互独立，每一个快自行决定向外暴露什么，自行决定引入哪些外部代码。

mvc就是一种前端模块化思路

## mvc介绍

MVC包括三类对象，将他们分离以提高灵活性和复用性。

- 模型model用于封装与应用程序的业务逻辑相关的数据以及对数据的处理方法，会有一个或多个视图监听此模型。一旦模型的数据发生变化，模型将通知有关的视图。
- 视图view是它在屏幕上的表示，描绘的是model的当前状态。当模型的数据发生变化，视图相应地得到刷新自己的机会。
- 控制器controller定义用户界面对用户输入的响应方式，起到不同层面间的组织作用，用于控制应用程序的流程，它处理用户的行为和数据model上的改变。

![经典MVC模式](https://efe.baidu.com/blog/mvc-deformation/img/typicalMVC.png)

​                                               经典MVC模式

伪代码

~~~JavaScript
const m = {
  data: x,
  create(){},
  delete(){},
  updata(){}，
  get(){}
}

const v = {
  el: null,  // 相当于一个容器，放置动态渲染 HTML
  html: `<div>...<div>`,  
  init(){}, 
  render(){}  // 渲染
}

const c = {
  init(){
    ...some code
    // 自动监听对象 v
    // 监听 eventBus 事件，当该事件被触发时执行相应操作
  },
  event: {}, // 一个哈希表
  method1(){},
  method2(){},
  method3(){},
  autoEvent(){
    ...some code
    // v 上的事件触发时，会调用 m 上的方法，从而更改 m.data
  }  // 自动监听事件
}

~~~

## EventBus

>  eventbus 指的是公共汽车
>
> 用公共汽车的固定的站点, 处理上下车的事件, 来比做订阅与事件的分发
>
> 在编程中的eventbus通常是用来, 一发布 订阅的方式来传递数据的.
>
> 预先订阅事件, 当事件触发时可以接收大事件相关的数据

### 实现

> 准备一个类或构造函数, 用来存放, 事件和订阅者信息
>
> 在该类/构造函数的原型上添加发布和订阅的方法
>
> 发布的方法需要传入, 要发布的事件名称, 事件的数据作为参数
>
> 订阅方法需要传入, 订阅的事件名称, 事件的处理函数(回调函数)

主要流程, 通过构造函数的实例, 调用其原型链上的 订阅方法, 传入订阅的事件和方法, 存储区该实例对应属性中(这里用Map)--消息发布者, 通过传入的事件名称, 在实例的数据中取出订阅这先前传入的订阅函数, 并调用, 同时将发布的信息内容, 传入即可

~~~JavaScript
 class _EventBus {
   constructor() {
     //当实例化_EventBus时, 构造函数内的实例属性
     this._events = new Map() //这里使用 map 的 k-v分别储存 事件名-对应的订阅者信息
     //constructor中都有 prototype属性, 该属性指向构造函数, 
     //所以prototype上的方法可以访问实例上的属性
   }
 }
下面我们在原型对象上添加发布者方法
 // 发布 
 //type为发布的信息名称
 //...args为发布的信息内容, 表示可以接收多个, 最终会以数组形式存入args
 _EventBus.prototype.myPub = function (type, ...args) {
   //根据发布的事件名称获取对应的订阅者(们,这里我们为了可以有多个订阅者采用数组形式)
   let subEvents = this._events.get(type)
   //如果有, 那么遍历所有订阅者信息, 调用订阅者的方法发布信息
   //注意: 这里会给所有的同一信息订阅者发布信息, 
   //如果需要定制化, 可以订阅者打上唯一标识, 并作为发布的检索条件(就是再嵌套一层Map)
   if (subEvents) {
     //这里使用len以便减少动态的获取数组长度
     for (let i = 0, len = subEvents.length; i < len; i++) {
       if (args.length > 2) { //如果传入参数超过两个, 那么我们使用apply
         subEvents[i].apply(this, args) //使用apply直接传入数组
       } else {
         subEvents[i].call(this, ...args) //使用call原地打散
         //(注意: 如果数组存有深层次的对象, 这里只能实现浅拷贝)
       }
     }
   } else { //如果没有该事件, 添加一个, 订阅者为null
     this._events.set(type, null)
   }
 }
下面在原型上添加订阅的方法

 // 订阅
 //type为发布的信息名称
 //subEvent为订阅时, 存储再实例属性中的处理函数(回调函数, 会在发布时执行该回调)
 _EventBus.prototype.mySub = function (type, subEvent) {
   //获取type类型的处理, 如果没有, 则添加订阅
   const subEvents = this._events.get(type)
   if (!subEvents) {
     //如果type事件没有对应的发布方法, 那么就把订阅的方法传给发布者
     //这里采用数组的形式, 如果有多个订阅者
     this._events.set(type, [subEvent])
   } else {
     subEvents.push(subEvent) // 如果已有订阅者则, 直接追加
   }
   return subEvent //将该方法返回最用会用来移除指定的订阅者
 }
下面可以简单的使用了

 // 实例化
 const _eb = new _EventBus()
 // 订阅
 //参数的个数和发布的一致哦(少了接收的介绍, 多出来显示 undefined)
 _eb.mySub('eventName', (n1, n2, n3) => {
   console.log(n1, n2, n3)
 })
 _eb.mySub('evebtAge', age => {
   console.log(`接收到的年龄是 ${age}`)
 })

 // 发布消息
 _eb.myPub('eventName', 'Tom', 'Jerry', 'Tang') //Tom Jerry Tang
 _eb.myPub('evebtAge', 18) //接收到的年龄是 18
下面我们尝试实现删除订阅事件

 //移除订阅
 //subEvent是调用订阅函数 mySub 时返回的, 传入函数本体, 我们要把它揪出来删掉
 _EventBus.prototype.removeSub = function (type, subEvent) {
   //获取对应消息的所有订阅者信息
   const subEvents = this._events.get(type)
   // 遍历, 找出对应的subEvent 删除
   for (let i = 0, len = subEvents.length; i < len; i++) {
     if (subEvents[i] === subEvent) { //如果mySub返回值使用定义的变量直接接收, 这里是全等
       subEvents.splice(i, 1) //从i开始, 删除1个
       return true //结束
     }
   }
 }


~~~

## 哈希表编程

可以使用哈希表对于键值类型的数据进行存储，当程序执行相应语句时，可以到哈希表中查询到对应的语句，简化了代码。



定义：

> 表驱动方法是一种使你可以在表中查找信息，而不必用逻辑语句（if 或 case）来把他们找出来的方法。事实上，任何信息都可以通过表来挑选。在简单的情况下，逻辑语句往往更简单而且更直接。但随着逻辑链的复杂，表就变得越来越富于吸引力了。

表驱动编程的意义在于逻辑与数据的分离