# context

context优点：

* 解决了props需要每一层都手动添加props的缺陷
* 解决了改变value，组件全部重新渲染的缺陷

## context API

### createContext
基本用法：
~~~js
const ThemeContext = React.createContext(null);
const ThemeProvider = themeContext.Provider
const ThemeConsumer = themeContext.Consumer
~~~

### 提供者
Provider用法：
~~~js
const ThemeProvider = ThemeContext.Provider
export default function ProviderDemo(){
    const [contextValue,setContextValue] = React.useState({color:'#ccc',background:'pink'})
    return <div>
        <ThemeProvider value={contextValue}>
            <Son/>
        </ThemeProvider>
    </div>
}
~~~
* value属性传递给context 供给Consumer使用
* value属性改变，ThemeProvider让对应的组件重新渲染

### 消费者
#### 类组件
~~~js
const ThemeContext = React.createContext(null);
class ConsumerDemo extends React.Component {
    render(){
        const{color,background} = this.context
        return <div style={{color,background}}>消费者</div>
    }
}
ConsumerDemo.contextType = ThemeContext

const Son = <ConsumerDemo/>
~~~
只适用于类组件
#### 函数组件
~~~js
const ThemeContext = React.createContext(null)
//函数组件 -useContext方式
function ConsumerDemo(){
    const contextValue = React.useContext(ThemeContext)
    const {color,background} = contextvalue
    return <div style={{color,background}}>消费者</div>
}
const Son = ()=><ConsumerDemo/>
~~~

#### 订阅者的consumer方式
~~~js
const ThemeConsumer = ThemeContext.Consumer
//订阅消费者
function ConsumerDemo(props) {
    const {color,background} = props
    return <div style={{color,background}}>消费者</div>
}
const Son = ()=>{
    <ThemeConsumer>
        {(contentvalue)=><ConsumerDemo {...contextValue}>}
    </ThemeConsumer>
}
~~~
采用render props形式，从最近一层props中取出参数作为props混入Consumer组件

### 动态context
~~~js

function ConsumerDemo(){
    const {color, background} = React.useContext(ThemeContext)
    return <div style={{color,background}}>消费者</div>
}
const Son = React.memo(()=><ConsumerDemo/>)

const ThemeProvider = ThemeContext.Provider
export default function ProviderDemo(){
    const [contextValue,setContextValue] = React.useContext({color:'#ccc',background:'pink'})
    return <div>
        <ThemeProvider value = {contextValue}>
            <Son/>
        </ThemeProvider>
        <button onClick = { ()= setContextValue({color:'#ccc',background:'blue'})}>切换主题</button>
    </div>
}
~~~

### 其他api

#### displayName

~~~js
const MyContext = React.createContext(/* 初始化内容 */);
MyContext.displayName = 'MyDisplayName';

<MyContext.Provider> // "MyDisplayName.Provider" 在 DevTools 中
<MyContext.Consumer> // "MyDisplayName.Consumer" 在 DevTools 中
~~~

## 高阶用法

### 嵌套Provider

~~~js
const ThemeContext = React.createContext(null)
const LanContext = React.createContext(null)

function ConsumerDemo() {
    return <ThemeContext.Consumer>
        {(themeContextValue)=>(
            <LanContextValue>
                {(lanContextValue)=>{
                    const{color,background} = themeContextValue
                    return <div style={{color,background}}>消费者<div/>
                }}
            </LanContextValue>
        )}
    </ThemeContext.Consumer>
}
const Son = memo(()=> <ConsumerDemo />)
export default function ProviderDemo(){
    const [ themeContextValue ] = React.useState({  color:'#FFF', background:'blue' })
    const [ lanContextValue ] = React.useState('CH') // CH -> 中文 ， EN -> 英文
    return <ThemeContext.Provider value={themeContextValue}  >
         <LanContext.Provider value={lanContextValue} >
             <Son  />
         </LanContext.Provider>
    </ThemeContext.Provider>
}
~~~

* 两者分别保存主题信息与语言信息
* 通过Provide嵌套传递全局信息 Consumer嵌套接受信息

### 逐层传递Provider
~~~js
// 逐层传递Provder
const ThemeContext = React.createContext(null)
function Son2(){
    return <ThemeContext.Consumer>
        { (themeContextValue2)=>{
            const { color , background } = themeContextValue2
            return  <div  className="sonbox"  style={{ color,background } } >  第二层Provder </div>
        }  }
    </ThemeContext.Consumer>
}
function Son(){
    const { color, background } = React.useContext(ThemeContext)
    const [ themeContextValue2 ] = React.useState({  color:'#fff', background:'blue' }) 
    /* 第二层 Provder 传递内容 */
    return <div className='box' style={{ color,background } } >
        第一层Provder
        <ThemeContext.Provider value={ themeContextValue2 } >
            <Son2  />
        </ThemeContext.Provider>
    </div>

}

export default function Provider1Demo(){
    const [ themeContextValue ] = React.useState({  color:'orange', background:'pink' })
     /* 第一层  Provider 传递内容  */
    return <ThemeContext.Provider value={ themeContextValue } >
        <Son/>
    </ThemeContext.Provider> 
}
~~~
* 全局只有一个ThemeContext,两次用provider传递两个不同的context
* 组件获取context时，会获取离当前组件最近的上一层Provider
* 下一层Provider会覆盖上一层Provider
