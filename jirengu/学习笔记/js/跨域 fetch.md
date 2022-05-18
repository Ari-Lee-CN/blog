# 跨域和fetch

## 跨域问题

> 同源：URL等都相同 为保护用户隐私
>
> 跨域：浏览器向不同源获取到数据。

## 跨域策略

### ajax/axios

### CORS

* 在请求头设置Origin 表明身份
* CORS可以发送遇见请求，设置请求希望使用的方法 自定义头部等

### JSONP

> json被包裹在一个函数调用里，动态创建<secipt>标签为src属性指定跨域URL

* jsonp无法获取状态码，不利于定位错误
* 无法保证响应安全

## fetch API

### fetch基本用法

> 调用这个方法，会向给定URL发送请求。当请求完成、资源可用时，期约会解决为一个Response对象，可以通过他获取相应资源
>
> 跨域问题通过CORS方法解决

第一个参数为url  第二个参数为init，按照规定键值对形式进行配置

### Headers对象

> 类似于map 以键值对的形式存储，但是不同在在初始化时，也可以使用键值对形式的对象

头部护卫会针对某些修改进行阻止

### Request对象

~~~javascript	
let r = new Request("https://foo.com");
参数设置和fetch，可以将r传进fetch里，作为一个资源请求。
~~~

* 克隆方法
  
  * Request构造函数
  
  ~~~
  let r1 = new Request('http://foo.com')
  let r2 = new Request(r1);
  ~~~
  
  不能得到一模一样的副本，第一个请求的请求体会被标记为已使用。
  
  * clone()方法
  
  ~~~
  let r1 = new Request('http://foo.com')
  let r2 = r1.clone()
  ~~~
  
  只能复制未被使用的请求体，不会被标记
  
* 在fetch中使用request对象

### Response对象

response对象是获取资源响应的接口，暴露了响应的相关信息

* 创建response对象

接受body和init来构建Response对象，产生response对象的主要方式就是调用fetch()

* 两种静态方法

response.redirect   接收一个URL 和一个重定向状态码

response.error 用于产生表示网络错误的Response对象

* 克隆response对象

主要使用clone方法