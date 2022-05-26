# jsx

## 其他

>老版本的 React 中，为什么写 jsx 的文件要默认引入 React?
~~~
import React from 'react'
function Index(){
    return <div>hello,world</div>
}
~~~
：因为 jsx 在被 babel 编译后，写的 jsx 会变成上述 React.createElement 形式，所以需要引入 React，防止找不到 React 引起报错。

## jsx的编译

>jsx被编译成相应的React.createElement()形式，然后React Element对象的每一个子节点都会形成一个与之对应的fiber对象，然后通过sibling、return、child将每一个fiber对象联系起来

~~~jsx
const toLearn = {'react','vue','webpack','node.js'}

const TextComponent  = ()=><div>hello,i am function component</div>

class Index extends React.Component{
    status = false /*这里指状态*/
    renderFoot = () => <div>i am foot</div>
    render(){
        return <div style={{marginTop:'100px'}}
            {/*element元素类型*/}
            <div>hello,world</div>
            {/*fragment 类型  列表输出*/}
            <React.Fragment>
                <div>👽👽</div>
            </React.Fragment>
            {/*text文本类型*/}
            my name is alien
            {/*数组节点类型*/}
            {toLearn.map(items => <div key={item}> let us learn {item}</div>)}
            {/*组件类型*/}
            <TextComponent>
            {/*三元计算*/}
            {this.status ? <TextComponent/> : <div>三元运算</div>}
            {/*函数执行*/}
            {this.renderFoot()}
            <button onClick = { ()=>console.log(this.render()) }>打印render后的内容</button>
        </div>  
    }
}
~~~



### jsx 被babel处理后编译为react.element

![jsx_03.jpg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/63f79f34c6184f46bd628ea24351a40a~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)
被编译之后

React.createElement用法

~~~react
React.createElement(
    type,
    [props],
    [...children]
)
~~~

createElement 参数:

* 第一个参数:如果时组件类型，则传入组件对应的类或者函数；如果是dom元素类型，传入div或者span之类的字符串；
* 第二个参数：props选项就是设置和获取标签上的属性值的
* 第三个参数：children

例：

~~~react

<div>
   <TextComponent />
   <div>hello,world</div>
   let us learn React!
</div>
~~~
上面的代码会被 babel 先编译成：
~~~react

 React.createElement("div", null,
        React.createElement(TextComponent, null),
        React.createElement("div", null, "hello,world"),
        "let us learn React!"
    )
~~~

### createElement 外层div被处理为react element对象

打印出render的内容后

