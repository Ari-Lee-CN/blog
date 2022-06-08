# bind call apply

## call实现

思考call的功能：使用一个指定的this值，和在若干个参考值的前提下调用某个函数或者方法。

实际上采取了一种寄生式继承的思路，在内部执行一个属性调用，改变this，执行完成之后，删除相应的属性值。

### 1
~~~js

let foo = {
    value:1
}
function bar(){
    console.log(this.value);
}
bar.call(foo);//1

~~~

* bar函数执行了
* call改变了this的指向

### 2

~~~js
Function.prototype.call = function(context){
    context.fn = this;
    context.fn();
    delete context.fn;
}
// 测试一下
let foo = {
    value: 1
};

function bar() {
    console.log(this.value);
}

bar.call(foo); // 1
~~~
### 3
实现传参
~~~js
Function.prototype.call = function(context){
    context.fn = this;
    let args = [];
    for(let i = 0; i < arguments.length;i < len;i++ ){
        args.push( arguments[i] );
    }
    eval('context.fn(' + args +')');
    delete context.fn;
}
~~~

## 最终的call实现：

~~~js
Function.prototype.call = function(context){
    context = context ? Object(context):window;//默认绑定window
    context.fn = this //重置上下文
    let args = [...arguments].slice(1)//截取参数a，b
    let r = context.fn(...args) //执行函数
    delete context.fn //删除属性，避免污染
    return r//返回结果
}
~~~

## 最终的apply实现

~~~js
Function.prototype.apply = function(context){
    context = context ? Object(context):window
    context.fn = this
    let args = [...arguments][1]
    if(!args)return context.fn()
    let r = context.fn(...args) //执行函数
    delete context.fn //删除属性，避免污染
    return r//返回结果
}
~~~

## bind 实现
bind方法创建一个新韩淑，调用时，新函数的this被指定为bind()的第一个参数，其余参数将作为新函数的参数，供调用使用
~~~js
Function.prototype.FakeBind = function(obj,...args){
    return (...rest) => this.call(obj,...args,...rest)
}
~~~

### 软绑定
>如果this不为window或者undefied，则绑定
~~~js
function.prototype.softBind = function(obj,...args){
    const fn = this
    const bound = function(...args) {
        const o = !this || === (window || global)?obj:this
        return fn.apply(o,[...rest],[...args])
    }
    bound.prototype = Object.create(fn.prototype)
    return bound
}
~~~