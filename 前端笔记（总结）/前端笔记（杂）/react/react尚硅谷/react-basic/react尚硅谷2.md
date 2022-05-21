# react尚硅谷2

## 事件处理程序

### 注意点

通过onXxx属性指定事件处理函数     注意大小写

react使用的是自定义事件，而不是原生DOM事件，  为了更好的兼容性

React中的事件是通过事件委托方式处理的（委托给组件最外层元素   为了高效

通过evernt.target得到发生事件的DOM元素对象

尽可能少些ref转发

~~~javascript
myRef = React.createRef()

showData = ()=>{
    alert(this.myRef.current.value);
}
showData2 = ()=>{
    alert(everbt.target.value);
}

render(){
    renturn(
       <div>
        <input ref={this.myRef} type='text' placeholder="点击按钮提示数据"/>&nbsp;
<buttopn onClick={this.showData}>惦记我提示左侧数据</button>&nbsp;
<input onBlur={this.showData2} type="text"
placeholder="失去焦点提示数据"/>&nbsp;
</div> 
    )
}

ReactDOM.render(<Demo/>,document.getElementById('test'))


~~~

对于第二个按钮，没必要写ref2={this.myRef2}，因为ref本质上是一种转发，失去焦点提示数据，提示的是自己的数据，事件也是在input上发生的，所以当调用showData2的时候会传入一个事件，如果想要提示数据，只需要event.target就可以找到事件发生的位置，

对于第一个按钮则不一样，事件发生是出现在button上的，所以需要用this.myRef.current来找到获取数据的地方

## 组件

### 非受控组件

~~~javascript
<script type="text/babel">
  //创建组件
  class Login extends React.Component{
   handleSubmit = (event)=>{
    event.preventDefault() //阻止表单提交
    const {username,password} = this
    alert(`你输入的用户名是：${username.value},你输入的密码是：${password.value}`)
   }
   render(){
    return(
     <form onSubmit={this.handleSubmit}>
      用户名：<input ref={c => this.username = c} type="text" name="username"/>
      密码：<input ref={c => this.password = c} type="password" name="password"/>
      <button>登录</button>
     </form>
    )
   }
  }
  //渲染组件
  ReactDOM.render(<Login/>,document.getElementById('test'))
 </script>
~~~

~~~javascript
<script type="text/babel">
//创建组件
class Login extends React.Component{
    handleSubmit = ()=>{
        event.preventDefault()//阻止表单提交
        const {username,password}=this
        //alert(username.value)
        alert('你输入的用户名是：${username.value),你输入的密码是：${psssword.value
    }
    render(){
       renturn(
       <form action="http://www. onSubmit+{this.handleSubmit}">
       用户名：<input ref={c =>this.username =c} type="text" name="username"/>
       密码：<input ref={c =>this.username=c} type="password"name="password"/>
       //只有标注了name属性之后，才能用get请求传输过去
       <button>登录</button>
       </form>
       
       )
    }
}
~~~

### 受控组件

~~~javascript
<script type="text/babel">
  //创建组件
  class Login extends React.Component{

   //初始化状态
   state = {
    username:'', //用户名
    password:'' //密码
   }

   //保存用户名到状态中
   saveUsername = (event)=>{
    this.setState({username:event.target.value})
   }
            //setState为实例的state属性设置

   //保存密码到状态中
   savePassword = (event)=>{
    this.setState({password:event.target.value})
   }
            
   //表单提交的回调
   handleSubmit = (event)=>{
    event.preventDefault() //阻止表单提交
    const {username,password} = this.state
    alert(`你输入的用户名是：${username},你输入的密码是：${password}`)
   }
            //是username而不是username.value
            
   render(){
    return(
     <form onSubmit={this.handleSubmit}>
      用户名：<input onChange={this.saveUsername} type="text" name="username"/>
      密码：<input onChange={this.savePassword} type="password" name="password"/>
      <button>登录</button>
     </form>
             //onchange  事件变化时执行
    )
   }
  }
  //渲染组件
  ReactDOM.render(<Login/>,document.getElementById('test'))
 </script>
~~~

受控与非受控之间的区别在于：受控是随着变化而变化  非受控则是现用现取，建议少用非受控，这样就可以不适用ref，提升效率

## 高阶函数-函数柯里化

~~~javascript
<script type="text/babel">
  //创建组件
  class Login extends React.Component{

   //初始化状态
   state = {
    username:'', //用户名
    password:'' //密码
   }

   //保存用户名到状态中
   saveUsername = (event)=>{
    this.setState({username:event.target.value})
   }
            //setState为实例的state属性设置

   //保存密码到状态中
   savePassword = (event)=>{
    this.setState({password:event.target.value})
   }
            
   //表单提交的回调
   handleSubmit = (event)=>{
    event.preventDefault() //阻止表单提交
    const {username,password} = this.state
    alert(`你输入的用户名是：${username},你输入的密码是：${password}`)
   }
            //是username而不是username.value
            
   render(){
    return(
     <form onSubmit={this.handleSubmit}>
      用户名：<input onChange={this.saveUsername} type="text" name="username"/>
      密码：<input onChange={this.savePassword} type="password" name="password"/>
      <button>登录</button>
     </form>
             //onchange  事件变化时执行
    )
   }
  }
  //渲染组件
  ReactDOM.render(<Login/>,document.getElementById('test'))
 </script>
~~~
