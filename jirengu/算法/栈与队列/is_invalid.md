# 题目

给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：

左括号必须用相同类型的右括号闭合。
左括号必须以正确的顺序闭合。
注意空字符串可被认为是有效字符串。

## 思路

使用栈来保证以正确顺序闭合
使用set、map等数组结构来记录是否闭合

### js版本

~~~JavaScript

var invalid = function(s){
    const stack = [], 
    map = {
        "(":")",
        "{":"}",
        "[":"]"
    };
    for(let x of s){
        if(x in map){
            stack.push(x);
            continue;
        };
        if(map[stack.pop()] !== x) return false;
    }
    return !stack.length;
};

~~~
