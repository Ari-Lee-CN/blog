# 简述DOM事件和事件委托

## 事件模型

![img](https://zhaotbj.github.io/assets/img/dom-1.f7901646.png)

- 捕获
- 冒泡
- 事件流 一个完整的事件流分为三个阶段，
  - 第一阶段是捕获
  - 第二阶段事件通过捕获到达目标元素这就是目标阶段，
  - 第三个阶段就是从目标元素上传到window对象，这就是冒泡的过程

事件捕获阶段：事件从最上一级标签开始往下查找，直到捕获到事件目标(target)。

事件冒泡阶段：事件从事件目标(target)开始，往上冒泡直到页面的最上一级标签。



