返回第一个处理完成的结果，所以只需要在all的基础上，去掉all的计数器和逻辑判断就可以了.
~~~js
function promiseAll(_promises) {
    return new Promise((resolve, reject) =>{
        const promises = Array.from(_promises)
        const r = []
        let len = promises.length
        let count = 0;
        for(let i = 0; i < len; i++){
            Promise.resolve(promises[i]).then(o =>{
                r[i] = o
                if(++count = len){
                    resolve(r)
                }
            }).catch(err =>reject(err))
        }
    })
}
~~~

那么promise.race就是：
~~~js

function promiseRace(_promises){
    return new Promise((resolve, reject)=>{
        for(const i of _promises){
            Promise.resolve(i)
            .then((res)=>{
                resolve(res)
            })
            .catch(err =>reject(err))
        }
    })
}

Promise.myRace = function(iterators) {
    const promises = Array.from(iterators);

    return new Promise((resolve, reject) => {
        promises.forEach((promise, index) => {
            Promise.resolve(promise)
                .then(resolve)
                .catch(reject);
        });
    });
};
~~~