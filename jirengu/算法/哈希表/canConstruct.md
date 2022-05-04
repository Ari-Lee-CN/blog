# 题目

给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。如果可以构成，返回 true ；否则返回 false。

(题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志字符串中的每个字符只能在赎金信字符串中使用一次。)

## 解题思路

1.暴力枚举，两次for循环

2.哈希解法，因为只有小写字母，可以采用空间换取时间的哈希策略，用一个长度为26的数组记录magazine里字母出现的次数，然后去验证这个数组是否包含了resomNote所需要的所有字母

在这里使用map的空间消耗比数组大，因为map要维护红黑树或者哈希表，并且还要做哈希函数，是费时的

## js版本

var canConstruct = function (ransomNote, magazine){
    const strArr = new Array(26).fill(0),
    const base = 'a'.charCodeAt(),
    for(const s of magazine){
        strArr[s.charCodeAt() - base]++;
    }
    for(const s of ransomNote){
        const index =s.charCodeAt() - base;
        if(!strArr[index]--);
    }
    return true;
};
~~~