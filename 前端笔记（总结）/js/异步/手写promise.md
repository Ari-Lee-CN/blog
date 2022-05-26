# 手写promise

## 简易版promise

**基本框架**

~~~js
const PENDING = 'pending'
const RESOLVED = 'resolved'
const REJECTED = 'rejected'

function Mypromise(fn) {
    const that = this
    that.state = PENDING
    that.value = null
    that.resolvedCallbacks = []
    that.rejectedCallbacks = []
}
~~~
* 首先创建了常量that 因为代码可能会异步执行，用于获取正确的this对象
* 最开始的promise对象的状态应该是pending
* value用于保存resolve或者reject传入的值
* resolvedCallbacks和rejectedCallBacks用于保存then中的回调

接下来完善resolve和reject函数

~~~js
function resolve(value){
    if(that.state === PENDING){
        that.state = RESOLVED
        that.value = value
        that.resolvedCallbacks.map(cb => cb(that.value))
    }
}
function reject(value){
    if(that.state === PENDING){
        that.state = REJECT
        that.value = value
        that.rejectedCallbacks.map(cb => cb(that.value))
    }
}
~~~

* 判断状态并更改
* 将传入的value复制
* .map()方法遍历回调数组并执行

~~~js
try{
    fn(reslove,reject)
}catch(e){
    reject(e)
}
~~~

**实现then函数**

~~~js
MyPromise.prototype.then = function(onFulfilled, onRejected){
    const that = this;
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : v => v
    onRejected = typeof onRejected === 'function' ? onRejected :r=>throw r
    if(that.state === PENDING){
        that.resolvedCallbacks.push(onFulfilled)
        that.resolvedCallbacks.push(onRejected)
    }
    if(that.state === RESOLVED){
        onFulfilled(that.value)
    }
    if(that.state === REJECT){
        onRejected(that.value)
    }
}
~~~


~~~js
//简易版的promise
const PENDING = 'pending'
const RESOLVED = 'resolved'
const REJECTED = 'rejected'

function Mypromise(fn) {
    const that = this
    that.state = PENDING
    that.value = null
    that.resolvedCallbacks = []
    that.rejectedCallbacks = []
}
function resolve(value){
    if(that.state === PENDING){
        that.state = RESOLVED
        that.value = value
        that.resolvedCallbacks.map(cb => cb(that.value))
    }
}
function reject(value){
    if(that.state === PENDING){
        that.state = REJECT
        that.value = value
        that.rejectedCallbacks.map(cb => cb(that.value))
    }
}
try{
    fn(reslove,reject)
}catch(e){
    reject(e)
}
MyPromise.prototype.then = function(onFulfilled, onRejected){
    const that = this;
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : v => v
    onRejected = typeof onRejected === 'function' ? onRejected :r=>throw r
    if(that.state === PENDING){
        that.resolvedCallbacks.push(onFulfilled)
        that.resolvedCallbacks.push(onRejected)
    }
    if(that.state === RESOLVED){
        onFulfilled(that.value)
    }
    if(that.state === REJECT){
        onRejected(that.value)
    }
}
~~~
## 一个符合Promise/A+规范的Promise

~~~js
function resolve(value){
    if(value instanceof Mypromise){
        return value.then(resolve.reject)
    }
    setTimeout(()=>{
        if(that.state === PENDING){
            that.state = RESOLVED
            that.value = value
            that.resolvedCallbacks.map(cb => cb(that.value))
        }
    },0)
}

function reject(value){
    setTimeout(()=>{
        if(that.state === PENDING){
            that.state = REJECT
            that.value = value
            that.rejectedCallbacks.map(cb => cb(that.value))
        }
    },0)
}
~~~

* 对于resolve函数来说，首先需要判断传入的值是否为Promise类型。
* 为了保证函数的执行顺序，需要将两个函数体代码使用setTimeout包裹

