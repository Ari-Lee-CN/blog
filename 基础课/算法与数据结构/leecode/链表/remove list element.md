# 题目

题意：删除链表中等于给定值 val 的所有节点。

示例 1：
输入：head = [1,2,6,3,4,5,6], val = 6
输出：[1,2,3,4,5]

示例 2：
输入：head = [], val = 1
输出：[]

示例 3：
输入：head = [7,7,7,7], val = 7
输出：[]

## 思路

var node1 = new ListNode(4);
这里使用了js中的ListNode方法，创建一个链表节点

两种思路，
一是单独对第一个节点进行判断，判断其是否为被删除节点，
二是在第一个节点之前添加一个虚拟节点，进行操作之后，删除虚拟节点。

## js版本

~~~JavaScript

var removeElements = function(head,val){
    const ret = new ListNode(0,head);
    let cur = ret;
    while(cur.next){
        if(cur.next.val === val){
            cur.next = cur.next.next;
            continue;
        }
        cur = cur.next;
    }
    return ret.next;
};

~~~

### 初步想法
