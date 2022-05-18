# target和current

MDN中对`target`的解释为，一个触发事件的对象的引用， 当事件处理程序在事件的冒泡或捕获阶段被调用时。
 	而对于currentTarget，它指的是当事件遍历DOM时，标识事件的当前目标。它总是引用事件处理程序附加到的元素，而不是`event.target`，它标识事件发生的元素。





## 理解

- `e.target` 指向触发事件监听的对象。
- `e.currentTarget` 指向添加监听事件的对象



在目标阶段，二者都是相同的。