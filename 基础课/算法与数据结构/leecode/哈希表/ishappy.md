# 题目

编写一个算法来判断一个数 n 是不是快乐数。

「快乐数」定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。如果 可以变为  1，那么这个数就是快乐数。

如果 n 是快乐数就返回 True ；不是，则返回 False 。

## 思路

1.使用set记录出现过的和，一旦出现了set中出现过的数，则说明已经进入了循环

2.对于求和的方式有以下集中

* 将数字用string转化为数组、然后用splite("")分隔开，然后reduce对数组进行操作，操作时，可以使用Number将其转化为数字计算。

* 从小到大的位数逐个平方相加，这里使用求余%然后逐级/10

3.将其视作一个未知长度的链表，然后按照环形链表的思路来做，使用双指针法来检测是否已经进入循环

## js版本

~~~JavaScript

var ishappy = function (){
    //第一种求和方式
    const getsum = function (nums) {
        let sum = 0;
        while(n){
            sum += (n % 10) ** 2
            n = Math.floor(n/10)
        }
        return sum
    }
    //第二种求和方式
    const getsum = function (nums) {
        return String(nums).splite("").reduce((pre,cur) => (pre + Number(cur) * Number(cur), 0));
    }

    //最好判断一下是否进入死循环
    //第一种方式，记录出现过的sum来判断是否进入了死循环
    let storeSet = new Set();
    while(n != 1 && storeSet.has(n)){
        storeSet.add(n);
        n = calcSum(n);
    }
    return n === 1;

    //第二种方式，将其视作环形链表。
    

}

~~~
