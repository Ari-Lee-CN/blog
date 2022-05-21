# java项目实战

## jsp基本语法

### 页面构成

![image-20211231143327958](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231143327958.png)



#### page指令

Language=“java”

import=“java.util.*”

pageEncoding = “GB18030”

contentType = “text/html;charset=UTF-8”

session =“false”

buffer = “128kb”

auto Flush = “true”

isErrorPage = “true”

errorPage =“error/loginErrorPage.jsp”

#### include指令

file=”“

#### taglib指令

jsp文件中，可以通过taglib指令标识声明该页面中所使用的标签库，同时引用标签库，并指定标签的前缀。在页面中，引用标签库后，就可以通过前缀来引用标签库中的标签。

~~~jsp
<%@ taglib prefix="tagPrefix" url="tagURI" %>
~~~

### 脚本标识

基本构成：jsp表达式、声明标识、代码片段

#### jsp表达式

~~~jsp
输出方式：
<%=表达式 %>
<% out.println(表达式)%>
~~~

#### 声明标志

~~~jsp
<%
int number = 10;
int count(){
    number++;
    return number;
}
%>
~~~

#### 代码片段

~~~jsp
<%
多行代码
    %>
~~~



#### 注释

<!--注释内容-->

<%-- 注释内容 --%>

#### 动作标识

<jsp:include> 实现外部代码嵌入

<jsp:forward> 实现数据请求的转发

## jsp内置对象

request、response、session、application\out\pageContext\config\page\exception

### request

#### getParametetr

封装了HTTP请求中的各项参数,获取参数信息

~~~jsp
getParameter(参数名)
~~~

#### getAttribute

封装了HTTP请求中的各项参数，保存信息

~~~jsp
request.setAttribute("result",money);
保存执行结果
request.setAttribute("result","抱歉。页面产生错误")
保存错误提示信息

~~~

#### cookie

* getCookies()获取所有cookie对象的集合
* 通过cookie对象的getName()方法可以获取指定名称的cookie
* 通过getValue()方法可以获取cookie对象的值
* addCookie可以将一个cookie对象发送到客户端

#### request其他方法

![image-20211231152615174](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231152615174.png)

### response对象

相应客户端请求，向客户端输出信息

#### sendRedirect()

可以将网页重定向到另一个页面

#### 处理HTTP文件头

* 禁用缓存
  response.setHeader(“Cache-Control”,”no-store”);
* 设置页面自动刷新
  response.setHeader(“refresh”,”10”);
* 定时跳转页面
  response.setHeader(“refresh”,”5”:URL=login.jsp);

#### 设置输出缓冲区

response.flushBuffer()强制将缓存内容输出到客户端

response.getBufferSize() 获得当前客户端缓存的大小

response.setBufferSize(int size) 设置客户端缓存大小

response.reset()清空客户端缓存

response.isCommitted()检查是否将数据写入了客户端

#### session功能

Session对象是用来分别保存每个用户信息的对象，以便于跟踪用户的操作状态。Session的信息保存在服务端，Session的ID保存在客户机的Cookie中．其实，在很多server上，假设浏览器支持Cookies的话就直接使用Cookies．可是假设不支持或废除了Cookies的话就自己主动转化为URL-rewriting, Session自己主动为每个流程提供了方便地存储信息的方法．

Session对象是用来分别保存每个用户信息的对象，以便于跟踪用户的操作状态。Session的信息保存在服务端，Session的ID保存在客户机的Cookie中．其实，在很多server上，假设浏览器支持Cookies的话就直接使用Cookies．可是假设不支持或废除了Cookies的话就自己主动转化为URL-rewriting, Session自己主动为每个流程提供了方便地存储信息的方法．

方法：![image-20211231153552309](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231153552309.png)

#### application对象

提供了对应用程序初始化参数进行访问的方法。应用程序初始化参数在web.xml文件中进行了设置

application是对整个应用区域都有效，与session不同

方法：![image-20211231154410504](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231154410504.png)

#### out对象

向客户端浏览器输出信息

方法：

* clear()清楚缓冲区的内容
* clearBuffer 清除当前缓冲区中的内容
* flush() 刷新流
* isAutoFlush 检测当前缓冲区已满时是自动清空，还是抛出异常
* getBufferSize()获取缓冲区大小

#### pageContext

通过它可以获取当前页面对应的request、response、session、application、exception对象

#### config对象

获取服务器配置信息，通过pageContext对象的getServletConfig()可以获得该对象

#### page对象

代表当前jsp页面自身。所有jsp都会被实例化位servlet对象，相当于this

#### exception对象

用于处理jsp文件执行时发生的所有错误和异常。只有在page指令中设置位isErrorPage属性值为true时才可以被使用

## javaBean概念

将重复使用代码打包，包括可视化界面和业务逻辑、业务对象

### 设置/获取javabean属性值

javabean内部属性是私有的、需要提供公共访问方法

* 对JavaBean对象的操作主要是
  <jsp:useBean>
  <jsp:getProperty>
  <jsp:setProperty>
* JavaBean的生命周期可以自行进行设置，存在于四种范围之内：page、request、session、applicatio 默认作用域page范围之内

#### JavaBean规范

* 必须有一个公共类，访问属性设置为public
* 必须有一个空的构造函数，类中必须有一个无参数的构造方法
* 不应该由公共实例变量，类的变量都为private
* 有一组读写方法 getXXX  setXXX
  特殊情况：如果是布尔类型，get变为is



## sevlet

### 简介

  Servlet是使用Java Servlet接口（API）运行在Web应用服务器上Java程序，其功能十分强大，它不但可以处理Http请求中的业务逻辑，而且还可以输出HTML代码来显示指定页面。而JSP是一种在Servlet规范之上的动态网页技术，在JSP页面之中，同样可以编写业务逻辑处理Http请求，也可以通过HTML代码来编辑页面，在实现功能上，Servlet与JSP貌似相同，实质存在一定的区别，表现在以下方面：
	1、角色不同
	2、编程方法不同
	3、Servlet需要编译后运行
	4、速度不同

### 特点

* 功能强大
* 可移植
* 性能高效
* 安全性高
* 可拓展

声明一个对象为Servlet时，需要继承HttpServle类，继承之后可以重写类中方法对Http请求进行处理

servlet运行必须得到servlet容器的支持，因此必须继承servlet标准接口。

### 接口方法

#### servlet接口

![image-20211231164047433](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231164047433.png)

#### servletconfig接口

![image-20211231164119665](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231164119665.png)

#### httpservletrequest接口

![image-20211231164216853](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231164216853.png)

#### HttpServletResponse接口

![image-20211231164416172](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211231164416172.png)

### GenericServlet类

编写servlet对象时，必须实现javax.servlet接口，接口中包含了五个方法，也就是创建时必须实现五个方法，用genericservlet类，程序员只需要实现service方法即可

### httpservlet类

使用sevlet处理http协议请求时，使用该类，为http请求的处理提供了灵活的方法

### 创建servlet

* 手动创建java类，继承，手动配置xml文件注册对象
* ide继承开发工具创建

#### servlet过滤器和监听器

过滤器filter用于拦截客户端（浏览器）与目标资源的请求，并对这些请求进行一定过滤处理在发送给目标资源

监听器作用是监听web容器的有效期时间

#### 过滤器步骤

声明过滤器对象、创建过滤器映射

创建一个过滤器对象需要实现javax.servlet.Filter接口，同时实现filter接口的三个方法

### JDBC java数据库api

