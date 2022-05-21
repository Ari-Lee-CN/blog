尚硅谷react全家桶

## 简介

### 引入

~~~

引入react核心库
<script type="text/javascript" src="../js/react.development.js"></script>
引入react-dom 用于支持react操作DOM
<script type="text/javascript"src="../js/react-dom.development.js"
引入babel，用于将jsx转化为js.


<script type="text/babel">
/*表示引入babel用babel解释jsx*/
//1，创建虚拟DOM
const VDOM = <h1>Hellp,React</h1>
//2，渲染渲染DOM到页面
ReactDOM.render(渲染的虚拟DOM，容器)
~~~

## jsx（javascript+xml)

jsx调用js要用{}括起来

定义虚拟DOM不写引号

jsx中class不能用，要使用classname形式

内联样式要用style={{key：value}}的形式去写（双中括号哦）

一个虚拟DOM不能同时包含多个根标签；除非用一标签把它们包装一下

标签必须闭合，即使是之前不闭合的标签也是

标签首字母，
如果是小写字母开头，则将该标签转为html同名元素，若html无同名元素，则报错。
如果是大写字母开头，则react将渲染相应的组件，若组件没有定义，则报错。



jsx写注释，先用{括起来表示是js语句，然后再用js的方法注释起来}


调用表达式，调用语句或者代码是错误的

练习：

~~~jsx
模拟数据
const data={}

创建真实DOM
const VDOM =(
<div>
    <h1>1</h1>
    <ul>
    {
     注意js语句（代码）与表达式之间的区别
     一个表达式会产生一个值，可以放在任何一个需要值的地方
     下面这些都是表达式：
     a  a+b  demo(1) arr.map() function test(){}
            这些他都有返回值
     下面都是语句（代码）
     if（）{}
     for（）{}
     switch（）{case：}
            都是控制代码走向而不是返回值
            
          
            data.map((item,index)=>{
                return <li key={index}>{item}</li>
            }
                     遍历时都要有一个唯一值key
        )
    </ul>  
 </div>
)
~~~

搞清楚表达式、语句、代码之间的区别

**遍历时每个li都要有一个唯一值key**



## 虚拟DOM

### 简介

虚拟DOM

本质上是objet类型对象

虚拟DOM属性相对于真实DOM属性更少，因为其在react内部使用，属性相对较少

虚拟DOM最终会被React转化为真实DOM，呈现在页面上



## 模块与组件化

### 模块与组件

模块：向外提供特定功能的js程序，一般就是一个js程序
可以复用js，简化js的编写，提高js运行效率，只是指js。

组件：用来实现局部功能效果的代码和资源的集合，包括js，css，html等。

### 函数式组件

必须要有返回值

##### 简单组件（函数定义的）

~~~javascript
function Demo(){
    console.log(this);
    //此时的this是underfined，因为此时的this在babel的处理之下处于严格模式
        return <h2>我</h2>
}
ReactDOM.render(<Demo/>,document.getElementById('test'))

react解析组件标签，找到了MyComponent组件，
发现组件是使用函数定义的，随后调用该函数，将返回的虚拟DOM转化为真实DOOM，呈现在页面中
~~~

复习一个规则：标签首字母如果是小写字母开头，则将该标签转为html中同名元素，若html中无该标签对应的同名元素，则报错；如果是大写字母开头，react就去渲染对应的组件，若组件没有定义，则报错。

所以这里使用<Demo/>  包括前面定义函数也是，要用大写。标签必须闭合

##### 其他细节

babe在转换嵌入js代码时，会开启严格模式，此时的this不会指向全局变量windows

##### 类式组件（复杂组件）

创建类式组件必须要继承其他类

必须有render渲染

render必须要有返回值

~~~
class MyComponent extends React.Component{
    render(){
    renturn <h2>111</h2>
    }
}
ReactDOM.render(<MyComponent/>,document.getElementById('test'))
//render放在类的原型对象上，供实例使用
实际上渲染了react标签那个实例
~~~

**类式组件是状态组件，函数式组件不是状态组件**

实例都没有，谈什么状态

## 组件实例的三大属性

## state

~~~javascript
  初始化状态函数，所以要初始化构造器
<script type="text/babel">
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
        }
    }
    render(){
        console.log(this);
        renturn <h1>{this.atate.isHot?'炎热'：‘凉爽’}</h1>
    }
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))
</script>


~~~





#### 关于虚拟DOM渲染部分有两种写法

~~~javascript
render(){
    renturn<h1>今天天气很{this.state.isHot?'炎热‘：’凉爽'}</h1>
}
    //提前声明状态
render(){
    const{isHot}=this.state
    renturn <h1>今天天气很{isHot?'炎热':'凉爽'}</h1>
}
~~~



