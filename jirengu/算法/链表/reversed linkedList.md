# 题目

题意：反转一个单链表。

示例: 输入: 1->2->3->4->5->NULL 输出: 5->4->3->2->1->NULL

## 思路

不建议再创建一个链表浪费空间，应在原链表的基础上进行修改。
一、双指针法
二、递归法

递归法和双指针法本质上都是从前向后翻转指针指向，递归法还可以从后向前翻转指针指向

## js版本

~~~JavaScript

var reverseList = function(head){
    if(!head || !head.next) return head;
    let temp = null,pre = null,cur = head;
    while(cur){
        temp = cur.next;//缓存下一个节点
        cur.next = pre;//更改指向
        pre = cur;//向下推进
        cur = temp;//向下推进
    }
    return pre;
};

//从前向后反转指针的递归

var reverse = function(pre,head){
    if(!head) return pre;
    const temp = head.next;//缓存下一个节点
    head.next = pre;//更改指向
    pre = head;//更新
    return reverse(pre,temp);//更新下一个节点
}

var reverseList = function(head){
    return reverse(null,head);
};

//双指针法一个循环依次解决，迭代法设置一个函数，自动完成

//从后向前反转指针的递归

var reverse = function(head){
    if(!head || !head.next) return head;
    //从后向前翻
    const pre = reverse(head.next);
    head.next = pre.next;
    pre.next = head.next;
    return head;
}

var reverseList = function(head){
    let cur = head;
    while(cur && cur.next){
        cur = cur.next;
    }
    reverse(head);
    return cur;
};

////////////////////////////////////////////////////////////////这个方法不太理解

~~~