# React组件

本质：UI+update+常规类和函数

> 类组件与函数组件

~~~js
//类
class textClass {
    sayHello=()=>console.log("Hello,my name is alien")
}
//类组件
class Index extends React.Component {
    state = {message: "Hello , world!"}
    sayHello = ()=> this.setState({message: "hello,my name is alien"})
    render(){
        return <div style={{marginTop:'100px' }} conclick={this.sayHello}>{this.state.message}</div>
    }
}

//函数
function textFun(){
    return 'hello,world!'
}

//函数组件
function FunComponent(){
    const [message,setMessage] = useState('hello,world')
    return <div onClick={()=> setMessage('hello,my name is alien')}>{message}</div>
}
~~~

useState()

```
const [state, setState] = useState(initialState);
```

* 返回一个 state，以及更新 state 的函数。

* 在初始渲染期间，返回的状态 (`state`) 与传入的第一个参数 (`initialState`) 值相同。

* `setState` 函数用于更新 state。它接收一个新的 state 值并将组件的一次重新渲染加入队列。

**组件承载了渲染视图的UI和更新视图的setState、useState方法 **

> 在React调和渲染fiber节点的时候，根据fibert tag进行逻辑处理，识别是按照函数组件逻辑处理还是类组件逻辑处理

## 函数组件和类组件

### 类组件

#### 原理

~~~js
function Component(props, context, updater) {
  this.props = props;      //绑定props
  this.context = context;  //绑定context
  this.refs = emptyObject; //绑定ref
  this.updater = updater || ReactNoopUpdateQueue; //上面所属的updater 对象
}
/* 绑定setState 方法 */
Component.prototype.setState = function(partialState, callback) {
  this.updater.enqueueSetState(this, partialState, callback, 'setState');
}
/* 绑定forceupdate 方法 */
Component.prototype.forceUpdate = function(callback) {
  this.updater.enqueueForceUpdate(this, callback, 'forceUpdate');
}
~~~

#### **Component底层处理逻辑：**

类组件执行构造函数过程中会在实例上绑定props和context，初始化置空refs属性，原型链上绑定setState、forceUpdate方法。对于updater，React会在实例化类组件之后单独绑定update对象。setState、forceUpdate本质上调用了updater上的方法

> 为什么如果没有在construor的super函数中传递props，constructor执行上下文中就获取不到props？
>
> 答：因为绑定props是在父类Component构造函数中，执行super相当于执行Component函数

#### 类组件各部分功能

~~~js
class Index extends React.Component{
    constructor(...arg){
       super(...arg)                        /* 执行 react 底层 Component 函数 */
    }
    state = {}                              /* state */
    static number = 1                       /* 内置静态属性 */
    handleClick= () => console.log(111)     /* 方法： 箭头函数方法直接绑定在this实例上 */
    componentDidMount(){                    /* 生命周期 */
        console.log(Index.number,Index.number1) // 打印 1 , 2 
    }
    render(){                               /* 渲染函数 */
        return <div style={{ marginTop:'50px' }} onClick={ this.handerClick }  >hello,React!</div>
    }
}
Index.number1 = 2                           /* 外置静态属性 */
Index.prototype.handleClick = ()=> console.log(222) /* 方法: 绑定在 Index 原型链的 方法*/
~~~

### 函数组件

~~~js
function Index(){
    console.log(Index.number) // 打印 1 
    const [ message , setMessage  ] = useState('hello,world') /* hooks  */
    return <div onClick={() => setMessage('let us learn React!')  } > { message } </div> /* 返回值 作为渲染ui */
 }
 Index.number = 1 /* 绑定静态属性 */
~~~

**对于类组件来说，底层只需要实例化一次，实例中保存了组建的state等状态。对于每一次更新都需要调用render方法以及对应的生命周期就可以了。但是在函数组件中，每一次更新都是一次新的函数执行，吃一次函数组件的更新，里面的变量都会重新声明。**

## 组件通信方式

五种主流通信方式：

1. props和callback
2. ref
3. React-redux状态管理
4. context上下文
5. event bus 事件总线

### props和callback

~~~react
/* 子组件 */
function Son(props){
    const {  fatherSay , sayFather  } = props
    return <div className='son' >
         我是子组件
        <div> 父组件对我说：{ fatherSay } </div>
        <input placeholder="我对父组件说" onChange={ (e)=>sayFather(e.target.value) }   />
    </div>
}
/* 父组件 */
function Father(){
    const [ childSay , setChildSay ] = useState('')
    const [ fatherSay , setFatherSay ] = useState('')
    return <div className="box father" >
        我是父组件
       <div> 子组件对我说：{ childSay } </div>
       <input placeholder="我对子组件说" onChange={ (e)=>setFatherSay(e.target.value) }   />
       <Son fatherSay={fatherSay}  sayFather={ setChildSay }  />
    </div>
}
~~~

### eventBus事件总线

* 需要手动绑定和解绑
* 项目难以维护
* 违背了React数据流向原则

## 组件继承

1. 类式组件  extends
2. 函数组件字定义Hooks
3. HOC高阶组件