### 原生事件绑定

~~~javascript
<!DOCTYPE html>
<html>
    <head>
      <meta charset="UTF-8"/>
      <title>Document</title>
    </head>
    <body>
          <button id='btn1'>按钮一</button>
          <button id="btn2">按钮二</button>
<button onClick={demo()}>按钮三</button>

<script type="text/javascript">
const btn1 =document.getElementById('btn1')
    btn1.addEventListener('click',()=>{
        alert('按钮一被点击了')
    })
const btn2=document.getElementById('btn2')
    btn2.onclick=()=>{
        alert('按钮2被点击了')
    }
function demo(){
    alert('按钮3被点击了')
}
</script>
</body>
</html>


//react更推荐第三种写作形式
~~~

#### 原生写法与react写法不同

**React重写原生中的事件名称，例如onclick，会变成onClick**

~~~JavaScript
<h1 onclick='demo()'></h1>
//这是原生中的写法，react会有所不同
<h1 onClick={demo()}></h1>
//原生中的写法 onclik不会被识别，且demo会被识别为字符串，但是点击无效
<h1 onClick={demo}></h1>
//如果加上()就说明是函数调用，但是没有设置返回值，调用结果就是undefined，不加说明是赋值语句，点击时调用
~~~

#### this问题

如果设置事件函数，定义函数时this指向全局作用域，但是由于babel的存在，自动为严格模式，严格模式下  全局作用域为undefined。

正常情况下，在react中，实例是在构造类构造函数的自定义html标签时自动创建的，外部的函数无法访问内部的this值。

~~~javascript
script type="text/babel">
let that
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
            that = this
        }
    }
    render(){
        console.log(this);
        renturn <h1>{this.atate.isHot?'炎热'：‘凉爽’}</h1>
    }
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))

funtion demo(){
    console.log(that.state.isHot);
}
</script>
~~~

在构造器外部定义一个that值，将this值传给that，然后外部函数调用tha就行了

如此太麻烦了，能不能将事件响应函数整合进组件里

~~~javascript
script type="text/babel">
let that
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
            that = this
        }
    }
    render(){
        console.log(this);
        renturn <h1>{this.atate.isHot?'炎热'：‘凉爽’}</h1>
    }
    funtion demo(){
    console.log(that.state.isHot);
}
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))


</script>
~~~

所示方法是不合理的，因为类中的大括号不像是函数中的大括号，可以向其中加入任何东西

~~~javascript
script type="text/babel">
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
        }
    }
    render(){
        const{isHot}=this.state
        console.log(this);
        renturn <h1 onClick{this.demo}>{isHot?'炎热'：‘凉爽’}</h1>
    }
     demo(){
    console.log(this.state.isHot);
}
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))


</script>
~~~

此时demo就是构造函数中的一般方法，被放在原型对象上，供实例使用，**其使用必须通过实例来实现**(this.方法名)

但是此时还是无法正确显示，原因在于，demo方法并没有通过实例调用方法，因而this指向的不是实例

##### 类中方法this指向

~~~javascript
//直接调用和实例调用
class Person{
    constructor(name,age){
        this.name=name
        this.age=age
    }
    person(){
        console.log(this);
    }
}
}
const p1 = new Person('Tom',18)
p1.person()
//此时是通过实例调用person方法，p1本身没有person方法，到原型上去找
const x = p1.study
x()
//此时是将p1.person赋值给了x，没有调用study方法，x是study属性，即使p1没有，也可以通过原型链读取到，所以这个是直接调用。此时this应该指向window全局，由于是处于严格模式下，所以应该是undefined。
~~~

由于demo是作为onClick的回调，所以不是通过实例调用的，而是直接调用

##### 如何解决

~~~javascript
script type="text/babel">
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
        }
        this.demo = this,demo.bind(this)
    }
    render(){
        const{isHot}=this.state
        console.log(this);
        renturn <h1 onClick{this.demo}>{isHot?'炎热'：‘凉爽’}</h1>
    }
     demo(){
    console.log(this.state.isHot);
}
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))


</script>
~~~

this.demo = this,demo.bind(this)加上这个问题就能解决

bind的作用：创建一个函数，修改该函数的this对象

那么上述句子的含义是：位于原型对象上的demo被调用生成一个函数，函数的this值被赋予给了实例对象，然后这个函数被赋值给了实例的demo方法。相当从原型向实例复制一个？

如果复制过去之后，方法名改了，比如原型上是demo，示例上是democopy，那么应该调用this.copy

##### set.State

