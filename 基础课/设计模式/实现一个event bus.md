~~~js

class EventEmitter{
    constructor(){
        //handlers是一个map，用于存储事件与回调之间的对应关系
        this.handlers = {}
    }
    //安装事件监听器，就接受目标事件名和回调函数作为参数
    on(eventName,cb){
        if(!this.handers[eventName]){
            //如果没有，则初始化一个监听函数队列
            this.handlers[eventName] = [];
        }
        this.handlers[eventName].push(cb);
    }
    //emit方法用于触发目标事件，它接收事件名和监听函数入参作为参数
    emit(eventName,...args){
        //检查目标事件是否有监听函数队列
        if(this.handlers[eventName]){
            //这里需要对this.handlers[eventName]做一次浅拷贝
            //z主要是为了避免once 安装的监听器在一处过程中出现顺序问题
            const handler = this.handlers[eventName].slice();
            handlers.forEach((callback)=>{
                callback(...args);
            })
        }
    }
    //移除某个事件回调队列里的指定回调函数
    off(eventName,cb){
        const callbacks = this.handlers[eventName]
        const index = callbacks.indexOf(cb)
        if(index !== -1){
            callbacks.splice(index, 1)
        }
    }
    //为事件注册单次监听器
    once(eventName,cb){
        const wrapper = (...args) =>{
            cb(...args)
            this.off(eventName,wraaper)
        }
        this.on(eventName,wrapper)
    }
}

~~~