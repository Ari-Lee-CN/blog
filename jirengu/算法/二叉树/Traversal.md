# 题目

* 这里的统一迭代法后续可以看一下

前中后序遍历 （递归、迭代、同意迭代法）

## 思路

> *递归三要素*

递归的实现就是：每一次递归调用都会把函数的局部变量、参数值和返回地址等压入调用栈中，然后递归返回的时候，从栈顶弹出上一次递归的各项参数

1. 确定递归函数的参数和返回值
    确定那些参数是递归的过程中需要处理的，那么就在递归函数里加上这个参数，并且还要明确每次递归的返回值是什么进而确定递归函数的返回类型。
2. 去顶终止条件
    写完了递归算法，运行的时候，经常会遇到栈溢出的错误，就是没写终止条件或者终止条件写的不对，操作系统也是用一个栈的结构来保存每一层递归的信息，如果递归没有种植。操作系统的内存栈必然就会溢出
3. 去顶单层递归逻辑
    确定每一层需要处理的信息。在这里也就会重复调用来实现递归的过程。

前序遍历 中左右  中序遍历 左中右  后序遍历 左右中

>*迭代*
digui

## js版本

~~~JavaScript
//前序遍历
let preorderTraversal = function(root) {
    let res = [];
    const dfs = function(root){
        if(root === null) return ;
        //先遍历父节点
        res.push(root.val);
        //再遍历左子树
        dfs(root.left);
        //再遍历右子树
        dfs(root.right);
    }
    //使用闭包进行封装
    dfs(root);
    return res;
};
//中序遍历
let inorderTraversal = function(root) {
    let res = [];
    const dfs = function(root) {
        if(root === null) return ;
        dfs(root.left);
        res.push(root.val);
        dfs(root.right);
    }
    dfs(root);
    return res;
}
//后序遍历
let postorderTraversal = function(root) {
    let res = [];
    const dfs = function(root) {
        if(root === null) return ;
        dfs(root.left);
        dfs(root.right);
        res.push(root.val);
    }
    dfs(root);
    return res;
}
/************迭代实现************/

//前序遍历
//每次出栈一个，并将其视为中，加入左右节点

let preorderTraversal = function(root){
    let res = [];
    if(!root) return res;
    const stack = [root];
    let cur = null;
    while(stack.length){
        cur = stack.pop();
        res.push(cur.val);
        cur.right && stack.push(cur.right);
        cur.left && stack.push(cur.left);
    }
    return res;
}

//中序遍历

//建立一个stack栈、用cur最初为根节点，模拟节点的运动
//如果cur存在 那么向下左下移动，将其放入栈中，如果不存在弹出，换到右边再次遍历  将系欸但向左下移动再判断是否到头

let inorderTraversal = function(root){
    let res = [];
    let stack = [];
    let cur = root;
    while(stack.length || cur){
        if(cur){
            stack.push(cur);
            cur = cur.left;
        }else{
            cur = stack.pop();
            res.push(cur.val);
            cur = cur.right;
        }
    }
    return res;
}

//后序遍历
//先是定义了一个stack栈，每次记录栈底的值，推入左右两个节点，这样出栈顺序为中、右、左

let postorderTraversal = function(root){
    let res = [];
    if(!root) return res;
    const stack = [root];
    let cur = null;
    do{
        cur = stack.pop();
        res.push(cur.val);
        cur.left && stack.push(cur.left);
        cur.right && stack.push(cur.right);
    }while(stack.length)
    return res.reverse();
}

/**********统一迭代法**************/

//定义一个栈、如果当前节点为空，记录当前的节点，按顺序推入节点
//空节点意味着需要被处理的位置
let preorderTraversal = function(root){
    let res = [];
    const stack = [];
    if(root) stack.push(root);
    while(stack.length){
        const node = stack.pop();
        if(!node){
            res.push(stack.pop().val);
            continue;
        }
        if(node.right) stack.push(node.right);
        if(node.left) stack.push(node.left);
        stack.push(node);
        stack.push(null);
    };
    return res;
};


let inorderTraversal = function(root, res=[]){
    const stack = [];
    if(root) stack.push(root);
    while(stack.length){
        const node = stack.pop();
        if(!node){
            res.push(stack.pop().val);
            continue;
        }
        if(node.right) stack.push(node.right);
        stack.push(node);
        stack.push(null);
        if(node.left) stack.push(node.left);
    }
    return res;
}
~~~
