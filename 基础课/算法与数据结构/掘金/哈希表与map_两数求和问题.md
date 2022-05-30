给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

哈希表法，哈希表是一个对象
~~~js
var twoSum = function(nums,target){
    hash = {};
    for(i=0,i<nums.length;i++){
        if(hash[target-nums[i]] !== undefined){
            return [i,hash[target - nums[i]]]
        }
        hash[nums[i]] = i;
    }
    return [];
}
~~~
map法
~~~typescript
function twoSum(nums:number[],target:number):number[]{
    let helperMap:Map<number,number> = new Map();
    let index:number | undefined;
    let resArr:number[] = [];
    for(let i=0,length = nums.length;i<length;i++){
        index = helperMap.get(target - nums[i]);
        if(index !== undefined){
            resArr = [i,index]
        }
        helperMap.set(nums[i],i);
    }
    return resArr;
}

~~~