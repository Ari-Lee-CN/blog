# js基础

## 原始数据类型

> boolean、null、number、symbol、string、undefied

* 原始数据类型都是值，没有函数调用
* string调用浮点数会出啊休闲bug 0.1+0.2
* null其实不是对象类型，虽然type of null 输出的是object

## 对象类型

> 对象类型存储的是指针，

## type of和instance of

type of能够判断原始数据类型和是否是function或者object，就是判断一个内存的类型。

instance of 是通过作用链来进行判断的，能够判断对象类型

## this

> 调用函数的地方

**this调用优先级**

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/11/15/16717eaf3383aae8~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp)

## == 与 ===区别

== 二者会进行类型转换，首先对比null、undefied其次对比string、number 然后是boolean 最后是objec转换

## 深浅拷贝与深浅复制

Object.assign 执行的就是钱老被，指回拷贝所有属性值到新的对象中，没有拷贝地址

loadash深拷贝

JSON.parse(JSON.stringify(object))两次json转换来实现深拷贝，但是会忽略undefied、symbol、不能序列化函数、不能解决循环引用的对象

~~~js
//循环引用
let obj = {
  a: 1,
  b: {
    c: 2,
    d: 3,
  },
}
obj.c = obj.b
obj.e = obj.a
obj.b.c = obj.c
obj.b.d = obj.b
obj.b.e = obj.b.c
let newObj = JSON.parse(JSON.stringify(obj))
console.log(newObj)
~~~

~~~js
//不能正常序列化，忽略掉函数和undefied
let a = {
  age: undefined,
  sex: Symbol('male'),
  jobs: function() {},
  name: 'yck'
}
let b = JSON.parse(JSON.stringify(a))
console.log(b) // {name: "yck"}
~~~

