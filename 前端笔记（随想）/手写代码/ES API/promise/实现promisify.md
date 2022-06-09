> 将call back 转化为 promise对象

~~~js
function promisefy(reaFile){
    return function(...args){
        return new Promise((resolve, reject)=>{
            readFile(...args,(err,data)=>{
                if(err) reject(err);
                resolve(data)
            })
        })
    }
}

~~~