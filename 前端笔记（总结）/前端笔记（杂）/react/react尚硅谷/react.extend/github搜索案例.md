# github搜索案例

## 报文属性

avatar url 用户头像url

login  登录名

html url 个人主页

## 加载提醒

list组件
1，ueser界面
2，欢迎界面
3，加载界面
4，报错界面

三元判断表达式来依次判断是否处于某种状态之下

~~~jsx

isFirst ? <h2>输入关键词，随后点击搜索</h2>：继续往下写其他的状态判断
~~~

将所有需要考虑的状态进行封装处理
直接传入一个

~~~javascript
 updateAppState = (stateObj)=>{
      this.setState(stateObj)
    }
    //传入时，将状态都传进去，按需拿取
     <List {...this.state}/>
~~~

不能存取错误对象，因为这样不能够展示出来，解决方案是存取错误对象身上的某个属性message

## 组件之间的通信（消息订阅与发布）

接收数据的组件内订阅消息，B发布消息同时传递数据

可以将app中的状态给相应的组件

## fetch
