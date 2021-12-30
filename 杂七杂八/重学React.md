# 重学React

## jsx（htnl与js的统一）

### 简单小知识

jsx也可以被看作是一个表达式，用作参数或者变量和返回值

可以利用引号，将属性值指定为字符串字面量或者使用大括号，再属性值中插入一个javascript表达式。还有就是不饿能同时使用引号与大括号。

<img />闭合标签

jsx可以防止注入攻击，再进行渲染所有输入内容之前，默认会进行转义，确保再应用中永远不会注入那些并非自己明确编写的内容

babel会将jsx转译为一个名为React.createElement（）函数调用,实际上是创建了一个react对象

## 元素渲染

### 如何实现渲染：

将React元素渲染到DOM节点中，只需要将他们一起传入ReactDOM.render（）

### 更新渲染元素

react元素是不可变对象，代表特定时刻的UI。所以更新UI的唯一方式就是创建一个新的元素，并将其传入ReactDOM.render（）

### react只更新它需要更新的部分

## 组件及Props

### 组件的定义方法

函数组件的定义：接收唯一带有数据的props对象并返回一个React元素，这类组件被称为函数组件

可以使用声明函数或者类的方法来定义组件

~~~javascript
使用类创建组件
class Welcome extend React.Component{
    render(){
        return <h1>Hello,{this.props.name}</h1>;
    }
}
~~~



### props

当元素为用户自定义组件时，它会将JSX所接受的属性以及子组件转化为单一对象传递给组件，该对象被称作props

函数可以作为属性被调用

~~~javascript
多次渲染Welcom组件的APP组件
function Welcome(props){
    return <h1>Hello,{props.name}</h1>;
}

function App(){
    return(
    <div>
        <Welcome name="Sara"/>
        <Welcome name="Cahal"/>
        <Welcome name="Edite"/>
        </div>
    );
}

ReactDOM.render(
   <APP />,
    document.getElementById('root')
);
~~~

组件无论是使用函数声明还是通过class声明，都不能对自身的props值进行修改

所有React组件都必须像保护纯函数一样保护它们的props不被更改

## state和生命周期

state与props类似，但是state时私有的，并且完全受控与当前组件

### 将函数组件转换成class组件

1，创建一个同名的ES6class并且继承于React.Component

2,添加一个空的render（）方法

3，将函数体移动到render方法中

4，将render方法中使用this.props替换props

5,删除剩余的空函数声明



一下是一个class组件

~~~javascript
class Clock extends React.Component{
    render(){
        return(
        <div>
            <h1>Hello,world</h1>
            <h2>It is {this.props.date.tolocalTimeString()}</h2>
</div>
        );
    }
}
function tick(){
    ReactDOM.render(
    <Clock date={new Date()}/>,
    document.getElementById('root')
    );
}

setInterval(tick,1000);
~~~

### 向class组件中添加局部的state

1，把render（）方法中的this.props.date替换成this.state.date

2，添加一个class构造函数，然后在该函数中为this.state赋值

3，移除<Clock/>元素中的date属性

![image-20211121210630125](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211121210630125.png)

### 生命周期方法

#### 挂载与卸载

第一次被渲染到DOM中的时候，就为其设置一个计时器，被称为挂载

当clock组件被删除的时候，应该清除计时器，被称为卸载

#### 生命周期方法

在挂载或卸载时去执行的方法被称为生命周期方法

componentDidiMount()方法会在组件已经被渲染到DOM中后运行，

##### 计数器代码

~~~javascript
class Clock extends React.Component{
    constructor(props){
        super(props);
        this.state ={date:new Date()};
    }
}

componentDidMount(){
    this.timerID = setInterval(
    ()=> this.tick(),
        1000
    );
}

componentWillUnmount(){
    clearInterval(this.timerID);
}

tick(){
    this.setState({
        date:new Date()
    })
}

render(){
    return(
    <div>
        <h1>Hello,world</h1>
        <h2>It is {this.state.data.tolocalTimeString()}</h2>
</div>
    );
}

ReactDOM.render(
<Clock/>,
    document,getElementById('root')
);
~~~

##### set state方法

###### 注意事项

不直接修改State

State的更新可能是异步的

State的更新会被合并

###### 正式开始

重新渲染代码的正确姿势

~~~javascript
错误方式
this.state.comment="Hello"
即重新定义属性，不好使

而是应该使用setState()方法
this.setState({comment:'Hello'});
~~~



this.props和this.state可能会异步更新，所以不要依赖它们的值来更新下一个状态，用函数包装从一定程度可以解决该问题

![image-20211121214728202](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211121214728202.png)

当你调用setState()的时候，React会把你提供的对象合并到当前的state上，浅合并



#### 数据是向下流动的

组件可以选择把state作为props向下传递到它的子组件中，子组件本身无法判断他是来自于state还是props还是手动输入的

从state派生的任何数据或UI只能影响树中低于它们的组件



