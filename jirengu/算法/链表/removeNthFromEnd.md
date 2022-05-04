# 题目

给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

进阶：你能尝试使用一趟扫描实现吗？

## 思路

常规思路是先遍历一遍链表获取到链表长度然后再删除

类似这种问题的思路可以使用双指针法，两个操作可以同时进行。

如果要删除倒数第n个节点，让fast移动n步，然后让fast和slow同时移动，直到fast指向链表末尾，删除slow所指向的节点就可以了。

同时建议使用虚拟头节点并且fast走n+1步，这样可以让slow走到被删除节点的上一个节点，方便进行删除操作

## js版本

~~~JavaScript

var removeNthFromEnd = function(head,n){
    let ret = new NodeList(0,head);
    let fast = slow = ret;
    while(n--) fast = fast.next;
    while(fast.next){
        //注意这里fast起始位置在虚拟节点，座椅判断标准应为fast.next 而不是fast
        fast = fast.next;
        slow = slow.next;
    };
    slow.next = slow.next.next;
    return ret.next;
}

~~~

