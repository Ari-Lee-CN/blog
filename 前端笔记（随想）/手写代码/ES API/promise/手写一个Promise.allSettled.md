# Promise.allSettled

## 与promise.all的比较
* 当使用promise.all执行过promise时，只要任何其中一个promise失败都会执行reject，并且reject的是第一个抛出的错误信息，只有所有的promise都被resolve时才会调用.then的成功回调
* 而promise.allSettled就可以获取数组中每一个peomise的结果，无论成功与失败
* .all更适合异步任务之间相互依赖，其中一个被reject就失去实际价值的
  
## 手写代码
~~~js
MyPromise.allSettled = function(values) {
    let promises = [].slice.call(values);
    return new MyPromise((resolve, reject)=>{
        let result = [],count = 0;
        promises.forEach(promise=>{
            MyPromise.resolve(promise).then(value=>{
                result.push({status:"fulfilled",value})
            }).catch(err=>{
                result.push(status:"rejected",err)
            }).finally(()=>{
                if(++count === promise.length){
                    resolve(result)
                }
            })
        })
    })
}
~~~