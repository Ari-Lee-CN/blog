# 题目

给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的连续子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。

示例：

输入：s = 7, nums = [2,3,1,2,4,3] 输出：2 解释：子数组 [4,3] 是该条件下的长度最小的子数组。

## 解题思路

1.暴力枚举法 两个for循环来不断寻找符合条件的子序列，时间复杂度为O（n^2）。
2.滑动窗口法 不断调整子序列的起始位置和终止位置来得到我们想要的结果。

三个关键点：
窗口内是满足和大于等于s的长度最小的连续子数组
窗口的起始位置移动：当前窗口的值大于s，窗口向前移动。
窗口的结束位置移动：遍历数组的指针。

## js版本

~~~JavaScript
var minSubArrayLen = function(target,nums){
    const len = nums.length;
    let l = r = sum = 0,
        res = len + 1;
        while(r < len){
            sum += nums[r++];
            //r是窗口结束位置，窗口滑动
            while（sum >= target）{
                //r始终为开区间[1,r]
                res = res < r-1 ? res :r - 1;
                //子数组最大不会超过自身
                sum -= nums[l++];
                //l是窗口结束位置
            }
        }
         return res > len ? 0 : res; 
};

~~~