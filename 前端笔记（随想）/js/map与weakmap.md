# Map与WeakMap

相关文章https://bbs.huaweicloud.com/blogs/297743

## Map

优势：

* 传统对象结构只能使用字符串作为键名，而map的键可以是任意数据类型
* 获取size等api上的优势
* 频繁增删键值对等情景性能较好

## weakMap

特性：

1. 只能将对象作为键名
2. 键名引用的对象是弱引用
3. 不可遍历

## 弱引用与强引用

~~~js
const myMap = new WeakMap()
let my = {
    name:'ljc',
    sex:'男'
}
myMap.set(my,'info');
console.log(myMap)
~~~

在这里如果删除了my指向的内存地址的内容，强引用会让那个内存一直空着，因为还有对那个内存空间的引用

弱引用则会释放内存