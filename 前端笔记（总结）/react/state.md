# state

> state到底是同步还是异步的？

React有legacy、blocking、concurrent三种模式

主要考虑当前使用的legacy模式

## 类式组件

### 主要方法：setState

~~~js
setState(obj,callback)
~~~

setState更新时，React主要做了哪些事情？

* 首先，setState会产生当前更新的优先级lane
* React会从fiber Root根部fiber向下调和子节点，调和阶段将对比发生更新的地方，更新对比lane，找到发生更新的组件，合并state，然后触发render函数，得到新的UI视图层，完成render阶段
* 然后是commit，替换真实DOM，执行callback函数

优化方式：

1. pureComponent 可以对state和props进行浅比较，如果没有发生变化，则不会触发render
2. shouldComponentUpdate可以通过判断state变化来决定是否需要更新，需要则返回true

### setState原理解密

> 类式组件在初始化的过程中绑定了负责更新的Updater对象，对于调用setState方法。实际上是React底层调用Updater对象上的enqueueSetState方法。

* enqueueSetState到底做了些什么

  创建一个update，放入当前fiber对象的待更新队列中，开启调度更新。

* 批量更新
  react事件系统统一调度，采用事件合成的形式。

~~~js
/* 在`legacy`模式下，所有的事件都将经过此函数同一处理 */
function dispatchEventForLegacyPluginEventSystem(){
    // handleTopLevel 事件处理函数
    batchedEventUpdates(handleTopLevel, bookKeeping);
}
function batchedEventUpdates(fn,a){
    /* 开启批量更新  */
   isBatchingEventUpdates = true;
  try {
    /* 这里执行了的事件处理函数， 比如在一次点击事件中触发setState,那么它将在这个函数内执行 */
    return batchedEventUpdatesImpl(fn, a, b);
  } finally {
    /* try 里面 return 不会影响 finally 执行  */
    /* 完成一次事件，批量更新  */
    isBatchingEventUpdates = false;
  }
}
~~~

React事件执行之前通过isBatchingEventUpdates = true打开开关，事件结束之后再关闭开关。

### 同步异步渲染

同步环境下的react渲染：

~~~react
export default class index extends React.Component{
    state = { number:0 }
    handleClick= () => {
          this.setState({ number:this.state.number + 1 },()=>{   console.log( 'callback1', this.state.number)  })
          console.log(this.state.number)
          this.setState({ number:this.state.number + 1 },()=>{   console.log( 'callback2', this.state.number)  })
          console.log(this.state.number)
          this.setState({ number:this.state.number + 1 },()=>{   console.log( 'callback3', this.state.number)  })
          console.log(this.state.number)
    }
    render(){
        return <div>
            { this.state.number }
            <button onClick={ this.handleClick }  >number++</button>
        </div>
    }
} 
~~~

打印结果是：0.0.0.callback1 1,callback2 1,callback3 1

执行栈：

![03.jpg](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/478aef991b4146c898095b83fe3dc0e7~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

而在使用promise或者setTimeout的异步过程中

则会打印**callback1 1 , 1, callback2 2 , 2,callback3 3 , 3**

注意：在react18版本异步阶段也会进行合并

执行栈：

![04.jpg](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/48e730fc687c4ce087e5c0eab2832273~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

异步过程自己又开启了一个执行上下文，其中又同步分别渲染。

#### React-dom flushSync 调整render优先级

> flushSync在同步条件下，会合并之前的setSate|useState，合并后一起执行

~~~js
handerClick=()=>{
    setTimeout(()=>{
        this.setState({ number: 1  })
    })
    this.setState({ number: 2  })
    ReactDOM.flushSync(()=>{
        this.setState({ number: 3  })
    })
    this.setState({ number: 4  })
}
render(){
   console.log(this.state.number)
   return ...
}
   //最后打印3 4 1
~~~

## 函数组件中的state

### useState

~~~react
[state,dispatch] = useState(initData)
~~~

* state 提供UI，作为渲染视图的数据源
* dispacth 改变state的函数，推动函数组件化渲染的渲染函数
* initData 非函数 --> 作为state初始化的值  函数——> 作为useState初始化的值

注意事项：

由于dispacthAction是浅比较，所以不要传入相同的state，会导致视图不更新，主要是认为是指向了相同的内存空间，默认state相等

~~~react
export default function Index(){
    const [ state  , dispatchState ] = useState({ name:'alien' })
    const  handleClick = ()=>{ // 点击按钮，视图没有更新。
        state.name = 'Alien'
        dispatchState(state) // 直接改变 `state`，在内存中指向的地址相同。
    }
    return <div>
         <span> { state.name }</span>
        <button onClick={ handleClick }  >changeName++</button>
    </div>
}
~~~

解决方案：dispatchState改成dispatchState({...state})浅拷贝了一个对象，重新申请了内存空间

### dispacth更新特点

~~~react
onst [ number , setNumber ] = React.useState(0)
const handleClick = ()=>{
    ReactDOM.flushSync(()=>{
        setNumber(2) 
        console.log(number) 
    })
    setNumber(1) 
    console.log(number)
    setTimeout(()=>{
        setNumber(3) 
        console.log(number)
    })   
}
//0 0 0
~~~

函数内部的state改变，会在下一次函数组件执行时才会被更新

### useEffect 监听

~~~react
React.useEffect(()=>{
    console.log("1")
},[number])
~~~

* 第一个参数回调函数，第二个参数state
* useEffect初始化会默认执行一次

### useState原理

已单独分出

## 对比

setState和useState对比：

相同点：

* 都调用了scheduleUpdateOnFiber方法
* 事件驱动的批量更新

不同点：

* 类组件只要调用就会执行更新，pureComponent模式下才会浅比较
* useState没有专门用于监听的，要借助useEffect来实现监听
* 类组件对于state是合并处理，函数组件是重新赋值（函数的特性）