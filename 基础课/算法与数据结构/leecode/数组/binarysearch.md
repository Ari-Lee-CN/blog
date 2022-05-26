# 题目

给定一个n个元素有序的整数型数组nums和一个目标值target，写一个函数搜索nums中的target，如果目标值存在返回下标，否则返回-1.

//math.floor()返回小于或等于给定数字地最大整数

## 解题思路

二分法解题前提：1.数组为有序数组且数组中无重复元素，数组中一旦存在重复元素，使用二分法查找返回的元素下标可能不是唯一的。
其次数组中没有重复元素，确保了数组中的元素下标不是唯一的
二分法重点在于区间定义。区间定义就是不变量，保持不变量，坚持循环不变规则。
该题一共有两种解题思路：左闭右开区间和左闭右闭区间

### js版本

1.左闭右闭区间

~~~ JavaScript
var search = function(nums,target){
    let left = 0,right= nums.length-1;
    //使用左闭右闭区间
    while(left <= right ){
        let mid = left + Math.floor((right-left)/2);
        if(num[mid]>target){
            right = mid -1;//去左边闭区间去找
        }else if(nums[mid] < target){
            left = mid + 1;//去右面闭区间去找
        }else{
            return mid;
        }
        return mid;
    }
}
~~~

2.左闭右开区间

~~~js

var search = function(nums,target){
    let left = 0 ,right = nums.length;
    while(left < right){
        let mid = left + Math.floor((right - left)/2);
        if(num[mid] > target){
            right = mid;
        }else if(nums[mid] < target){
            left = mid + 1;
        }else{
            return mid;
        }
    }
}