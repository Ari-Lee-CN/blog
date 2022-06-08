# CSRF
> cross-siete request forgery 跨站请求伪造，一种挟制用户在当前已登录的web应用程序上执行非本意的操作的攻击方法。
> XSS利用的是用户对于指定网站的新人，CSRF利用的是网站对用户网页浏览器的信任
[https://tech.meituan.com/2018/10/11/fe-security-csrf.html](美团技术团队)
## 原理
[攻击原理图](https://segmentfault.com/img/bVbOUI9)
1. 首选用户通过浏览器访问网银系统
2. 用户在网银登录后，浏览器会把用户session_id保存在浏览器Cookie中
3. 此时用户在同一个浏览器中访问了第三方网站
4. 第三方网站诱导用户访问了网页转账的链接
5. 由于用户在网银系统已经登录了，浏览器访问网银转账链接时，会带上用户在网银的Cookie信息
6. 网银系统根据用户提交Cookie中的session_id，以为用户本人发起了转账操作，于是执行转账业务。

## 伪造触发的方式
* 第三方页面把图片地址设置为攻击链接，访问页面就会自动触发请求。
~~~js
<img src="http://">
~~~
* 在第三方页面构造一个form表单，访问页面时，表单通过JavaScript自动提交
~~~js
<form action="http://bank.com/transfer">
    <input type="hidden" name="account" value="lisi">
    <input type="hidden" name="amount" value="100">
</form>
<script>
form[0].submit();
</script>
~~~
* 第三方页面构建一个链接，诱导用户点击触发请求

## 防范
成功攻击要满足以下几个条件
* 用户在被攻击的系统中登陆了
* 用户在第三方系统触发了对攻击系统的请求，而被攻击服务器无法识别该请求来源

对于前者：
* 对重要的操作进行二次认证，防止操作在后台自动执行
* 设置适当的会话超时事件，防止用户离开之后，其他用户在同一个浏览器中操作
* 养成良好的习惯，离席锁屏

对于后者：
* 保持语义一致性，操作类请求，必须使用POST，GET请求只用于浏览类请求
* 阻止外域访问：
* * 同源检测：判断Origin Header和Referer Header，来判断请求的来源。
* * Samesite Cookie （仅限于chrome）
* 随机数一致性检测
* * CSRF token:服务器端判断和客户端生成的随机值csrf_token是否一致