~~~javascript
script type="text/babel">
class Weather extend React.Component{
    constrcutor(props){
        super(props)
        this.state={
            isHot:ture
        }
        this.demo = this,demo.bind(this)
    }
    render(){
        const{isHot}=this.state
        console.log(this);
        renturn <h1 onClick{this.demo}>{isHot?'炎热'：‘凉爽’}</h1>
    }
     demo(){
     const isHot = this.state.inHot
     this.setState({isHot:!isHot})
        
    console.log(this.state.isHot);
}
}
//渲染组件到页面
ReactDOM.render(<Weather/>,document.getElementById('test'))d
</script>
~~~

react不支持直接更改，状态是不可以直接更改的，借助内置API更改

##### 简写方式



~~~javascript
标准形式
<script type="texr/babel">
    class Weather extend React.Component{
        constructor(props){
            super(props)
            this.state={
                isHot:ture，
                wind:'微风'
         }
    this.weatherChange=this.weatherChange.bind(this)
  }
   render(){
       const isHot = this.state.isHot
       return<h1 onClick{this.weatherChange}>{isHot?'炎热':'凉爽'}</h1>
   }
   weatherChange(){
       const isHot = this.state.isHot
       this.setState({isHot:!Hot})
   }
}
ReactDOM.render(<Weather/>,document.getElementById('test'))
~~~

自定义方法一般是负责组件和人进行交互。

~~~javascript
简写形式
<script type="texr/babel">
    class Weather extend React.Component{
        state = {isHot:false,wind:'微风'}
        //初始状态
        render(){
            const{isHot,wind} = this.state
            return <h1 onClick={this.changeWeather}>今天天气很{isHot ?'炎热'：'凉爽'},{wind}</h1>
        }
        changeWeather = ()=>{
            const isHot = this.state.isHot
            this.setState({isHot:!isHot})
        }
}
ReactDOM.render(<Weather/>,document.getElementById('test'))

~~~



### state总结

组建自定义的方法中this为undefined，如何解决
a，强制绑定this，通过函数对象的bind对象
b，箭头函数绑定

状态数据不能直接修改更新

## props

### 基本使用

~~~javascript
<script type="texr/babel">
    class Person extend React.Component{}
        render(){
            console.log(this);
            const{name,age,sex}=this.props
            return(
            <ul>
            <li>姓名：{name}</li>
            <li>性别：{sex}</li>                         <li>年龄：{age}</li>
                </ul>
            )
        }           
}
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')
</script>
~~~

语法糖

ReactDOM.render(<Person name="1" age="2" sex="3"/>,document.getElementById('test')
</script>

const p = {name:’老刘}，age:18,sex:”女”}
ReactDOM.render(<Person{...p}/>,document.getElement(‘test3’))

二者是等价的



~~~javascript
<script type="texr/babel">
    class Person extend React.Component{}
        render(){
            console.log(this);
            const{name,age,sex}=this.props
            return(
            <ul>
            <li>姓名：{name}</li>
            <li>性别：{sex}</li>                         <li>年龄：{age}</li>
                </ul>
            )
        }           
}
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')

const p = {name:'老刘'，age:18,sex:'女'}
console.log('@',...p);
ReactDOM.render(<Person{...p},document.getElementById('test3'))

~~~

这里的...p 是对象调用，按理说不可以，但是react+babel做到了，但是仅限于html标签内

### 对props进行限制

#### 使年龄加一

