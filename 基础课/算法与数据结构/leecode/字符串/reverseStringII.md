# 题目

给定一个字符串 s 和一个整数 k，你需要对从字符串开头算起的每隔 2k 个字符的前 k 个字符进行反转。

如果剩余字符少于 k 个，则将剩余字符全部反转。

如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。

## 解题思路

和上一道题一样，设置两个指针，通过指针的移动模拟变化过程

## js版本

~~~JavaScript
//1.
var reverseString2 = function(s,k){
    int l = s.length;
    for (let left = 0; i < len; i += 2k){
        if(l-i-k <0){
            reverse
            continue
        }       
    }
}
//2.
var reverseStr = function(s,k){
    let len = s.length;
    for (let i = 0; i < len; i += (2 * k)){
        //判断剩余字符是否少于k，注意这个判断式
        k = i + k > len ? len - 1 : k;

        let left = i;
        let right = i + k - 1;

    }
}

//在js中，记得将字符串用splite()函数转化为字符串数组形式,最后使用join再次拼接成字符串形式

//3。

var reverseStr = function(s, k){
    const len = s.length;
    let resArr = s.split('');
    for ( let i = 0; i < len; i += 2 * k){
        let l = i - 1,
            r = i + k > len ? len : i + k;
        while(++l < --r){
            [resArr[l],resArr[r]] =[resArr[r],resArr[l]];
        }
    }
    return resArr.join('');
}

~~~