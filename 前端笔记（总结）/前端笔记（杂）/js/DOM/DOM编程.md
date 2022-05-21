# DOM编程

## 简介

### api

document.getElementById()

document.getElementsByTagName(‘div’)[]

.byclassname

.querySelector()

.querySelectorAll()[]

主要使用query

### 获取特定元素

document.documentElement

document.head

documenr.body

window

document.all  是个falsy值

### 六层DOM原型链

![image-20220115200011284](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220115200011284.png)

### 节点的增删改查

#### 增

document.createElemenr() 创建一个标签节点

document.createTextNode()创建一个文本节点

div1.appendChild(txet1)标签插入文本

div1.innerText=‘你好’

#### 删

childNode.remove()  

后续想要删除，将移除的node设置为null

#### 改

获取href

> test.href 获取的href容易被浏览器等加工
>
> test.getAttribute(‘href’) 获取初始的href值

改文本内容

> div.innerText       div.textContent 修改文本内容
>
> div.innerHTML 修改HTML内容
>
> div.innerHTML   div.appendChild  改标签

#### 查

> 查爸爸  node.parentNode  node.parentElement
>
> 查爷爷 node.parentNode.parentNode
>
> 查子代 
> node.childNodes(这个会包括空格等文本节点，不推荐使用)  
> node.children
>
> 查兄弟姐妹 node.parentNode.childNodes  还有就是要排除自己

### DOM跨线程操作

attribute和property的区别

property是渲染线程中的属性

attribute是js执行线程中的属性，支持持字符串

## jQuery

* 通过dom产生的是dom对象，使用domapi
* 通过jQuery产生的是jQuery对象，只能使用jquery的api
* dom api elDiv1  是dom对象 $div是jQuery对象

### 设计模式

* 不用new的构造函数
* （）根据参数个数不同实现不同功能，重载
* 闭包隐藏细节
* 别名
* 针对不同浏览器实现不同的功能 适配器
* 读写设置 getter setter

## DOM事件委托

### 事件捕获与事件冒泡

* 由大到小是事件捕获，由小到大是事件冒泡

* addEventListener 事件捕获  默认是事件冒泡 第三个参数为true则是事件捕获

* 同时设置捕获和冒泡，先捕获再冒泡
* 取消冒泡  e.stopPropagation()
* 有些事件不支持取消冒泡 

### target和currenttarget

e.target是用户操作的元素

e.currentTarget是程序员监听的元素

this是 e.currentTarget 

### 阻止滚动

滚动条位于document之上

~~~
x.addEvebtListener(‘wheel’,(e)=>{
	e.preventDefault()
}
//鼠标滚轮无法使用
//再通过css设置鼠标滚动条无法滚动



//禁用触屏滚动
x.addEventListener('touchstart',(e)=>{
	e.preventDefault()
})
~~~

阻止scroll默认动作时没有用的，因为先有的滚动才有的滚动事件

要组织滚动可以阻止wheel和touchstart默认动作，再设置overflow：hidden取消滚动条

### 自定义事件

