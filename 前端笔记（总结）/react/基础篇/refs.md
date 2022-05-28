# refs
## refs基本概念

### Ref对象创建

ref对象就是用createRef或者useRef创建出来的对象

标准的ref对象：

~~~js
{
    current:null,
    //current指向ref对象获取到的实际内容
}
~~~



#### 类组件React.createRef

~~~react
class Index extends React.Component{
    constructor(props){
        super(props)
        this.currentDOM = React.createRef(null)
    }
    componentDidMount(){
        console.log(this.currentDom)
    }
    render = () => <div ref={this.currentDom}>ref对象模式获取元素或者组件</div>
}
~~~

打印：

![ref.jpg](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9a03858d0d9447ac9d29f3faa2fc1851~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

> react/src/ReactCreateRef.js

~~~react
export function createRef() {
  const refObject = {
    current: null,
  }
  return refObject;
}
~~~

createRef创建了一个对象，对象上的current属性，用于保存通过ref获取的DOM元素、组件实例。createRef对象，可以将Ref对象绑定在类组件实例上，方便后续操作Ref。

#### 函数组件useRef

~~~react
export default function Index(){
    const currentDom = React.useRef(null)
    React.useEffect(()=>{
        console.log((currentDom.current))
    },[])
    return <div ref={currentDom}>ref对象模式获取元素或者组件</div>
}
~~~

底层逻辑与createRef差不多，但是又有些许区别：

* 类组件有实例instance维护ref 函数组件每次都要执行一次，ref会被重置，所以不能用reateRef
* useRef产生的ref对象会挂到函数组件对应的fiber上

### 类组件获取Ref三种方式

#### Ref属性是一个字符串

~~~js
//类组件
class Children extends Component{
    render = ()=><div>hello,world</div>
}
export default class Index extends React.Component{
    componentDidMount(){
        console.log(this.refs)
    }
    render=()=><div>
        <div ref="currentDOM">字符串模式获取元素或组件</div>
        <children ref="currentComInstance"/>
    </div>
}
~~~

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3ca7efcd73fe429aa83bd91f068c5508~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)

字符串ref标记DOM元素会绑定在组件this。refs上.对于类式组件实例会绑定在this.refs上

#### refs是一个函数

~~~js

class Children extends React.Component {
    render()=><div>hello,world</div>
}
export default class Index extends React.Component {
    currentDom = null;
    currentComponentInstance = null;
    componentDidMount(){
        console.log(this.currentDom);
        console.log(this.currentComponentInstance);
    }
    render=()=><div>
    <div ref={(node)=>this.currentDom = node}>Ref模式获取元素或组件</div>
    <Children ref={{node}=>this.currentComponentInstance = node}>
    </div>
}
~~~
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/74ba71b6c4f5456eaf7cd46e51598fa4~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)
如代码片段所示，当函数来标记Ref时，将作为callback形式，在真实DOM创建阶段，执行callback，获取DOM元素或者组件实例，将以回调函数第一个参数形式传入

#### Ref属性是一个ref对象

~~~js
lass Children extends React.Component{  
    render=()=><div>hello,world</div>
}
export default class Index extends React.Component{
    currentDom = React.createRef(null)
    currentComponentInstance = React.createRef(null)
    componentDidMount(){
        console.log(this.currentDom)
        console.log(this.currentComponentInstance)
    }
    render=()=> <div>
         <div ref={ this.currentDom }  >Ref对象模式获取元素或组件</div>
        <Children ref={ this.currentComponentInstance }  />
   </div>
}
~~~

## ref高阶用法

### forwardRef 转发Ref
forwardRef解决了ref不能跨层级捕获和传递的问题
#### 跨层级获取
~~~js
// 孙组件
function Son (props){
    const { grandRef } = props
    return <div>
        <div> i am alien </div>
        <span ref={grandRef} >这个是想要获取元素</span>
    </div>
}
// 父组件
class Father extends React.Component{
    constructor(props){
        super(props)
    }
    render(){
        return <div>
            <Son grandRef={this.props.grandRef}  />
        </div>
    }
}
const NewFather = React.forwardRef((props,ref)=> <Father grandRef={ref}  {...props} />)
// 爷组件
class GrandFather extends React.Component{
    constructor(props){
        super(props)
    }
    node = null 
    componentDidMount(){
        console.log(this.node) // span #text 这个是想要获取元素
    }
    render(){
        return <div>
            <NewFather ref={(node)=> this.node = node } />
        </div>
    }
}
~~~
forwardRef把ref变成了可以通过props传递和转发

