# delay和sleep
sleep()实现线程沉睡，达到延迟执行函数的目的

## sleep()
~~~js
const sleep = (seconds) =>new Promise(resolve =>setTimeout(resolve,seconds))

~~~

## delay()
~~~js
function delay(func,seconds,...args) {
    return new Promise((resolve,reject) =>{
        setTimeout(()=>{
            Promise.resolve(func(...args)).then(resolve);
        },seconds);
    })
}
~~~