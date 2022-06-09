#  监听input输入值变化的方案

## 监听的事件：
* keypress
* keydown
* keyup
* input
* onChange(不能实时监听)
因为onChange需要失去焦点时才能触发

## 监听常用方案：
oninput + onpropertychange
~~~js
function onInputHandler(event){
    console.log(event.target.value)
}

~~~