#### 合并转发ref
> 通过forwardRef转发的ref还可以传递合并之后的自定义的ref

~~~js

// 表单组件
class Form extends React.Component{
    render(){
       return <div>{...}</div>
    }
}
// index 组件
class Index extends React.Component{ 
    componentDidMount(){
        const { forwardRef } = this.props
        forwardRef.current={
            form:this.form,      // 给form组件实例 ，绑定给 ref form属性 
            index:this,          // 给index组件实例 ，绑定给 ref index属性 
            button:this.button,  // 给button dom 元素，绑定给 ref button属性 
        }
    }
    form = null
    button = null
    render(){
        return <div   > 
          <button ref={(button)=> this.button = button }  >点击</button>
          <Form  ref={(form) => this.form = form }  />  
      </div>
    }
}
const ForwardRefIndex = React.forwardRef(( props,ref )=><Index  {...props} forwardRef={ref}  />)
// home 组件，将ref传递给子组件
export default function Home(){
    const ref = useRef(null)
     useEffect(()=>{
         console.log(ref.current)
     },[])
    return <ForwardRefIndex ref={ref} />
}

~~~
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ae1f89a15dea4e55b1de6c8f313c0069~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)

流程主要包含以下方面：
1. 通过useRef创建一个ref对象，通过forwardRef将当前ref对象传递给子组件.
2. 向Home组件传递的ref对象上，绑定form孙组件实例，index子组件实例，和button DOM元素.

forwardRef 可以通过props传递

### 高阶组件转发
如果通过高阶组件包裹一个原始类组件，就会产生一个问题，如果高阶组件HOC没有处理ref，由于高阶组件本身会返回一个新组件，所以标记的ref会指向HOC返回的组件
~~~js
function HOC(Component){
  class Wrap extends React.Component{
     render(){
        const { forwardedRef ,...otherprops  } = this.props
        return <Component ref={forwardedRef}  {...otherprops}  />
     }
  }
  return  React.forwardRef((props,ref)=> <Wrap forwardedRef={ref} {...props} /> ) 
}
class Index extends React.Component{
  render(){
    return <div>hello,world</div>
  }
}
const HocIndex =  HOC(Index)
export default ()=>{
  const node = useRef(null)
  useEffect(()=>{
    console.log(node.current)  /* Index 组件实例  */ 
  },[])
  return <div><HocIndex ref={node}  /></div>
}
~~~
如此之后，就可以实现对HOC的简单处理

### ref实现组件通信
> 应用场景：不想通过父组件render改变props来触发子组件的更新，子组件通过state单独管理数据层。
> 父组件可以通过ref模式标记子组件实例，从而操纵子组件方法
> 常用于数据层托管组件

#### 类组件ref
类组件可以通过ref直接获取组件实例，实现组件通信
~~~js
/* 子组件 */
class Son extends React.PureComponent{
    state={
       fatherMes:'',
       sonMes:''
    }
    fatherSay=(fatherMes)=> this.setState({ fatherMes  }) /* 提供给父组件的API */
    render(){
        const { fatherMes, sonMes } = this.state
        return <div className="sonbox" >
            <div className="title" >子组件</div>
            <p>父组件对我说：{ fatherMes }</p>
            <div className="label" >对父组件说</div> <input  onChange={(e)=>this.setState({ sonMes:e.target.value })}   className="input"  /> 
            <button className="searchbtn" onClick={ ()=> this.props.toFather(sonMes) }  >to father</button>
        </div>
    }
}
/* 父组件 */
export default function Father(){
    const [ sonMes , setSonMes ] = React.useState('') 
    const sonInstance = React.useRef(null) /* 用来获取子组件实例 */
    const [ fatherMes , setFatherMes ] = React.useState('')
    const toSon =()=> sonInstance.current.fatherSay(fatherMes) /* 调用子组件实例方法，改变子组件state */
    return <div className="box" >
        <div className="title" >父组件</div>
        <p>子组件对我说：{ sonMes }</p>
        <div className="label" >对子组件说</div> <input onChange={ (e) => setFatherMes(e.target.value) }  className="input"  /> 
        <button className="searchbtn"  onClick={toSon}  >to son</button>
        <Son ref={sonInstance} toFather={setSonMes} />
    </div>
}
~~~

#### 函数组件forwardRef + useImperativeHandle
useImperativeHandle 接受三个参数：

第一个参数 ref : 接受 forWardRef 传递过来的 ref 。
第二个参数 createHandle ：处理函数，返回值作为暴露给父组件的 ref 对象。
第三个参数 deps :依赖项 deps，依赖项更改形成新的 ref 对象。

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/59238390306849e89069e6a4bb6ded9d~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)

