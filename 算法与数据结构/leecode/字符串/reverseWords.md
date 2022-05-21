# 题目

给定一个字符串，逐个翻转字符串中的每个单词。

示例 1：
输入: "the sky is blue"
输出: "blue is sky the"

示例 2：
输入: "  hello world!  "
输出: "world! hello"
解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。

示例 3：
输入: "a good   example"
输出: "example good a"
解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个

## 思路

题目中明显可以看出空格是没有关系的因素，思路是去掉空格，整体翻转，再挨个翻转单词

或者可以用splite函数分割再相加

## js版本

~~~JavaScript

var eraseSpace = function(strArr){
    for(let i = 0; i < s.length;i++){
        let left = 0;
        let right = i;
        if(resArr[i] != ' '){
            resArr[left] = resArr[right];
            left++;
        }
    }
    return resArr.join('');
}

var reverse = function(strArr,start,end){
    while(start < end){
        [strArr[start], strArr[end]] = [strArr[end],strArr[start]];
        start++;
        end--;
    }
}

var reverseWords = function(s,start,end){
    const strArr = Array.from(s);
    reaseSpace(strArr);
    reverse(strArr, 0, strArr.length-1);

    let start = 0;

    for(let i = 0;i < strArr.length; i++){
        if(strArr[i] == ' ' || i == strArr.length){
            reverse(strArr, start, i - 1);
            start = i + 1;
        }
    }

    return strArr.join('');
}
~~~

Array from 是对一个类似数组或者可迭代对象创建一个新的、浅拷贝的数组实例。

