# 题目

给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null。

## 思路

求两个链表交点节点地指针，交点是指针相等而不是数值相等。

这里不方便使用双指针法，只需要找到两条链表之间长度地差值，然后求出差值，然后保证二者逐个对比同时到达尾部即可。其中由于未知哪条链表比较长，所以可能涉及绝对值等操作。

## js版本

~~~javascript
var getListLen = function(head){
    let len = 0, cur = head;
    while(cur){
        len++;
        cur = cur.next;
    }
    return len;
}

var getIntersectionNode = function(headA,headB){
    let curA = headA,curB = headB,
        lenA = getListLen(headA),
        lenB = getListLen(headB);
    if(lenA < lenB){
        [curA, curB] = [curB, curA];
        [lenA, lenB] = [lenB, lenA];
    }
    let i = lenA - lenB;
    while(i-- > 0){
        curA = curA.next;
    }
    while(curA && curA !== curB){
        curA = curA.next;
        curB = curB.next;
    }
    return curA;
};

~~~
