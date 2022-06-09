# Promise
> Promise引入状态机制(等待态、执行态、拒绝态)，可以异步延时地执行链式操作，并应对失败处理、异常处理。
> 在执行promise过程中，promise会利用回调函数onresolved和onrejected异步触发resolve和reject事件，创建新的promise对象收集处理结果与异常反馈，利用.then将多层嵌套转变成链式调用，.then函数逐级收集promise对象，集中所有信息。

## 使用Promise封装ajax
~~~js
function ajax(method, url, data){
    let xhr = new XMLHttpRequest();
    return new Promise(function(resolve, reject){
        xhr.onreadystatechange = function(){
            if(xhr.readyState === 4){
                if(xhr.status === 200){
                    resolve(xhr.responseText);
                }else{
                    reject(xhr.status)
                }
            }
        };
        xhr.open(method,url)
        xhr.send(data)
    })
}
~~~

## api作用
* Promise.all()
并行执行多个Promise，并等待所有promise执行完成或者其中一个promise执行失败，返回一个新的promise对象
* Promise.allSettled()
等所有promise都处理完成之后，返回一个处理完成的promise，并带有一个对象数组，每一个对象表示对应的promise结果
* Promise.race() 
并行执行多个promise，返回第一个处理完成的promise地结果
* Promise.any()
并行执行多个promise，返回第一个fulfilled的promise结果，如果都rejected，则返回rejected 的 promise 和 AggregateError 错误类型的 error 实例—— 一个特殊的 error 对象，在其 errors 属性中存储着所有 promise error。
* Promise.resolve()
返回一个由给定value决定的Promise对象
* Promise.reject()
返回一个状态为已拒绝的Promise对象