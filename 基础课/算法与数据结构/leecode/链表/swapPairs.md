# 题目

给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。

你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。

## 思路

其实还是一个更改指针指向的题目，然后涉及链表的头节点的操作都建议使用虚拟头节点，然后最好来画图，搞清操作的先后顺序。

对于一对节点，分为三步，串联上一对、交换、串联下一对

## js版本

~~~javascript

var swapPairs = function (head){
    let ret = new ListNode(0,head),
    let temp = ret,
    let cur = temp.next.next, pre = temp.next;
    while(cur && pre){
        pre.next = cur.next;
        cur.next = pre;//实现了交换和与下一对的关联
        temp.next = cur;
        temp = pre;
    }
    return ret.next;
}

~~~