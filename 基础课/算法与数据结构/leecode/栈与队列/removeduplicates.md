# 题目

给出由小写字母组成的字符串 S，重复项删除操作会选择两个相邻且相同的字母，并删除它们。

在 S 上反复执行重复项删除操作，直到无法继续删除。

在完成所有重复项删除操作后返回最终的字符串。答案保证唯一。

示例：

输入："abbaca"
输出："ca"
解释：例如，在 "abbaca" 中，我们可以删除 "bb" 由于两字母相邻且相同，这是此时唯一可以执行删除操作的重复项。之后我们得到字符串 "aaca"，其中又只有 "aa" 可以执行重复项删除操作，所以最后的字符串为 "ca"。
提示：

1 <= S.length <= 20000
S 仅由小写英文字母组成

## 思路

这个类似于消消乐，可以使用栈方法来解决，其次西药设置一个变量保存上一次的push元素，以进行对比。
注意删除一次之后，该变量的值也应该相应变化，以适应下一次对比并删除。

意外情况：字符串长度过短

## js版本

~~~ JavaScript

var removeDuplicates = function(s){
    const stack = [];
    let i = 0;
    //这里是题目给出字符串长度限制所以才没有进行讨论
    for(i;i < s.length; i++){
        let top = stack[s.length - 1];
        if(s[i] === top){
            stack.pop();
        }else{
            stack.push(s[i]);
        }
        return stack.join('');
    }
}

~~~
