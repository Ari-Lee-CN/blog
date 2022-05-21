// 引入express
const express = require('express');

// 创建应用对象
const app = express();

/* 
创建路由规则
request是对请求报文地封装
response是对响应报文地封装
*/

app.get('/server',(request, response) =>{
    //设置相应
    response.send('HELLO AJAX');
});

//app.all表示可以接收任何类型地请求

app.post('/server',(request, response) =>{
    //设置响应头，设置允许跨域
    response.setHeader("Access-Control-Allow-Origin", "*");
    //响应头
    response.setHeader("Access-Control-Allow-Headers", "*");
    //响应一个数据
    const data = {
        name:'me'
    };
    //对对象进行字符串转化
    let str = JSON.stringify(data);
    //设置响应体
    response.send(str);
})

//针对IE缓存
app.get('/IE',(request,response) => {
    //设置响应头，设置允许跨域
    response.setHeader('Access-Control-Allow-Origin', '*');
    //设置响应体
    response.send('HELLO IE');
});

//延时响应
app.get('/delay', (request, response) => {
    response.setHeader('Access-Control-Allow-Origin', '*');
    setTimeout(() => {
        response.send('延时响应');
    },3000)
});

//fetch 服务
app.get('/fetch-server', (request, response) => {
    //设置响应头 设置允许跨域
    response.setHeader('Access-Control-Allow-Origin', '*');
}
')

//监听端口启动服务
app.listen(8000,()=>{
    console.log("服务已经启动，8000端口监听中");
})