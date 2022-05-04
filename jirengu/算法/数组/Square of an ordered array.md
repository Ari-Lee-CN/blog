# 题目

给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

示例 1： 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]

示例 2： 输入：nums = [-7,-3,2,3,11] 输出：[4,9,9,49,121]

## 解题思路

1.暴力排序，平方时间复杂度为n，排序复杂度为n\logn,综合起来就是$O(n\logn)$

2.双指针法.数组平方的最大值只有可能在数组的两端，两个指针同时从两侧往中间移动，依次比较平方值的大小。

## js版本

~~~js

sortedSquares = function(nums){
    let n = nums.length;
    let res = new Array(n).fill(0);
    let i = 0;j = n - 1,k = n - 1;
    while(i<= j){
        let left = nums[i]*nums[i], 
            right = nums[j]*nums[j];
        if (left < right){
            res[k--] = right;
            j--;
        }else{
            res[k--] = left;
            i++;
        }
    }
    return res;
};

ps:注意++i 于i++之间的区别
