# 题目

给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

为了表示给定链表中的环，使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。

## 思路

使用快慢指针法来解题，使快指针一步行进两个节点，慢指针一步行进一个节点，相当于快指针每一次比慢指针多走一个指针，如果存在环，则二者必然最终相遇。

其次画图求解，列公式不难求解，同时从相遇点和head处同时出发最终相遇的点就是环形入口

### js版本

~~~JavaScript

var detectCycle = function(head){
    let fast = head,
    let slow = head,
    while(fast.next && fast && fast !== slow){
        fast = fast.next.next,
        slow = slow.next,
    }
}

var detectCycle = function(head){
    if(head === null){
        return null;
    }
    let slow = head, fast = head;
    while(fast !== null){
        slow = slow.next;
        if(fast.next != null){
            fast = fast.next.next;
        }else{
            return null;
        }
        if(fast === slow){
            let ptr = head;
            while (ptr != slow){
                ptr = ptr.next;
                slow = slow.next;
            }
            return ptr;
        }
    }
    return null;
}
~~~