# react路由

单个完整页面，不会刷新页面，只会局部刷新
数据需要ajax获取，并且在前端异步体现
切换组件实现局部刷新

## 路由工作原理

1，修改地址
2，检测地址改变
3，渲染

一个路由就是一个映射关系key/value
key/value 分别对应 path和component/function

### 前端路由工作原理

//1，直接调用history身上的api
前端路由的基石history BOM身上的
借助其他方式操作BOM身上的histtory
let history = History.createBrowerHistory()

路由链接 添加历史记录但是不跳转

历史记录栈结构

2，Hash值
let history = History.createHashHistory()
多了#标志

## react-router 基本使用

分三类：web any native

import {Link} from 'react-router-dom'
按需引入组件，

~~~jsx
<Link className="list-group-item" to='/about'>About</Link>
//在这里，to属性不识别大小写，所以就写小写就ok了

路由器分为browerrouter、hashrouter

注册路由书写

~~~jsx
<BrowerRouter>
<Route path='/about' component={About} />
</BrowerRouter>
~~~

在最外层index套一个路由

## 路由组件与一般组件

~~~jsx
<home> 一般组件
<Route path="" component={}>路由组件
~~~

写法、存放位置、接收的props

路由组件接收固定三个属性

history
    go
    goBack
    goForward
    push
    replace

location
    pathname
    search
    state

match
    params
    path
    url

### Navlink

Navlink 对点击的追加active属性
更换样式 activeClassName

封装NavLink

公共部分封装，私有部分写在标签里

NavLinke标签体里的内容会称为传入参数的一部分，this.props.children

标签的children属性会传递给组件，组件也可以使用闭合标签，结果会根据闭合标签的children属性来生成内容

activeClassName指定样式

### switch

嵌套中一个路由对应一个组件

如果不用这个标签，会渲染所有该路由对应的组件

### 样式丢失

请求路径层级错误，请求不到会返回index.html

涉及到路径的是否相对问题
1，./css/bootstrap.css相当于相对路径，在当前文件下，读取时也会读取/atguigu/bootstrap.css之类的

/css/bootstrap.css则不同,是当前端口下的css
2，%   % 数书写绝对路径
3，或者使用hashrouter 都是出现在#后 所以也可以解决

### 精准匹配与模糊匹配

模糊匹配，要的你都有

准确匹配 exact={true}

### redirect

如果都匹配不上就用redirct 也可以用于最初界面展示

## 多级路由

路由的匹配是按照顺序注册的

挨个进入路由，多次注册路由
注册子路由要写上夫路由的path

## 路由组件的传参params

### params

params  

~~~jsx
//链接
<Link to={`/home/message/detal/${msgObj.id}/${msgObj.title}`}>{msgObj.title}</Link>
//注册路由
<Route Path="/home/message/detail/:id/:title" component={Detail}/>

//接收参数
 const{id,title} = this.props.match.params
~~~

一个根据id查找内容的函数

~~~JavaScript
 const findresult = DetailData.find((detailObj)=>{
            return detailObj.id === id
        })
~~~

### search参数(不推荐使用了)

~~~jsx
<Link to={`/home/message/detail/?id=${msgObj.id}&title=${msgObj.title}`}>{msgObj.title}</Link>

//search参数不需要声明接收

//接收到的参数为一堆字符串，需要处理，可以使用querystring库中的qs方法来进行处理


~~~

qs方法可以实现urlencoded和对象之间的转化
qs.stringfy(obj) 将对象转化为urlencoded

qs.parse(str) 将urlencoded转化为对象

### state参数

不同于组件的状态

~~~jsx

<Link to={{pathname:'/home/message/detail',state:{id:msgObj.id,title:msgObj.title}}}>{msgObj.title}</Link>

<Route path='home/message/detail' component={Detail}>
~~~

to里面定义了一个对象，对象包括了pathname、state

state也不需要声明接收

