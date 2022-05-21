# 题目

给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。

## 解题思路

还是使用双指针法

## js版本

~~~javascript
var fourSum = function(nums, target){
    const len = nums.length;
    if(len < 4 ) return [];
    nums.sort((a,b) => a-b);
    const res = [];
    for(let i = 0; i < len - 3; i++){
        //去重i
        if(i > 0 && nums[i] === nums[i - 1]) continue;
        for(let j = i + 1; j < len - 2; j++){
            //去重j
            if(j > 0 && nums[j] === nums[j - 1]) continue;
            let l = j + 1, r = len - 1;
            while(l < r){
                const sum = nums[i] + nums[j] + nums[r];
                if(sum < target){ l++;continue; }
                if(sum > taget){r--;continue}
                res.push([nums[i], nums[j], nums[l], nums[r]]);
                while(l < r && nums[l] === nums[++l]);
                while(l < r &&nums[r] === nums[--r]);
            }
        }
    }
};
~~~