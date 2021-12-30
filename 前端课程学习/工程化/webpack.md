# 不使用webpack带来的问题

## 作用yu问题

创造任务执行器，将所有项目文件拼接在一起，立即调用函数表达式

~~~javascript

app.js

;(funtion(){
   var myName = "name"
})()

console.log(myName)
//表达式不能在外部访问，所以不会污染window环境

var result = (function(){
    var myName = "name"
    renturn myName
})()

console.log(result)

## 代码拆分问题

node.js中的common.js提供了模块暴露方法require

