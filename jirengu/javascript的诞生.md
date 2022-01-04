# javascript的诞生

[阮一峰博客 js的历史](http://www.ruanyifeng.com/blog/2011/06/birth_of_javascript.html)

[维基百科、js历史](https://zh.wikipedia.org/wiki/JavaScript#%E5%8E%86%E5%8F%B2)

## [js十个设计缺陷](http://www.ruanyifeng.com/blog/2011/06/10_design_defects_in_javascript.html)

### 总结

* 没有命名空间 很难模块化
  类的定义，然后就可以像java一样实现私有方法和公共方法
* 非常小的标准库
  不了解
* null和undefined
  null 空对象与undefined未定义的数据类型
  null用不上
* 全局变量难以控制
  var改为了let
* 自动插入行尾分号
  如果不加分号，自动给你加分号，有时候会导致错误
* 加号运算符
  弱类型导致了运算的复杂
* NaN 比较奇怪
* 数组和对象的区分
  isArarry貌似可以判断是否是数组，可以用来判断这个对象是不是数组
* ==  自动转换类型 ===不会自动转换
* 数据类型和对象类型的差别小，容易混淆
  字符串、数字、布尔值