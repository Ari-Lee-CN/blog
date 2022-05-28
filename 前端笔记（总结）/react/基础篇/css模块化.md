# css模块化
react中没有Vue中的 style scoped写法
因此会导致很多问题：样式类名全局污染、命名污染、样式覆盖。

css模块化的好处：
* 防止全局污染、样式覆盖
* 明明混乱
* 代码冗余大，体积大
## css module

css-loader


### css in js


以Styled-components为例，通过style-components可以使用ES6的标签模板字符串语法定义css属性，当该组件的js代码被解析执行时，styled-components会动态生成一个css选择器，并把对应的css样式通过style标签的形式插入到head标签中。动态产生的css选择器会有哈希值来保证全局唯一性避免样式冲突

本质上是一种动态生成style标签

使用useLayoutEffect问题：

执行时DOM已经更新，再次动态生成style标签，会导致浏览器回流和重排，所以需要使用useInsertionEffect