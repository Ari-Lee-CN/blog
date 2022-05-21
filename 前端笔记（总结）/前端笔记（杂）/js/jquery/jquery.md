# jquery九大功能

## [原文地址](http://www.ruanyifeng.com/blog/2011/07/jquery_fundamentals.html) 

## 选择网页元素

jQuery的基本设计思想和主要用法，就是**"选择某个网页元素，然后对其进行某种操作"**

使用jQuery的第一步，往往就是将一个选择表达式，放进构造函数jQuery()（简写为$），然后得到被选中的元素。

## 改变结果集

jQuery设计思想之二，就是提供各种强大的[过滤器](https://api.jquery.com/category/traversing/filtering/)，对结果集进行筛选，缩小选择结果。

我们需要从结果集出发，移动到附近的相关元素，jQuery也提供了在DOM树上的[移动方法](https://api.jquery.com/category/traversing/tree-traversal/)：

### 链式操作

jQuery设计思想之三，就是最终选中网页元素以后，可以对它进行一系列操作，并且所有操作可以连接在一起，以链条的形式写出来，

> $('div').find('h3').eq(2).html('Hello');

分解开来，就是下面这样：

> 　　$('div') //找到div元素
>
> 　　　.find('h3') //选择其中的h3元素
>
> 　　　.eq(2) //选择第3个h3元素
>
> 　　　.html('Hello'); //将它的内容改为Hello

jQuery还提供了[.end()](https://api.jquery.com/end/)方法，使得结果集可以后退一步：

## 元素的操作：取值和赋值

jQuery设计思想之四，就是使用同一个函数，来完成取值（getter）和赋值（setter），即"取值器"与"赋值器"合一。到底是取值还是赋值，由函数的参数决定。

。

> 　　$('h1').html(); //html()没有参数，表示取出h1的值
>
> 　　$('h1').html('Hello'); //html()有参数Hello，表示对h1进行赋值

常见的取值和赋值函数如下：

> 　　[.html()](https://api.jquery.com/html/) 取出或设置html内容
>
> 　　[.text()](https://api.jquery.com/text/) 取出或设置text内容
>
> 　　[.attr()](https://api.jquery.com/attr/) 取出或设置某个属性的值
>
> 　　[.width()](https://api.jquery.com/width/) 取出或设置某个元素的宽度
>
> 　　[.height()](https://api.jquery.com/height/) 取出或设置某个元素的高度
>
> 　　[.val()](https://api.jquery.com/val/) 取出某个表单元素的值

## 元素的操作

jQuery设计思想之五，就是提供两组方法，来操作元素在网页中的位置移动。一组方法是直接移动该元素，另一组方法是移动其他元素，使得目标元素达到我们想要的位置。

假定我们选中了一个div元素，需要把它移动到p元素后面。

第一种方法是使用[.insertAfter()](https://api.jquery.com/insertAfter/)，把div元素移动p元素后面：

> 　　$('div').insertAfter($('p'));

第二种方法是使用[.after()](https://api.jquery.com/after/)，把p元素加到div元素前面：

> 　　$('p').after($('div'));

表面上看，这两种方法的效果是一样的，唯一的不同似乎只是操作视角的不同。但是实际上，它们有一个重大差别，那就是返回的元素不一样。第一种方法返回div元素，第二种方法返回p元素。你可以根据需要，选择到底使用哪一种方法。

## 元素的操作：赋值、删除和创建

除了元素的位置移动之外，jQuery还提供其他几种操作元素的重要方法。

复制元素使用[.clone()](https://api.jquery.com/clone/)。

删除元素使用[.remove()](https://api.jquery.com/remove/)和[.detach()](https://api.jquery.com/detach/)。两者的区别在于，前者不保留被删除元素的事件，后者保留，有利于重新插入文档时使用。

清空元素内容（但是不删除该元素）使用[.empty()](https://api.jquery.com/empty/)。

创建新元素的方法非常简单，只要把新元素直接传入jQuery的构造函数就行了：

> 　　$('<p>Hello</p>');
>
> 　　$('<li class="new">new list item</li>');
>
> 　　$('ul').append('<li>list item</li>');

## 工具方法

jQuery设计思想之六：除了对选中的元素进行操作以外，还提供一些与元素无关的[工具方法](https://api.jquery.com/category/utilities/)（utility）。不必选中元素，就可以直接使用这些方法。

工具方法的实质。它是定义在jQuery构造函数上的方法，即jQuery.method()，所以可以直接使用。而那些操作元素的方法，是定义在构造函数的prototype对象上的方法，即jQuery.prototype.method()，

## 事件操作

Query设计思想之七，就是把[事件](https://api.jquery.com/category/events/)直接绑定在网页元素之上。

> 　　$('p').click(function(){
>
> 　　　　alert('Hello');
>
> 　　});

## 特殊效果

**九、特殊效果**

最后，jQuery允许对象呈现某些[特殊效果](https://api.jquery.com/category/effects/)。

> 　　$('h1').show(); //展现一个h1标题

常用的特殊效果如下：

> 　　[.fadeIn()](https://api.jquery.com/fadeIn/) 淡入
>
> 　　[.fadeOut()](https://api.jquery.com/fadeOut/) 淡出
>
> 　　[.fadeTo()](https://api.jquery.com/fadeTo/) 调整透明度
>
> 　　[.hide()](https://api.jquery.com/hide/) 隐藏元素
>
> 　　[.show()](https://api.jquery.com/show/) 显示元素
>
> 　　[.slideDown()](https://api.jquery.com/slideDown/) 向下展开
>
> 　　[.slideUp()](https://api.jquery.com/slideUp/) 向上卷起
>
> 　　[.slideToggle()](https://api.jquery.com/slideToggle/) 依次展开或卷起某个元素
>
> 　　[.toggle()](https://api.jquery.com/toggle/) 依次展示或隐藏某个元素

