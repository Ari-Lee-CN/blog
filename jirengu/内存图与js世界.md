# 内存图与js世界

## 操作系统简介

线程是更小的进程。类似于reactdom 和dom

### 开启过程

* 主机端：主板通电、读取固件、将文件中的操作系统加载到内存中运行
* 操作系统：加载操作系统内核、启动初始化进程、开启服务：（文件、安全、联网）、登录

### 启用浏览器

![image-20220104111717606](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220104111717606.png)

**js引擎与渲染引擎通信跨线程**

### js引擎

主要功能

> * 编译：js翻译成计七能够执行的字节码或机器码
> * 优化：该写代码，时器变得更为高效
> * 执行：
> * 垃圾回收

## 内存分配

window/document/setTimeout是浏览器的api

![image-20220104131419311](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220104131419311.png)

不知道什么区：存放声明

stack区：顺序存放 栈 非对象

heap区：随机存放 堆 对象 

> 对象存放在heap区便于对象随时更改，不需要预留内存空间
>
> window对象同样可以用内存图表示
>
> ![image-20220104133451222](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220104133451222.png)



个人理解

> js中对象名称就是一个声明、对象是一个内存，对象名称仅仅是用来找到内存地址，如果对象中有let定义，就会在编译时，发现这是一个声明，然后加入到声明区，找到相应的方法内存，如果一个对象保存了一堆方法，将其看作是保存了一堆内存地址

### 原型

prototype属性

![image-20220104134959625](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220104134959625.png)

解释：

> 声明区就是作用域
>
> 定义一个a数组，应该放在适当的作用域中，先编译后执行
>
> 一开始在window全局作用域，则询问作用域是否有a，没有则创建一个，然后从heap区创建一个数组对象，将这个数组对象的内存地址保存在a上
>
> 然后引擎执行，询问这个数组是否有a，有，获得地址，查询，没有这个push方法，进入到prototype方法里，prototype方法会指向原型对象（创建原型时，函数的prototype为变为原型对象，函数创建一个construtor指回），原型对象上保存了相关的方法，实例与原型对象有直接联系，与array对象（构造函数）没有直接联系

_ proto _ 可以返回原型对象

二者之间的区别：存的地址相同、prtototype指向的是方法的原型对象、_prototype_指向的是构造函数的原型对象