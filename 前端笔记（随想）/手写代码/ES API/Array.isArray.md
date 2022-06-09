判断数据类型常用的方式：
~~~js
Array.isArray = function(value) { 
    return Object.prototype.toString().call(value) === '[object Array]';
}

~~~