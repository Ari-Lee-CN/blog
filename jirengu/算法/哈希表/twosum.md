# 题目

给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

## 思路

将整数数组看作一个set 然后从头每个元素减去目标值，查询所得结果是否存在于整数数组之中。

## js版本

~~~JavaScript

function twoSum(nums, target){
    let helperMap = new Map();
    let index ;
    let resArr = [];
    for(let i = 0 , length = nums.length; i < length; i++){
        index = helperMap.get(target - nums[i]);
        if( index != undefined){
            resArr = [i, index];
        }
        helperMap.set(nums[i],i);
    }
    return resArr;
}

~~~