## 异步和promise 跨域

## 异步缺陷

* 不规范  有多种书写方式 （两个参数、两个回调、一个对象）
* 容易出现回调地狱
* 很难对错误进行处理



关于 `return new Promise((resolve, reject)=>{...})` 中的 resolve 和 reject，正确的有（多选）

------



1.  resolve 和 reject 可以改成任何其他名字，不影响使用，但一般就叫这两个名字
2.  任务成功的时候调用 resolve，失败的时候调用 reject
3.  resolve 和 reject 都只接受一个参数
4.  resolve 和 reject 就是 .then(succes, fail) 里面的 success 和 fail
5.  resolve 和 reject 并不是 .then(succes, fail) 里面的 success 和 fail，resolve 会去调用 success，reject 会去调用 fail

## 跨域

源：协议+域名+端口号  浏览器限制

> 为什么可以跨域使用css、js、图片等？
>
> 同源策略限制数据访问，引用时不知道具体内容



### CORS

> 声明这些网站达成一致

### JSONP

将数据文件用js进行包裹  然后取出来

**`Document.referrer`** 返回的是一个 [URI](https://www.w3.org/Addressing/#background), 当前页面就是从这个 URI 所代表的页面 跳转或打开的.

script标签拿不到状态码  定位错误有些困难  只能发get请求 不支持post



不支持CORS背景下执行一个js文件  文件中有相应的数据 按代码思路

### postmessage

网页端通信

