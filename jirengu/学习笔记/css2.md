# css2

## div分层

元素显示顺序：浮动元素>内联元素>块级元素>border>背景

## position

* static
* relative
  绝对不能写z-index:999
* absolute
  * 实际上参考的是第一个有定位的元素
  * 有些浏览器不写top/left会错乱
  * button、right之类的是参照物在自己的什么位置，宽高百分比也是参照物的
  * 善用left加百分比和负margin

* fixed
  移动端不要使用fixed bug比较多 无穷无尽
* sticky
  兼容性较差

## z-index

z-index是针对于兄弟节点之间的，但是不适用于父子节点之间，

每个层叠上下文就是一个作用域

### 哪些属性创建层叠上下文



**opacity设置透明度与background设置的区别**

> opacity是作用于整个元素的



重点记忆：z-index  flex opacity'  transform

负数z-index  当父元素没有层叠上下文就可以跑



- 文档根元素（`<html>`）；

- [`position`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/position) 值为 `absolute`（绝对定位）或 `relative`（相对定位）且 [`z-index`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/z-index) 值不为 `auto` 的元素；

- [`position`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/position) 值为 `fixed`（固定定位）或 `sticky`（粘滞定位）的元素（沾滞定位适配所有移动设备上的浏览器，但老的桌面浏览器不支持）；

- flex ([`flexbox` (en-US)](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox)) 容器的子元素，且 [`z-index`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/z-index) 值不为 `auto`；

- grid ([`grid`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/grid)) 容器的子元素，且 [`z-index`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/z-index) 值不为 `auto`；

- [`opacity`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/opacity) 属性值小于 `1` 的元素（参见 [the specification for opacity](https://www.w3.org/TR/css3-color/#transparency)）；

- [`mix-blend-mode`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/mix-blend-mode) 属性值不为 `normal` 的元素；

- 以下任意属性值不为

   

  ```
  none
  ```

   

  的元素：

  - [`transform`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transform)
  - [`filter`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/filter)
  - [`perspective`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/perspective)
  - [`clip-path`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/clip-path)
  - [`mask`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/mask) / [`mask-image`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/mask-image) / [`mask-border`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/mask-border)

- [`isolation`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/isolation) 属性值为 `isolate` 的元素；

- [`-webkit-overflow-scrolling`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/-webkit-overflow-scrolling) 属性值为 `touch` 的元素；

- [`will-change`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/will-change) 值设定了任一属性而该属性在 non-initial 值时会创建层叠上下文的元素（参考[这篇文章](https://dev.opera.com/articles/css-will-change-property/)）；

- [`contain`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/contain) 属性值为 `layout`、`paint` 或包含它们其中之一的合成值（比如 `contain: strict`、`contain: content`）的元素。



## grid布局

grid-template-columns: repeat(8,12.5%)

## css动画

tips：

* 设置动画结束时间时，可以定义定时器，然后再定时器内设置条件函数清除定时器

> 浏览器渲染过程：
>
> * 根据html构建HTML树DOM
> * 根据css构建css树、CSSOM
> * 将两棵树合并成一棵渲染树 render tree
> * laydout布局
> * paint绘制
> * compose合成

### 控制台使用

paint flash 展示渲染顺序

### 性能优化

#### css

left 改为transform

#### js

requestAnimationFrame 代替setTimeout或者setinterval

### transform

平移translate、缩放scale、倾斜skew、matrix、perspective视口距离 rotate旋转

~~~css
/* Keyword values */
transform: none; 默认
/* Function values */
transform: matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
transform: translate(12px, 50%);二维移动变换
transform: translateX(2em);x方向变换
transform: translateY(3in);y方向变换
transform: scale(2, 0.5);二维拉伸变换
transform: scaleX(2);x方向拉伸
transform: scaleY(0.5);y方向拉伸
transform: rotate(0.5turn);
transform: skew(30deg, 20deg);二维方向倾斜
transform: skewX(30deg);
transform: skewY(1.07rad);
transform: matrix3d(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
transform: translate3d(12px, 50%, 3em);
transform: translateZ(2px);
transform: scale3d(2.5, 1.2, 0.3);
transform: scaleZ(0.3);
transform: rotate3d(1, 2.0, 3.0, 10deg);
transform: rotateX(10deg);
transform: rotateY(10deg);
transform: rotateZ(10deg);
transform: perspective(17px);视点

/* Multiple function values */
transform: translateX(10px) rotate(10deg) translateY(5px); 简写形式

/* Global values */
transform: inherit;
transform: initial;
transform: unset;

perspective：1000px 视点在1000px处
~~~

### transition过渡

* 作用：补充中间帧
* transition：属性名、时长、过渡方式、延迟

过渡方式：

* ease:
* linear:线性
* ease-in 淡入 ease-out 淡出 ease-in-out 淡入并且淡出

> 不是所有的属性都能过渡
>
> 不要使用display：none=>block 而是使用bisibility：hidden=>visible
>
> 多次动画实现：多次调用transition或者使用animation

### animation

~~~css
#demo.start{
    animation: xx 15s （forward）;
}
//添加forward 就可以最终不返回开头

声明关键帧
@keyframe xxx{
    0%{
        transform:none;
    }
    66.6%{
        transform:translateX(200px);
    }
    100%{
        transform:translateX(200px);
        transform:translateY(100px);
    }
}
~~~

**animation **

![image-20220103133826112](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220103133826112.png)