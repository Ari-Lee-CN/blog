# 题目

请实现一个函数，把字符串 s 中的每个空格替换成"%20"

## 思路

这里要注意到，替换后会引起数组大小变化，相关下标等也会因此发生变化

推荐先预先为数组扩容然后从后向前操作

## js 版本

~~~JavaScript

var replaceSpace = function(s){
    const len = s.length;
    let count = 1;
    resArr = s.splite('');
    for(let i = 0; i < len; i++){
        if(resArr[i] == " "){
            count ++;
        }
    };
    let left = resArr.length - 1;
    let right = resArr.length + count * 2 - 1;

    while(left >= 0){
        if(strArr[left] === ' '){
            strArr[right--] = '0';
            strArr[right--] = '2';
            strArr[right--] = '%';
            left--;
        }else{
            strArr[right--] = strArr[left--];
        }
    }
    return strArr.join('');
};
~~~
