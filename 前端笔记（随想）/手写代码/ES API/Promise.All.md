# Promise.all

api解构：Promise.all() 方法接收一个 promise 的 iterable 类型（注：Array，Map，Set 都属于 ES6 的 iterable 类型）的输入，并且只返回一个Promise实例， 那个输入的所有 promise 的 resolve 回调的结果是一个数组。这个Promise的 resolve 回调执行是在所有输入的 promise 的 resolve 回调都结束，或者输入的 iterable 里没有 promise 了的时候。它的 reject 回调执行是，只要任何一个输入的 promise 的 reject 回调执行或者输入不合法的 promise 就会立即抛出错误，并且 reject 的是第一个抛出的错误信息。

关键步骤：
1. 返回一个promise实例
2. 执行每一个promise，正确结果保存，失败则报错获取错误信息

~~~js
function pAll(_promises) {
    return new Promise((resolve, reject)=>{
        //将Iterable类型转换为Array类型
        const promises = Array.from(_promises)
        //结果用一个数组维护
        const r = []
        const len = promises.length
        let count = 0
        for(let i = 0; i < len; i++) {
            //Promise.resolve确保把所有数据转化为Promise
            Promise.resolve(promises[i]).then(o=>{
                //Promise是异步的，保持数组一一对应
                r[i] = o;
                //如果数组中所有promise都能完成，返回结果数组
                if(++count === len){
                    resolve(r)
                }
            }).catch(e => reject(e));
        }
    })
}
~~~