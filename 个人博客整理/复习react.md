# 复习react

## react基础

### 函数式组件与类式组件

~~~jsx
//函数式组件
function MyComponent(){
    return <h2>函数式组件</h2>
}
ReactDOM.render(<MyComponent/>,document.getElementById('test'))

//类式组件
class MyComponent extends React.Component{
    render(){
        return <h2></h2>
    }
}
~~~

### 组件实例三大属性

#### state 状态

#### props 外部传入的参数

~~~jsx
//对props传入类型进行限制，外部进行限制，可以用于函数式组件
//对标签属性进行类型、必要性的限制
Person.propTypes = {
	name:PropTypes.string.isRequired, //限制name必传，且为字符串
	sex:PropTypes.string,//限制sex为字符串
	age:PropTypes.number,//限制age为数值
	speak:PropTypes.func,//限制speak为函数
}

//指定默认标签属性值
Person.defaultProps = {
	sex:'男',//sex默认值为男
	age:18 //age默认值为18
}


//也可以在组件内部进行设置，利用static关键字在实例对象上定义
static propTypes = {						name:PropTypes.string.isRequired, //限制name必传，且为字符串
	sex:PropTypes.string,//限制sex为字符串
	age:PropTypes.number,//限制age为数值
}
//指定默认标签属性值
static defaultProps = {
	sex:'男',//sex默认值为男
	age:18 //age默认值为18
}
~~~



#### ref 

//1，字符串形式

<input ref="input1" type="text" placeholder="点击按钮提示数据"/>

//2，回调形式



