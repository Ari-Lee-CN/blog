# axios

## axios基本使用

~~~ html
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>axios基本使用</title>
    <link crossorigin="anonymous" href="https://cdn.bootcss.com/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/0.21.1/axios.min.js"></script>
</head>
<body>
    <div class="container">
        <h2 class="page-header">基本使用</h2>
        <button class="btn btn-primary"> 发送GET请求 </button>
        <button class="btn btn-warning" > 发送POST请求 </button>
        <button class="btn btn-success"> 发送 PUT 请求 </button>
        <button class="btn btn-danger"> 发送 DELETE 请求 </button>
    </div>
    <script>
        //获取按钮
        const btns = document.querySelectorAll('button');
        //第一个
        btns[0].onclick = function(){
            //发送AJAX请求
            axios（{
                //请求类型
                method:'GET',
                //URL
                url:'http://localhost:3000/posts/2',
            }.then(respnse =>{
                console.log(response);
            });
        
        btn[1].onclick = function(){
            //发送ajax请求
            axios({
                //请求类型
                method:'POST',
                //URL
                url:'http://localhost:3000/posts/2',
                //设置请求体
                data：{
                    title:'今天天气不错'
                    author：'张三'
                }
            }).then(respnse =>{
                console.log(response);
            });
        }
        }
    </script>
</body>
</html>
~~~

## axios其他使用方式

~~~JavaScript
const btns = document.querySelectorAll('button');

btn[0].onclick = function(){
    //axios()和axios.request
    axios.request({
        method:'GET',
        url:'http://localhost:3000/comments'
    })then(response =>{

    })


    btn[1].onclick = function(){
    //axios()和axios.post 请求
    axios.post({
       'http://localhost:3000/comments',
       {
           "body":"1",
           "postId":2
       }
    })then(response =>{

    })
}
~~~

## axios响应

request保存axios创建的实例对象

## axios配置对象(request config)

url：   服务器端url

method  请求方式

baseURL 服务器url补全

transformRequest    允许在数据在传输到服务器端之前被更改，它只对put、post、patch、delete生效

transformResponse   同上

headers     头信息

params      参数

paramSerializer        参数序列化，对请求参数进行序列化  转化为字符串

data        对象形式与字符串形式，对象形式转换为json，字符串形式直接传递

data:{
    firstName:'Fred'
}//对象形式
data:'Country=Brascil&City=Belo Horizonte'
//字符串形式

timeout   多久之后执行

withCredentials:false//default
是否表示跨站访问控制请求 比如把cookie携带过去

adapter：funtion(config){}  对请求识别器进行设置

auth:{
    username:'',
    password:'',
}
对请求的基础 验证

responseType: 'json', // default
设置默认响应格式

xsrfHeaderName: 'X-XSRF-TOKEN', // default
xsrfCookieName: 'XSRF-TOKEN', // default
跨站请求表示，对cookie和头信息进行设置

onUploadProgress:function  
onDownloadProgress:

validatestatus  对响应结果的成功进行设置

maxRedirects:  最大跳转次数，仅用于  node.js

socketParh

httpAgent
httpsAgent

proxy  代理

cancelToken  取消ajax

signal

docompress

### 默认配置

axios.defaults.method = 'GET';
对默认发送方式进行修改
axios.defaults.baseURL = "http://localhost:3000";

## 创建实例对象

~~~JavaScript
const btns = document.querySelectorAll('button');
//创建实例对象
const duanzi = axios.create({
    baseURL:
    timeout:
});
//这里 duanzi 和axios 对象的功能几近是一样的
duanzi({
    url:'/getJoke',
}).then(response =>{
    console.log(response);
})
duanzi.get({'/getJoke',}).then(response =>{
    console.log(response.data);
})
//可以通过设置baseURL设置多个实例对象，分别对于不同的接口进行设置
~~~

## axios拦截器interceptors

~~~JavaScript
// 设置请求拦截器
axios.interceptors.request.use(function (config) {
    console.log('请求拦截器');
    return config;
  }, function (error) {
    // 请求拦截器失败
    console.log('请求拦截器失败');
    return Promise.reject(error);
  });

//设置响应拦截器
axios.interceptors.response.use(function (response) {
    console.log('响应拦截器 成功')
    return response;
  }, function (error) {
    console.log('响应截器失败');
    return Promise.reject(error);
});

//发送请求
axios({
    method:'GET',
    url:'http://localhost:3000/post'
}.then(response => {
    console.log('自定义回调处理成功的结果')
}).catch(reason => {
    console.log('自定义失败回调')
})

//如果同时在请求和回应都设置多个拦截器，请求拦截器是堆栈，响应拦截器是队列
//如果只对其中一个属性进行拦截处理，那么返回的时候可以返回renturn.data
~~~

## axios取消请求

~~~javascript
const btns = document.querySelectorAll('button');
//声明一个全局变量
let cancel = null；

btns[0].onclick = function(){
    //检测上一次请求是否已经完成
    if(cancel!=null){
        //取消上一次请求
        cancel();
    }
    axios({
        method:'GET',
        url:'http://localhost:3000/posts'
        //1,添加配置对象的属性
        cancelToken:new axios.CancelToken(function(xingcan){
            //3，将C的值赋值给cancel
            cancel = xingcan；
        })
    }).then(response=>{
        console.log(response)
        cancel = null;
    })
};
//绑定第二个事件取消请求
~~~
