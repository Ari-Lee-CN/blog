# 题目

题意：

在链表类中实现这些功能：

get(index)：获取链表中第 index 个节点的值。如果索引无效，则返回-1。
addAtHead(val)：在链表的第一个元素之前添加一个值为 val 的节点。插入后，新节点将成为链表的第一个节点。
addAtTail(val)：将值为 val 的节点追加到链表的最后一个元素。
addAtIndex(index,val)：在链表中的第 index 个节点之前添加值为 val  的节点。如果 index 等于链表的长度，则该节点将附加到链表的末尾。如果 index 大于链表长度，则不会插入节点。如果index小于0，则在头部插入节点。
deleteAtIndex(index)：如果索引 index 有效，则删除链表中的第 index 个节点。

## 思路

~~~javascript

class LinkNode{
    constructor(val,next){
        this.val = val;
        this.next = next;
    }
}

class MyLinkedList{
    constructor(){
        this.size = 0;
        this.head = null;
        this.head = null;
    }
    //获取链表中第index个节点的值
    get(index){
        if(index < 0 || index >= this.size){
            return -1;
        }
        let curNode = this.getNode(index);
        return curNode.val;
    }
    //在链表的第一个元素之前添加一个值为val的节点。插入之后，新节点将成为链表的第一个节点。
    addAtHead(val){
        let node = new ListNode(val,this.head);
        this.head = node;
        if(!this.tail){
            this.tail = node;
        }
        //讨论了只有一个节点的情况
        this.size++;
    }
    //将值为val的节点追加到链表的最后一个元素
    addTail(val){
        let node = new ListNode(val,null);
        if(this.tail){
            this.tail.next = node;
        }else{
            this.head = node;
        }
        this.tail = node;
        this.size++;
    }
    //在链表中的第index个节点之前添加值为val的节点。
    //如果index等于链表的长度，则该节点将附加到链表的末尾，如果大于长度则不添加
    addAtIndex(index,val){
        if(index == this.size){
            this.addAttail(val);
            return;
        }
        if(index > this.size){
            return;
        }
        if(index<= 0){
            this.addAtHead(val);
            return;
        }
        let curNode = this.getNode(index-1);
        let node = new ListNode(val.curNode.next);
        curNode.next = node;
        this.size++;
    }
    //如果所引index有效，则删除链表中的第index个节点
    deleteAtIndex(index){
        if(index < 0 ||index >= this.size){
            return;
        }
        if(index === 0){
            this.head = this.head.next;
            this.size--;
            return;;
        }
        let curNode = this.getNode(index - 1);
        curNode.next = curNode.next.next;
        if(index === this.size - 1){
            this.tail = curNode;
        }
        this.size--;
    }
    //获取指定Node节点
    getNode(index){
        let curNOde = new ListNode(0,this.head);
        for(let i = 0; i <= index;i++){
            curNode = curNode.next;
        }
        return curNode;
    }
}

~~~