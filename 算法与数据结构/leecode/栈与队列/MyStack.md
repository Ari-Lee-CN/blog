# 题目

使用队列实现栈的下列操作：

push(x) -- 元素 x 入栈
pop() -- 移除栈顶元素
top() -- 获取栈顶元素
empty() -- 返回栈是否为空

## 思路

使用数组（push shift） 模拟队列

## js版本

~~~JavaScript

//两个队列
var MyStack = function() {
    queue1 = [];
    queue2 = [];
};

Mystack.prototype.push = function(){
    this.queue1.push(x);
}

Mystack.prototype.pop = function(){
    if(!this.queue.length){
        [this.queue1, this.queue2] = [this.queue2,this.queue1];
    }
    while(this.queue1.length > 1){
        this.queue2.push(this.queue1.shift());
    }
    return this.queue1.shift();
}

Mystack.prototype.top = function(){
    const x = this.pop();
    this.queue1.push(x);
    return x;
};

Mystack.prototype.empty = function(){
    return !this.queue1.length && !this.queue2.length;
}
~~~