~~~js
// 子组件
function Son (props,ref) {
    const inputRef = useRef(null)
    const [ inputValue , setInputValue ] = useState('')
    useImperativeHandle(ref,()=>{
       const handleRefs = {
           onFocus(){              /* 声明方法用于聚焦input框 */
              inputRef.current.focus()
           },
           onChangeValue(value){   /* 声明方法用于改变input的值 */
               setInputValue(value)
           }
       }
       return handleRefs
    },[])
    return <div>
        <input placeholder="请输入内容"  ref={inputRef}  value={inputValue} />
    </div>
}

const ForwarSon = forwardRef(Son)
// 父组件
class Index extends React.Component{
    cur = null
    handerClick(){
       const { onFocus , onChangeValue } =this.cur
       onFocus() // 让子组件的输入框获取焦点
       onChangeValue('let us learn React!') // 让子组件input  
    }
    render(){
        return <div style={{ marginTop:'50px' }} >
            <ForwarSon ref={cur => (this.cur = cur)} />
            <button onClick={this.handerClick.bind(this)} >操控子组件</button>
        </div>
    }
}
~~~
流程分析：
* 父组件用ref标记子组件，由于子组件Son是函数组件没有实例，所以用forwordRef转发Ref
* 子组件Son用useImperativeHandle接收父组件ref，将让input聚焦的方法onFocus和改变input输入框的值的方法onChangeValue传递给ref
* 父组件可以通过调节ref下的onFocus和onChangeValue控制子组件中input赋值和聚焦

### 函数组件缓存数据

useRef可以创造ref原始对象，存储不依赖于视图更新的数据。
* 可以直接修改数据，不造成函数组件冗余的更新作用
* useRef保存数据，始终指向一个内存地址，可以随时访问到变化之后的值

设计思路：
* 用一个useRef保存type的信息 type改变不需要视图变化
* 按钮切换直接改变useRef内容
* useEffect可以直接访问改变后的typeInfo内容，不需要添加依赖项

## ref原理

demo代码
~~~js
export default class Index extends React.Component{
    state={ num:0 }
    node = null
    render(){
        return <div >
            <div ref={(node)=>{
               this.node = node
               console.log('此时的参数是什么：', this.node )
            }}  >ref元素节点</div>
            <button onClick={()=> this.setState({ num: this.state.num + 1  }) } >点击</button>
        </div>
    }
}
~~~
两次打印分别为null 和div

### ref执行时机和处理逻辑

ref需要获取真实DOM以及组件实例，需要在commit阶段处理

两次输出，底层分别调用了commitDetachRef和commitAttachRef两个方法，分别在DOM更新前和DOM更新后

* 阶段一：mutation极端，执行commitDetRef，会清空之前的ref值，重置为null
~~~js
react-reconciler/src/ReactFiberCommitWork.js
~~~
~~~js
function commitDetachRef(current: Fiber) {
  const currentRef = current.ref;
  if (currentRef !== null) {
    if (typeof currentRef === 'function') { /* function 和 字符串获取方式。 */
      currentRef(null); 
    } else {   /* Ref对象获取方式 */
      currentRef.current = null;
    }
  }
}
~~~
* 阶段二：DOM更新阶段，genjubutongeffect标签，真实操作DOM
* 阶段三：layout阶段，更新真实元素节点之后，需要更新ref
  判断获取的是组件还是DOM元素标签。
  DOM会更新
  字符串和函数式会执行ref函数，重置ref
  对象式则会更新current属性，更新ref对象

tips：当ref属性为字符串时，React会自动绑定一个函数，用来处理ref逻辑
~~~js
react-reconciler/src/ReactChildFiber.js
~~~
~~~js
const ref = function(value) {
    let refs = inst.refs;
    if (refs === emptyRefsObject) {
        refs = inst.refs = {};
    }
    if (value === null) {
        delete refs[stringRef];
    } else {
        refs[stringRef] = value;
    }
};
~~~

### Ref处理逻辑



### ref卸载

被卸载的 fiber 会被打成 Deletion effect tag ，然后在 commit 阶段会进行 commitDeletion 流程。对于有 ref 标记的 ClassComponent （类组件） 和 HostComponent （元素），会统一走 safelyDetachRef 流程，这个方法就是用来卸载 ref。

* 对于字符串 ref="dom" 和函数类型 ref={(node)=> this.node = node } 的 ref，会执行传入 null 置空 ref 。
* 对于 ref 对象类型，会清空 ref 对象上的 current 属性。

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/08a2393077634beaad2b91f971ab381f~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)