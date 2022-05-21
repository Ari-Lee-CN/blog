# 题目

给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

## 解题思路

注意三个元素不重复

1.哈希表

计算a+b 可能的值，然后看对应的c的值是否存在，这样存在一个问题就是要在c中去掉a、b的值

2.指针法

先对整个数组进行排序，然后再最左边和最右边各定义一个指针

## js版本

~~~JavaScript

var threeSum = function(nums){
    const len = nums.length;
    if(len < 3) return [];
    nums.sort((a,b) => a-b);
    const res = [];
    for(let i = 1; i < len - 1; i++){
        let left = 0, right = len - 1,
        while(left < right){
            const sum = nums[left] + nums[right] + nums[i];
            if(sum < 0) {left++; continue; }
            if(sum > 0){right--; continue; }
            res.
        }
    }
}


var threeSum = function(nums){
    let res = [];
    const len = nums.length;
    //排除意外
    if(nums == null ||len < 3)return res;
    nums.sort((a,b) => a - b);
    for(let i = 0; i < len ; i++){
        if(nums[i] > 0)break;
        if(i > 0 &&nums[i] == nums[i-1]) continue; //去重

        let L = i + 1；
        let R = len-1；
        while(L < R){
            const sum = nums[i] + nums[L] + nums[R];
            if(sum = 0){
                res.push([nums[i],nums[L],nums[R]]);
                while(L < R && nums[L] == nums[L + 1]) L++;
                while(L < R && nums[R] == nums[R - 1]) R++;
                L++;
                R--;
            }
            else if(sum < 0)L++;
            else if(sum > 0)R--;
        }
    }
    return res;
}
~~~

关于i 与left的位置问题  以及如何利用循环