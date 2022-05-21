# 题目

编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 $O(1)$ 的额外空间解决这一问题。

你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

## 思路

反转字符串和反转链表还是有一定的区别的，对于字符串就可以直接定义两个指针从两侧向中间交换。

## js版本

~~~javascript

var reverseString = function(s){
    return s.reverse();
}

var reverseString = function(s){
    let l = 0, r = s.length-1;
    while(l++ < r--) {
        [s[l], s[r]] = [s[r], s[l]];
        return s;
    }
};
~~~