![jsx_01.jpg](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b03ba798b2c2471eb00e5ecab6fe91fe~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

jsx转换规则

| `jsx`元素类型     | `react.createElement` 转换后                      | `type` 属性                   |
| ----------------- | ------------------------------------------------- | ----------------------------- |
| `element`元素类型 | `react element`类型                               | 标签字符串，例如 `div`        |
| `fragment`类型    | `react element`类型                               | `symbol` `react.fragment`类型 |
| 文本类型          | 直接字符串                                        | 无                            |
| 数组类型          | 返回数组结构，里面元素被`react.createElement`转换 | 无                            |
| 组件类型          | `react element`类型                               | 组件类或者组件函数本身        |
| 三元运算 / 表达式 | 先执行三元运算，然后按照上述规则处理              | 看三元运算返回结果            |
| 函数执行          | 先执行函数，然后按照上述规则处理                  | 看函数执行返回结果            |

### React底层调和处理成fiber类型

> 最终在调和阶段，上述React element对象的每一个子节点都会形成一个与之对应的fiber对象，然后通过sibling、return、child指针将对象之间连接起来。

React针对不同React element对象会产生不同tag种类的fiber对象

```js
export const FunctionComponent = 0;       // 函数组件
export const ClassComponent = 1;          // 类组件
export const IndeterminateComponent = 2;  // 初始化的时候不知道是函数组件还是类组件 
export const HostRoot = 3;                // Root Fiber 可以理解为根元素 ， 通过reactDom.render()产生的根元素
export const HostPortal = 4;              // 对应  ReactDOM.createPortal 产生的 Portal 
export const HostComponent = 5;           // dom 元素 比如 <div>
export const HostText = 6;                // 文本节点
export const Fragment = 7;                // 对应 <React.Fragment> 
export const Mode = 8;                    // 对应 <React.StrictMode>   
export const ContextConsumer = 9;         // 对应 <Context.Consumer>
export const ContextProvider = 10;        // 对应 <Context.Provider>
export const ForwardRef = 11;             // 对应 React.ForwardRef
export const Profiler = 12;               // 对应 <Profiler/ >
export const SuspenseComponent = 13;      // 对应 <Suspense>
export const MemoComponent = 14;          // 对应 React.memo 返回的组件
```

**jsx最终的fiber结构图**

![jsx7.jpg](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/873f00b1255d4f5f8dac4954cf37dc9f~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

> * child、return、sibling分别是三个指针
> * map数组结构子节点会被转换成fragment结构，在最外层加上fragment
> * map返回结构，作为fragement子节点
> * index component fiber 继承了index类

## 可控render

> 上述代码不足：
>
> * 返回的children虽然是一个数组，但是其中的数据类型是多种多样的，写一个组合模式或者 render props ,或者公共组件，开源组件，可能会报错。
> * 无法对React element元素进行可控化操作

改进方案：

1. 将上述children做扁平化处理，将数组类型的子节点打开；
2. 干掉children中文本类型节点
3. 向chidren最后插入 say goodbye 元素
4. 克隆新的元素节点并渲染

~~~jsx
const toLearn = {'react','vue','webpack','node.js'}

const TextComponent  = ()=><div>hello,i am function component</div>

class Index extends React.Component{
    status = false /*这里指状态*/
    renderFoot = () => <div>i am foot</div>
    controlRender=()=>{
        const reactElement = (
            <div style={{ marginTop:'100px' }} className="container"  >   
                 { /* element 元素类型 */ }
                <div>hello,world</div>  
                { /* fragment 类型 */ }
                <React.Fragment>      
                    <div> 👽👽 </div>
                </React.Fragment>
                { /* text 文本类型 */ }
                my name is alien       
                { /* 数组节点类型 */ }
                { toLearn.map(item=> <div key={item} >let us learn { item } </div> ) } 
                { /* 组件类型 */ }
                <TextComponent/>  
                { /* 三元运算 */  }
                { this.status ? <TextComponent /> :  <div>三元运算</div> }  
                { /* 函数执行 */ } 
                { this.renderFoot() }  
                <button onClick={ ()=> console.log( this.render() ) } >打印render后的内容</button>
            </div>
        )
        console.log(reactElement)
        const { children } = reactElement.props
        /* 第1步 ： 扁平化 children  */
        const flatChildren = React.Children.toArray(children)
        console.log(flatChildren)
        /* 第2步 ： 除去文本节点 */
        const newChildren :any= []
        React.Children.forEach(flatChildren,(item)=>{
            if(React.isValidElement(item)) newChildren.push(item)
        })
        /* 第3步，插入新的节点 */
        const lastChildren = React.createElement(`div`,{ className :'last' } ,`say goodbye`)
        newChildren.push(lastChildren)
        
        /* 第4步：修改容器节点 */
        const newReactElement =  React.cloneElement(reactElement,{} ,...newChildren )
        return newReactElement
    }
    render(){
        return this.controlRender()
    }
                
}

~~~

#### 扁平化数组

~~~jsx
const flatChildren = React.Children.toArray(children)
console.log(flatChildren)
~~~



![jsx5.jpg](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/901d83b9ee574e74bf982336f48813cf~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

ReactChildren.toArray额可以扁平化、规范化React.element的children组成的数组，只要children中的数组元素被打开，对遍历children很有帮助，还可以深层次flat

#### 遍历children，删除文本节点

~~~jsx
const newChildren :any= []
React.Children.forEach(flatChildren,(item)=>{
    if(React.isValidElement(item)) newChildren.push(item)
})
~~~

* React.isValidElement 这个方法可以用来检测是否为 React element 元素，接收一个参数——待验证对象，如果是返回 true ， 否则返回 false 。
*  `React.Children.forEach` = `React.Children.toArray` + `Array.prototype.forEach`。

#### 插入节点

~~~jsx
const lastChildren = React.createElement(`div`,{ className :'last' } ,`say goodbye`)
newChildren.push(lastChildren)
//相当于newChildren.push(<div className="last" >say goodbye</div>)
~~~

#### cloneElement创建新的容器元素

createElement时将jsx变成element对象，cloneElement的作用是以element元素作为样板克隆并返回新的React element 元素。返回元素的props是将新的props与原始元素的props浅层合并后的结果。

~~~
const newReactElement =  React.cloneElement(reactElement,{} ,...newChildren )
~~~

## Bable解析过程

> SX 语法实现来源于这两个 babel 插件：
>
> - @babel/plugin-syntax-jsx ： 使用这个插件，能够让 Babel 有效的解析 JSX 语法。
> - @babel/plugin-transform-react-jsx ：这个插件内部调用了 @babel/plugin-syntax-jsx，可以把 React JSX 转化成 JS 能够识别的 createElement 格式。

**Automatic Runtime**模式

~~~jsx
//普通业务代码
function Index(){
    return <div>
        <h1>hello,world</h1>
        <span>let us learn React</span>
    </div>
}
//编译结果
import { jsx as _jsx } from "react/jsx-runtime";
import { jsxs as _jsxs } from "react/jsx-runtime";
function Index() {
  return  _jsxs("div", {
            children: [
                _jsx("h1", {
                   children: "hello,world"
                }),
                _jsx("span", {
                    children:"let us learn React" ,
                }),
            ],
        });
}

~~~

**经典模式**

~~~jsx
import React from 'react'
function Index(){
    return <div>
        <h1>hello,world</h1>
        <span>let us learn React</span>
    </div>
}
//编译后
import React from 'react'
function Index(){
    return  React.createElement(
        "div",
        null,
        React.createElement("h1", null,"hello,world"),
        React.createElement("span", null, "let us learn React")
    );
}
~~~



简单实现一个babel

~~~js
const fs = require('fs')
const babel = require("@babel/core")

/* 第一步：模拟读取文件内容。 */
fs.readFile('./element.js',(e,data)=>{ 
    const code = data.toString('utf-8')
    /* 第二步：转换 jsx 文件 */
    const result = babel.transformSync(code, {
        plugins: ["@babel/plugin-transform-react-jsx"],
    });
    /* 第三步：模拟重新写入内容。 */
    fs.writeFile('./element.js',result.code,function(){})
})
~~~

