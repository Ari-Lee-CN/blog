# 题目

：给定两个数组，编写一个函数来计算它们的交集

## 思路

1.使用数组的方式来解，但是如果哈希值比较少，特别分散，跨度非常大，使用数组就会造成空间的极大浪费。
2.使用set  set是存储唯一值的集合，相比于数组，占用空间大，速度慢，将数组映射到key上需要做hash运算，当数据量较大的情况下，差距较为明显。

### js版本

~~~JavaScript

//考虑到数组大小，可以一定程度上减小计算量

var intersection = function(nums1, nums2){
    if(nums1.length > nums2.length){
        [nums1, nums2] = [nums2, nums1];
    }
    let reSet = new Set(),
        nums1Set = new Set(nums1);
    for(let i of nums2){
        if(nums1Set.has){
            reSet.add(i);
        }
    }
    return Array.from(reSet);
}

~~~

Map.prototype.has  、Map.prototype.add