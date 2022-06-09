~~~js

function resolve(value) {
    const that = this;
    if(value instanceof myPromise) {
        return value.then(resolve,reject);
    }
    setTimeout(()=>{
        if(that.state === PENDING){
            that.state = RESOLVED
            that.value = value;
            that.resolvedCallbacks.map(cb => cb(that.value))
        }
    },0)
}
function reject(value) {
    const that = this
    setTimeout(() =>{
        if(that.state === PENDING){
            that.state = REJECT
            that.value = value
            that.rejectedCallbacks.map(cb => cb(that.value))
        }
    })
}