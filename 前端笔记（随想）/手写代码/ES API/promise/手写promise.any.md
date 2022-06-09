思路是：只要promise有一个是fullfilled则立即resolve出去，否则将所有reject结果收集起来并返回AggregateError

首先看promise.all

~~~js
function promiseAll(_promises) {
    return new Promise((resolve, reject)=> {
        const promises =Array.from(_promises);
        let r = [];
        let len = promises.length;
        let count = 0;
        promises.forEach((promise,index)=>{
            Promise.resolve(promise)
                .then(value=>resolve(value))
                .catch(error =>{
                    r[index] = error
                    if(++count === len){
                        reject(r)
                    }
                })
        })
    })
}