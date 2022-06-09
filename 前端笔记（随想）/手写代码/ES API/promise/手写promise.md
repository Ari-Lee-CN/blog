 首先实现一个简易的promise函数
 ~~~js
const PEDDING = "pending"
const RESOVLED = "resolved"
const REJECT = "rejected"

function myPromise(fn) {
    const that = this
    that.value = null
    that.state = PEDDING
    that.resolvedcallbacks = []
    that.rejectedcallbacks = []
}

function resolve(fn) {
    if(that.state === PEDDING) {
        that.state = RESOLVED
        that.value = value
        that.resolvedcallbacks.map(cb => cb(that.value))
    }
}

function reject(fn) {
    if (that.state === PENDING){
        that.state = REJECT
        that.value = value
        that.resolvedcallbacks.map(cb => cb(that.value))
    }
}
try{
    fn(resolved,rejected)
}catch(e){
    reject(e)
}

Mypromise.prototype.then = function(onFulfilled, onRejected){
    const that = this
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled: v => v
    onRejected = typeof onRejected === 'function' ? onRejected:r =>{
        throw r
    }
    if(that,state === PENDING){
        that.resolvedcallbacks.push(onFulfilled)
        that.rejectedcallbacks.push(onRejected)
    }
    if(that,state === PENDING){
        onFulfilled(that.value)
    }
    if(that.state === Rejected){
        onRejected(that.value)
    }
}
 ~~~

 一个符合Promise/A+规范的Promise
 ~~~js
//resolve需要判断是否为promise reject不需要
//为保证执行顺序，需要将两个函数体代码使用setTimeout包裹起来
function resolve(value) {
    const that = this;
    if(value instanceof myPromise) {
        return value.then(resolve,reject);
    }
    setTimeout(()=>{
        if(that.state === PENDING){
            that.state = RESOLVED
            that.value = value;
            that.resolvedCallbacks.map(cb => cb(that.value))
        }
    },0)
}
function reject(value) {
    const that = this
    setTimeout(() =>{
        if(that.state === PENDING){
            that.state = REJECT
            that.value = value
            that.rejectedCallbacks.map(cb => cb(that.value))
        }
    })
}
//需要新增一个变量promise2，因为每个then函数都需要返回一个新的Promise对象，用于保存新的返回对象
Mypromise.prototype.then = function(onFulfilled, onRejected){
    const that = this;
    if(that.state === PENDING){
        return(promise2 = new MyPromise((resolve, reject) =>{
            that.resolvedCallbacks.push(()=>{
                try{
                    const x =onFulfilled(that.value)
                    resolutionProcedure(promise2,x,resolve,reject);
                }catch(e){
                    reject(r)
            }
            })
            that.rejectedCallbacks.push(()=>{
                try{
                    const x = onRejected(that.value)
                    resolutionProcedure(promise2, x, resolve, reject)
                } catch (r) {
                    reject(r)
                }
            })
        }))
    }
    if (that.state === RESOLVED) {
        return (promise2 = new MyPromise((resolve, reject) => {
            setTimeout(() => {
            try {
                const x = onFulfilled(that.value)
                resolutionProcedure(promise2, x, resolve, reject)
            } catch (reason) {
                reject(reason)
            }
            })
        }))
    }
    if(that.state === REJECT){
       return (promise2 = new MyPromise((resolve, reject) => {
            setTimeout(() => {
            try {
                const x = onRejected(that.value)
                resolutionProcedure(promise2, x, resolve, reject)
            } catch (reason) {
                reject(reason)
            }
            })
        }))
    }
}
function resolutionProcedure(promise, x, resolve, reject){
    if(promise2 === x){
        return reject(new TypeError('Error'))
    }
    let called = false
    if (x !== null && (typeof x === 'object' || typeof x === 'function')) {
    try {
        let then = x.then
        if (typeof then === 'function') {
        then.call(
            x,
            y => {
                if (called) return
                called = true
                resolutionProcedure(promise2, y, resolve, reject)
            },
            e => {
            if (called) return
                called = true
                reject(e)
            }
        )
        } else {
            resolve(x)
        }
    } catch (e) {
        if (called) return
            called = true
            reject(e)
    }
    } else {
         resolve(x)
    }
}
 ~~~

- 首先创建一个变量 `called` 用于判断是否已经调用过函数
- 然后判断 `x` 是否为对象或者函数，如果都不是的话，将 `x` 传入 `resolve` 中
- 如果 `x` 是对象或者函数的话，先把 `x.then` 赋值给 `then`，然后判断 `then` 的类型，如果不是函数类型的话，就将 `x` 传入 `resolve` 中
- 如果 `then` 是函数类型的话，就将 `x` 作为函数的作用域 `this` 调用之，并且传递两个回调函数作为参数，第一个参数叫做 `resolvePromise` ，第二个参数叫做 `rejectPromise`，两个回调函数都需要判断是否已经执行过函数，然后进行相应的逻辑
- 以上代码在执行的过程中如果抛错了，将错误传入 `reject` 函数中