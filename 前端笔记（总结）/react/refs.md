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

~~~react
//类组件
class Children extends Component{
    render = ()=><div>hello,world</div>
}
    
~~~

