# redux

## 相关api

store.getState():用于从store获取状态数据

store.dispatch({type:'',type:''}):用于store对事件进行处理，通知reducer

store.subscribe(()=>{
    this.setState({})
})
用于检测redux中的状态变化，调用render，常用于componentDidMount
一旦执行setStae,重新调用render，重新渲染

## 异步redux

action 分为object同步、function异步

redux-thunk  将异步的函数

具体过程是

~~~jsx
export const createIncrementAsyncAction = (data,time) =>{
    return ()=>{
        setTimeout(() => {
            store.dispactch(createIncrementAction(data))
        }, time);
    }
}

//这样输出的会是func store只认对象

在store.js中引入中间件 redux-thunk 
import thunk from "redux-thunk"

安装中间件应用插件
import { createStore,applyMiddleware } from "redux"
将插件导入reducer
export default createStore(countReducer,applyMiddleware(thunk))

~~~

## react-redux

使用connect()()方法链接UI组件和容器组件,前面的括号传入的只能是函数
connect(mapStateToProps,mapDispatchToProps)(CountUI)

export default connet()(UI)

需要引入两个组件，但是store需要在上一层标签中，使用store={store}的方法引入，作为props传入容器组件中

关于外部检测状态变化，不适用react-redux就不需要在外部进行检测

向所有容器组件传递store使用Provider传递store

### 纯函数

为什么redux 中不使用数组方法对其进行处理，
因为处理数组时，数组地址不会变化，redux不识别改变，不进行渲染

纯函数和高阶函数

高阶函数：参数是函数，返回值是函数
纯函数：同样的输入，必定得到同样的输出
纯函数的约束：
1，不得改写参数数据
2，不会产生任何副作用，比如网络请求、输入输出设备之类的
3，不能调用Data.now()或者Math.random等不纯的方法

### redux开发者工具

redux DevTools

需要安装 redux-devtools-extension

在store.js中引入这个库
import {composeWithDevTools} from 'redux-devtools-extension'

奇葩的引入
export default createStore(allReducers,composeWithDevTools(applyMiddleware(thunk)))
将原先的第二个参数当作自己的参数导入

## 打包

npm run build

生成文件夹
部署到服务器

serve库以指定文件夹快速开启一个服务器

npm i serve -g

将打包的文件作为根服务器
