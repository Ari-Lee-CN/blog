# 手写call、apply、bind函数

# call

首先考虑如何实现

* 不传入第一个参数，上下文默认为window
* 改变了this的指向，使得新的对象可以执行该函数，并且能够接收参数

~~~js
Function.prototype.mycall = function(context){
    if(typeof this != 'function'){
        throw new TypeError('Error')
    }
    context = context || window
    context.fn = this
    const args = [...arguments].slice(1)
    const result = context.fn(...args)
    delete context.fn
    return result
}
~~~

代码分析：

1. 判断this的类型是否为函数，否则抛出错误
2. 定义上下文context，并且进行绑定
3. 分离call的其余参数，然后调用函数
4. 删除函数，返回调用结果

## apply

~~~js
Function.prototype.myApply = function(context) {
  if (typeof this !== 'function') {
    throw new TypeError('Error')
  }
  context = context || window
  context.fn = this
  let result
  // 处理参数和 call 有区别
  if (arguments[1]) {
    result = context.fn(...arguments[1])
  } else {
    result = context.fn()
  }
  delete context.fn
  return result
}
~~~

## bind

~~~js
Function.prototype.myBind = function(context){
    if(typeof this !== 'function'){
        throw new TypeError('Error')
    }
    const _this = this
    const args = [...arguments].slice(1)
    return function F() {
    // 因为返回了一个函数，我们可以 new F()，所以需要判断
    if (this instanceof F) {
      return new _this(...args, ...arguments)
    }
    return _this.apply(context, args.concat(...arguments))
  }
}
~~~

代码分析：

1. 前几步与之前的相同
2. bind返回函数，两种调用方式：直接调用与new调用
3. 直接调用使用apply方法实现，
4. new调用则可以忽略传入的this  因为new绑定了this