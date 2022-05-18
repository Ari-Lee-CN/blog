# 四种数据结构

[https://bbs.huaweicloud.com/blogs/297743]("博客")

## Map与Object

### 差异

* objcet只能使用数值、字符串或者符号作为键，map任何都可以
* map内部使用相当于严格对象相等的标准来检查键的匹配性
* map记录插入顺序，并且按照插入顺序进行迭代 
  entries() 插入顺序 for each回调也可以打印

### 性能

* map占用内存更小
* 插入性能稍快
* 大量查找操作的话 object好
* 删除 map更好

## WeakMap和Map

weakMap只要键存在就会认为是值的引用，key的引用断了，就会被垃圾回收

### 差异

* 弱映射中的键只能是object或者继承自object的类型
* weakmap不可迭代

## Set和Map

set  集合数据结构