~~~javascript
<li>年龄：{age+1}</li>
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')
ReactDOM.render(<Person name="1" age="1" sex=""/>,document.getElementById('test')

const p = {name:'老刘'，age:18,sex:'女'}
console.log('@',...p);
ReactDOM.render(<Person{...p},document.getElementById('test3'))
~~~

这样最后分别为11   11  2

因为前两者都是字符串，第三个为数字

~~~javascript
ReactDOM.render(<Person name="1" age={1} sex=""/>,document.getElementById('test')
ReactDOM.render(<Person name="1" age={1} sex=""/>,document.getElementById('test')

const p = {name:'老刘'，age:18,sex:'女'}
console.log('@',...p);
ReactDOM.render(<Person{...p},document.getElementById('test3'))
~~~

如果直接把前两者的“”去掉就会导致语法错误，要在外面套一个{}，但是容易导致错误

Person.propTypes 能限制相关属性是否必传、类型等

~~~javascript
Person.propTypes = {
    name: React.PropTypes.string
    //限制只能使用string类型
    name: React.PropTypes.isRequired
}
Person.defaultProps = {
    sex:''
}
//设置默认值

ReactDOM.render(<Person name="jerry" speak={speak}"/>,document.getElementById('test1'))
//此时就传入了一个speak方法，也可以对speak方法进行限制

Person.propTypes = {
    speak:PropTypes.funtion
}
//注意propTypes和PropTypes的区别
//前面的小写可以，但是function本身是一个关键字，不能随便用
    speak：PropType.func
~~~

PropType属性一直存在负荷比较大，所以在16版本之后react中就没了，要用相关库

#### props简写

~~~javascript
<script type='text/babel'>
    class Person extends React.Component{
        static propTypes = {
            name:PropType.string.isRequired,
            sex:PropType.string,
            age:PropType.number,
            speak:PropType.func, 
        }
        static defaultProps = {
            sex:'男'，
            age:18
        }
render(){}
    }
~~~

![image-20211127214820928](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211127214820928.png)



### 组件中的props

构造器是否接收props以及是否传递给super，取决于，是否希望在构造器中通过this访问props

#### 函数式组件

~~~javascript
<script type='text/babel'>
    function Person (props){
    const {name,age,sex} = props
    return(
    <ul>
        <li>姓名:{name}</li>
<li>性别:{sex}</li>
<li>年龄：{age}</li>
</ul>
    )
}

Person.proTypes = {
    name:PropTypes.string.isRequired,
    sex:PropTypes.string,
    age:PropTypes.number,
}

Person.defaultProps = {
    sex:'男',
    age:18
}
~~~

添加属性时，可以直接像函数添加属性那样子操作

#### props总结

props 属性的缩写，从外部向内部传递，内部别修改

## ref属性

~~~javascript
<script type="text/babel">
    class Demo extends React.Component{
        showData =>{
            const input = document.getElementById('input1')
            alert(input.value)
        }
        render(){
            renturn(
            <div>
                <input id="input1" type='text' placeholder='点击按钮提示数据'/>&nbsp
                <button conClick={this.showData}>点我提示数据</button>
            &nbsp;
                <input type="text" placeholder='失去焦点提示数据'/>
             </div>
                )
        }
    }
ReactDOM.render(<Demo/>,document.getElementById("test"))
~~~

~~~javascript
<script type="text/babel">
    class Demo extends React.Component{
        showData =>{
            const {input1} = this.refs
            alert(input1.value)
        }
//以上渲染在真实DOM中
showData2 =>{
            const {input1} = this.refs
            alert(input1.value)
        }
        render(){
            renturn(
            <div>
                <input ref="input1" type='text' placeholder='点击按钮提示数据'/>&nbsp
                <button ref='button1' conClick={this.showData}>点我提示数据</button>
            &nbsp;
                <input ref="input2" onBlur={this.showData2} type="text" placeholder='失去焦点提示数据'/>
             </div>
                )
        }
    }
ReactDOM.render(<Demo/>,document.getElementById("test"))
~~~

ref就是取代id的作用的，理解为标识,所有数据被收集到ref属性中，以键值对的形式。

写在标签里的是ref，收集所得refs

### 多种形式的refs

字符串形式ref将被废弃，存在效率问题

#### 回调形式ref

~~~javascript
<script type="text/babel">
    class Demo extends React.Component{
        showData = () =>{
      
        }
          
        render(){
            renturn(
            <div>
                <input ref={a=> this.input1 = a} type='text' placeholder='点击按钮提示数据'/>&nbsp
                <button ref='button1' conClick={this.showData}>点我提示数据</button>
            &nbsp;
                <input ref="input2" onBlur={this.showData2} type="text" placeholder='失去焦点提示数据'/>
             </div>
                )
        }
    }
ReactDOM.render(<Demo/>,document.getElementById("test"))
~~~

ref = { a=> this.input1 = a }是回调函数

##### 回调次数

~~~javascript
<script type="text/babel">
    class Demo extends React.Component{
        state = { isHot :true}
        showData = () =>{
      
        }
          
        render(){
            renturn(
            <div>
                <h2>天气很{isHot?炎热：凉爽}</h2>
                <input ref={(currentNode)=>{this.input = currentNode;console.log('@',currentNode);}} 
                <input ref=this.saveInput type="text"/>type='text' />&nbsp
                <button onclick='this.showData'>点我提示数据</button> &nbsp;
<button onclick='this.changeWeather'>点我提示数据</button> &nbsp;
             </div>
                )
        }
    }
ReactDOM.render(<Demo/>,document.getElementById("test"))
~~~



将会回调两次，一次传入null，第二次再传入一个带属性的新的实例对象





类绑定函数

~~~javascript
<input ref=this.saveInput type="text"/>
~~~

这种方式是一个属性放在实例自身，可以有效减少调用次数



#### creatrEef API

调用后返回一个容器，该容器可以存储被ref所标识的节点，该容器是专人专用，只能存一个

~~~javascript
myRef = React.createRef()

render(){
    return(
    <div>
        <input ref={this.myRef} /》
    )
}
~~~

### 总结ref

字符串形式ref  