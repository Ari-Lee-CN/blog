# 题目

>给定一个二叉树，检查它是否是镜像对称的。

## 思路

其实就是对比同一节点的左右子树是否是对称的，同时还要保证第二层相等。

递归、迭代、层序遍历

可以建立一个堆栈

## js版本

~~~JavaScript
//递归法
let symmetrictree = function(root){
    const compareNode = function(left,right) {
        if(left.val !=== right.val) return false;
        let rightsides = compareNode(left.left,right.right);
        let leftsides = compareNode(left.right,right.left);
        return rightsides && leftsides ;
    }
    if(root === null)return true;
    return compareNode(root.left,root.right)
}
//迭代,由于不是对当前节点进行处理，而是对于节点的左右子书进行判断，所以不能采用传统的迭代方式进行迭代,对什么进行处理就把其推入栈

let symmetrictree = function(root) {
    if(root === null)return true;
    let stack = [];
    stack.push(root.left);
    stack.push(root.right);
    while(stack.length){
        let rightNode = stack.pop();
        let leftNode = stack.pop();
        if(rightNode.val === leftNode.val)return true;
        stack.push(leftNode.left);
        stack.push(rightNode.right);
        stack.push(leftNode.right);
        stack.push(rightNode.left);
        }
    return false;
}



~~~
