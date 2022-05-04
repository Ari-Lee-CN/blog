# 题目

给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

## 思路

1.暴力算法，两重for循环同时还要记录字符是否重复出现、
2.哈希表方式。通过哈希表的关键码遍历，定义一个数组，大小为26，记录哈希表中的小写字母，对于前一个数组每有一个字母+1 对于后一个数组，每有一个字母-1 最后如果有的元素不为0则说明不是字母异位词

这里利用了ASCII码、

## js版本

~~~javascript

var isAnagram = function(s,t){
    if(s.length != t.length) return false;
    const reset = new Array(26).fill(0);
    const base = 'a'.charCodeAt();
    for(const i of s){
        reset[i.charCodeAt() - base]++;
    }
    for(const i of t){
        if(! reset[i.charCodeAt() - base])return false;
        reSet[i.charCodeAt() - base]--;
    }
    return true;
}

~~~