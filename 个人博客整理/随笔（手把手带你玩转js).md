# 随笔（手把手带你玩转js)

## es2021新特性 promise

### promise.any

# ![image-20211124103322442](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211124103322442.png)

![image-20211124103331712](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211124103331712.png)

.reject()b被跳过

#### 代码演示

~~~javascript
function resolveTimeout(value, delay) {
    return new Promise((resolve) => setTimeout(() => resolve(value), delay));
}

function rejectTimeout(reason, delay) {
    return new Promise((r, reject) => setTimeout(() => reject(reason), delay));
}

~~~

resove 与reject的延时处理



## ajax







