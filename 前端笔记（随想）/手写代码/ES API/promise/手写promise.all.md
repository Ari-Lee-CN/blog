* Promise.all 并行执行多个Promise(参数往往是iterator类型),并等待所有promise都准备就绪；如果所有promise成功，则返回一个含有所有promise返回值的数组，如果任意一个promise失败，则以该对象失败的理由作为失败返回，并忽略其他promise

~~~js
function promiseAll(args) {
    return new Promise((resolve, reject) => {
        const promiseResults = [];
        let iteratorIndex = 0;//输出顺序
        //输出顺序与完成顺序并不一致
        let fullcount = 0;//完成顺序
        for(const item of args) {
            let resultIndex = iteratorIndex;
            iteratorIndex += 1;
            Promise.resolve(item).then(res =>{
                promiseResults[resultIndex] = res;
                fullCount += 1;
                if(fullCount === iteratorIndex){
                    resolve(promiseResults)
                }
            }).catch(err =>{
                reject(err);
            })
        }
        if(iteratorIndex === 0){
            resolve(promiseResults)
        }
    })
}
//简化版
function promiseAll(_promises){
    return new Promise((resolve, reject)=>{
        const promises = Array.from(_promises)
        const r = []
        const len = promises.length
        let count = 0
        for(let i = 0; i < len; i++){
            Promise.resolve(promises[i]).then(res=>{
                r[i]=res
                if(++count === len){
                    resolve(r)
                }
            }).catch(err =>reject(err))
        }
    })
}

function promiseAll(_promises){
    return new Promise((resolve, reject)=>{
        const promises = Array.from(_promises)
        const r = []
        const len = promises.length
        let count = 0
        promises.forEach((promise, index)=>{
            Promise.resolve(promise)
                .then(value =>{
                    r[index] = value
                    if(++count === len){
                        resolve(r)
                    }
                })
                .catch(reject);
        })
    })
}
~~~