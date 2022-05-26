# 题目

> 给定一个二叉树，找出其最小深度。

最小深度是从根节点到最近叶子节点的最短路径上的节点数量。

说明: 叶子节点是指没有子节点的节点。

## 思路

迭代和递归

## js版本

~~~JavaScript
//迭代
//前序遍历就是当检索到node=null时表示已经到达底部，后序遍历从下到上，不断迭代，计数
function mindepth = function(root){
    if(!node) return 0;
    const getdepth = function (node,count) {
        if(node == null) { 
            resMin = resMin < count ? resMin: count;
            return resMin;
        }
        let leftnode = getdepth(node.left,count+1);
        let rightnode = getdepth(node.right,count+1);
    }
}
//后序遍历
function mindepth = function(root){
    if(root == null) return 0;
    const getdepth = function(node){
        let leftnode = getdepth(node.left);
        let rightnode = getdepth(node.right);
        let depth = 1 + Math.min(leftnode,rightnode);
        return depth;
    }
    return getdepth(root);
}

function mindepth = function(root){
    if(root == null){
        return 0;
    }else if(root.left == null){
        return mindepth(root.left) + 1;
    }else if(root.right == null){
        return mindepth(root.right) + 1;
    }else {
        return Math.min(mindepth(root.left),mindepth(root.right))
    }
}
~~~
