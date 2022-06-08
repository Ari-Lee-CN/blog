# xss攻击
参考文章：
1.[https://juejin.cn/post/6912030758404259854#heading-1](这一次，彻底理解XSS攻击)
2.[https://tech.meituan.com/2018/09/27/fe-security.html](美团技术团队xss)

>通过利用网页开发时留下的漏洞，通过巧妙地方法注入恶意指令代码到网页，使用户加载并执行攻击者恶意制造地网页程序
## XSS类型
常见类型有：反射型、存储型、DOM型、通用型、突变型
### 反射型XSS
反射型XSS只是简单的把用户输入的数据从服务器反射给用户浏览器，要利用这个漏洞，攻击者必须以某种方式诱导用户访问一个精心设计的URL（恶意链接），才能实施攻击。
举例来说，当一个网站的代码中包含类似下面的语句:
~~~php
<?php echo "<p>hello,$_GET['user']</p>"; ?>
~~~
如果未做防范XSS，用户名设为<script>alert("xss")</script[](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b53bf56086cd48988872c80c6db8f5ba~tplv-k3u1fbpfcp-zoom-in-crop-mark%3A1304%3A0%3A0%3A0.awebp)>,则会执行预设好的JavaScript代码。

### 存储型
存储型（或 HTML 注入型/持久型）XSS 攻击最常发生在由社区内容驱动的网站或 Web 邮件网站，不需要特制的链接来执行。黑客仅仅需要提交 XSS 漏洞利用代码（反射型XSS通常只在url中）到一个网站上其他用户可能访问的地方。这些地区可能是博客评论，用户评论，留言板，聊天室，HTML 电子邮件，wikis，和其他的许多地方。一旦用户访问受感染的页，执行是自动的。

### DOM型
DOM型XSS是基于DOM文档对象模型的。对于浏览器来说，DOM文档就是一份XML文档，当有了这个标准的技术之后，通过JavaScript就可以轻松的访问DOM。当确认客户端代码中有DOM型XSS漏洞时，诱使(钓鱼)一名用户访问自己构造的URL，利用步骤和反射型很类似，但是唯一的区别就是，构造的URL参数不用发送到服务器端，可以达到绕过WAF、躲避服务端的检测效果。
攻击示例
~~~html
<html>
    <head>
        <title>DOM Based XSS Demo</title>
        <script>
        function xsstest()
        {
        var str = document.getElementById("input").value;
        document.getElementById("output").innerHTML = "<img
        src='"+str+"'></img>";
        }
        </script>
    </head>
    <body>
    <div id="output"></div>
    <input type="text" id="input" size=50 value="" />
    <input type="button" value="submit" onclick="xsstest()" />
    </body>
</html>
~~~
### 通用型
通用型XSS，也叫做UXSS或者Universal XSS，全称Universal Cross-Site Scripting。
上面三种XSS攻击的是因为客户端或服务端的代码开发不严谨等问题而存在漏洞的目标网站或者应用程序。这些攻击的先决条件是访问页面存在漏洞，但是UXSS是一种利用浏览器或者浏览器扩展漏洞来制造产生XSS的条件并执行代码的一种攻击类型。

### 突变型
如果用户所提供的富文本内容通过javascript代码进入innerHTML属性后，一些意外的变化会使得这个认定不再成立：浏览器的渲染引擎会将本来没有任何危害的HTML代码渲染成具有潜在危险的XSS攻击代码。
随后，该段攻击代码，可能会被JS代码中的其它一些流程输出到DOM中或是其它方式被再次渲染，从而导致XSS的执行。 这种由于HTML内容进入innerHTML后发生意外变化，而最终导致XSS的攻击流程。
攻击流程
​	将拼接的内容置于innerHTML这种操作，在现在的WEB应用代码中十分常见，常见的WEB应用中很多都使用了innerHTML属性，这将会导致潜在的mXSS攻击。从浏览器角度来讲，mXSS对三大主流浏览器（IE，CHROME，FIREFOX）均有影响。

## 防范措施
> xss攻击两个要素：攻击者提交了恶意代码2.浏览器执行了恶意代码

### 预防DOM型xss攻击
不可以将不可信的数据当作代码执行
* 使用.innerHTML和.outHTML、document.write()要特别小心，尽量使用.textContent .setAttribute()
* 内联事件监听器、标签href属性、js的eval setTimeout setInterval等都可以将字符串作为代码执行。尽量避免

### 过滤输入
如果由前端过滤输入，然后提交到后端的话。一旦攻击者绕过前端过滤，直接构造请求，就可以提交恶意代码了。所以后端应该执行过滤输入。
### 前端渲染
在前端渲染中，我们会明确的告诉浏览器：下面要设置的内容是文本（.innerText），还是属性（.setAttribute），还是样式 （.style）等等。浏览器不会被轻易的被欺骗，执行预期外的代码了。

* Javascript：可以使用textContent或者innerText的地方，尽量不使用innerHTML；
* query：可以使用text()得地方，尽量不使用html()；

或者可以进行纯前端渲染，将代码与数据分隔开

### 拼接HTML时进行转义
* HTML 转义是非常复杂的，在不同的情况下要采用不同的转义规则。如果采用了错误的转义规则，很有可能会埋下 XSS 隐患。
* 应当尽量避免自己写转义库，而应当采用成熟的、业界通用的转义库。