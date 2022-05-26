# props

demo

~~~react
/* children 组件 */
function ChidrenComponent(){
    return <div> In this chapter, let's learn about react props ! </div>
}
/* props 接受处理 */
class PropsComponent extends React.Component{
    componentDidMount(){
        console.log(this,'_this')
    }
    render(){
        const {  children , mes , renderName , say ,Component } = this.props
        const renderFunction = children[0]
        const renderComponent = children[1]
        /* 对于子组件，不同的props是怎么被处理 */
        return <div>
            { renderFunction() }
            { mes }
            { renderName() }
            { renderComponent }
            <Component />
            <button onClick={ () => say() } > change content </button>
        </div>
    }
}
/* props 定义绑定 */
class Index extends React.Component{
    state={  
        mes: "hello,React"
    }
    node = null
    say= () =>  this.setState({ mes:'let us learn React!' })
    render(){
        return <div>
            <PropsComponent  
               mes={this.state.mes}  // 1.props 作为一个渲染数据源
               say={ this.say  }     // 2.props 作为一个回调函数 callback
               Component={ ChidrenComponent } // 3.props 作为一个组件
               renderName={ ()=><div> my name is alien </div> } // 4.props 作为渲染函数
            >
                { ()=> <div>hello,world</div>  } { /* 5.render props */ }
                <ChidrenComponent />             { /* 6.render component */ }
            </PropsComponent>
        </div>
    }
}
~~~

如果是类式组件，通过访问this.props可以访问到。

![prop1.jpg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ebdf41b5a514461da1c30342db1d8fce~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

在标签内部的属性和方法会直接绑定在props对象的属性上，对于组件的插槽会被绑定在props的Children属性中。

props实现的功能：

1. props作为一个子组件渲染数据源
2. props作为一个回调函数callback
3. props作为一ige单纯的组件传递
4. props作为一个渲染函数
5. 同样作为一个渲染函数，但是放在了children属性上
6. render component 插槽组件

## props的作用

组件层级

* 子组件与父组件之间的通讯
* 将视图容器作为props进行渲染

更新机制：

React无法直接检测出数据更新波及到的范围，props可以作为组件是否更新的重要原则，

PureComponent和memo

React插槽：

React可以将组件闭合标签李的插槽，转换为Children属性

## props监听

* 类式组件
  component Will Receive Props 已经不被推荐了
  推荐getDerivedStateFromProps

* 函数组件

  userEffect（默认执行一次）

## props children模式

### 1.props 插槽组件

~~~react
<Container>
    <Children>
</Container>
~~~

* 通过props.children可访问到children组件，为React element对象
* 可以根据需要控制children是否渲染
* container可以使用React.cloneElement 强化props或者修改Children的子元素

### 2.render props模式

~~~react
<Container>
	{(ContainerProps) =><Children {...ContainerProps}/>}
</Container>
~~~

在这种情况下，props。children访问到的是函数

~~~js
function  Container(props) {
    const  ContainerProps = {
        name: 'alien',
        mes:'let us learn react'
    }
     return  props.children(ContainerProps)
}
//直接return props.chidren就会报错
~~~

* 这种方式可以控制chidren的渲染
* 可以将需要传给children的props直接通过函数参数的方式传递给执行函数children

### 3.混合模式

~~~react
function  Container(props) {
    const  ContainerProps = {
        name: 'alien',
        mes:'let us learn react'
    }
     return  props.children(ContainerProps)
}
~~~

Container的打印结果：

![comp2.jpg](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/55446bb6f2084ff4accd323d1b1e3d10~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

~~~react
//混合模式的实践就是在container上的return过程中实现function和element的判断
const Children = (props)=> (<div>
    <div>hello, my name is {  props.name } </div>
    <div> { props.mes } </div>
</div>)

function  Container(props) {
    const ContainerProps = {
        name: 'alien',
        mes:'let us learn react'
    }
     return props.children.map(item=>{
        if(React.isValidElement(item)){ // 判断是 react elment  混入 props
            return React.cloneElement(item,{ ...ContainerProps },item.props.children)
        }else if(typeof item === 'function'){
            return item(ContainerProps)
        }else return null
     })
}

const Index = ()=>{
    return <Container>
        <Children />
        { (ContainerProps)=> <Children {...ContainerProps} name={'haha'}  />  }
    </Container>
}
~~~

## props技巧

### 抽象props

> 一般用于跨层级传递props，不需要具体指出props中的某个属性，而是将props直接传入或者是抽离到子组件之中。

### 混入props

~~~react
function Son(props){
    console.log(props)
    return <div> hello,world </div>
}
function Father(props){
    const fatherProps={
        mes:'let us learn React !'
    }
    return <Son {...props} { ...fatherProps }  />
}
function Index(){
    const indexProps = {
        name:'alien',
        age:'28',
    }
    return <Father { ...indexProps }  />
}
~~~

将index的props传递给son的同时，将自己的props也混入其中

### 抽离props

~~~react
//还是上面的案例
function Father(props){
    const { age,...fatherProps  } = props
    return <Son  { ...fatherProps }  />
}
//实现了age从index传入的props中抽离
~~~

### 注入props

显式：

~~~react'
function Son(props){
     console.log(props) // {name: "alien", age: "28"}
     return <div> hello,world </div>
}
function Father(prop){
    return prop.children
}
function Index(){
    return <Father>
        <Son  name="alien"  age="28"  />
    </Father>
}
~~~

隐式

~~~react
function Son(props){
     console.log(props) // {name: "alien", age: "28", mes: "let us learn React !"}
     return <div> hello,world </div>
}
function Father(prop){
    return React.cloneElement(prop.children,{  mes:'let us learn React !' })
}
function Index(){
    return <Father>
        <Son  name="alien"  age="28"  />
    </Father>
}
~~~

一般通过React.cloneElement对props。children克隆混入新的props（mes）

## 实践demo

### 1.编写<From>

~~~react
class Form extends React.Component{
    state={
        formData:{}
    }
	//用于提交表单数据
	submitForm = (cb)=>{
        cb({...this.state.formData})
    }
    //获取重置表单数据
    resetForm = ()=>{
        const {formData} = this.state
        Object.keys(formData).forEach(item =>{
            formData[item] = ''
        })
        this.setState({
            formData
        })
    }
    //设置表单数据层
    saveValue=(name,value)=>{
        this.setState({
            formData:{
                ...this.state.formData,
                [name]:value
            }
        })
    }
~~~

