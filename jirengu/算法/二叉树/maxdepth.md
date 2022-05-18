# 题目

给定一个二叉树，找出其最大深度。

二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

说明: 叶子节点是指没有子节点的节点。

示例： 给定二叉树 [3,9,20,null,null,15,7]，

返回它的最大深度 3 。

## 思路

使用递归法，记录递归次数

## js版本

~~~JavaScript
//递归遍历 后序遍历
let maxdepth = function(root){
    let depth = 0 ;
    if(node == null)return depth;
    const dep = function(node){
        let leftnode = dep(node.left);
        let rightnode = dep(node.right);
        let depth = 1 + Math.max(leftnode, rightnode)
        return depth;
    }
    return getdepth(root);
}

//前序遍历
function maxDepth(root){
    funtion getdepth(node,count){
        if(node === null){
            resMax = resMax>count ? resMax : count;
            return
        }
        getdepth(node.left,count + 1);
        getdepth(node.right,count + 1);
        getdepth(root,count);
        return resMax;
    }
}

//层序遍历

function maxDepth(root){
    let queue = [];
    let depth = 0;
    if(root == null)return depth;
    queue.push(root);
    while(queue.length){
        let size = queue.length
        count++; //
        while(size--){
            let node = queue.pop();
            node.left&&queue.push(node.left);
            node.right&&queue.push(node.right);   
        }
    }
    return count;
}

//对于n叉树

for(let item of node.children){
    item && queue.push(item);
}

~~~
