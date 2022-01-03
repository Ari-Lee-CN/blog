# css

检查支持特性：canisue.com 去查兼容

css spec查询最新规范

## 简介

### border调试法

加一个border看到相应对应情况和边界

### 检索方法

* 关键词 MDN
* css trick
* 张鑫旭博客

### psd使用

365psd等

guowai freepilk   搜psdweb

### 效果图

dribble.com

### 临摹

pc  手机端  UI 套件

## 基础

### 文档流

#### 流动方向

inline从左到右，到达最右边换行

block元素从上到下，每个另起一行

inline-block也是从左到右

#### 宽度

**inline宽度时内部inline元素的和，不能勇width来指定**

block自动计算宽度，可以用width指定

inline-block结合前两者的特点，可用width

#### 高度

inline高度由inline-height间接缺点，跟height无关

block 高度由内部文档流元素决定，可以设height

inline-block 跟block类似，可以设置height



inline-block不会跨行



永远不要写宽度100%

### 样例

![image-20220102104501351](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220102104501351.png)

height定义的是看得见的，字体的高度，padding是内边距

外面block形式的div按照inline-height来计算自己的高度

[方应杭讲解blog](https://zhuanlan.zhihu.com/p/25808995)



### 盒模型

#### beorder-box与content-box

![image-20220102110739225](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220102110739225.png)

#### margin合并

取消兄弟元素之间的外边距

> inline-block会取消margin合并（仅限于兄弟节点之间，父子节点之间不会合并margin
>
> 子元素和父母之间仍然会出现外边距重叠，上下重叠，左右不重叠

取消父子元素之间的外边距重叠

> * 可以附加margin-top或者padding-top来使子元素的外边距被包含在父元素内部
>   合并的前提是两个外边距之间没有乱七八糟的东西
> * overflow：hidden

~~~
<style>
    *{
        box-sizing: border-box;
        margin:0;
        padding:0;
    }
    body{
        background:white;
    }
    .rainbow {
        height:200px;
        padding:1px solid black;
        overflow:hidden;
    }
    .rainbow div{
        overflow:hidden;
    }
    .rainbow > div{
        width:400px;
        height:400px;
        background:red;
        border-radius:50%;
    }
    .rainbow>div>div{
        background:hsl(60,50%,50%);
        height:380px;
        margin:10px;
        border-radius:50%;
    }
    .rainbow>div>div>div{
        background:hsl(120,50%,50%);
        height:360px;
        margin:10px;
        border-radius:50%;
    }
    .rainbow>div>div>div>div{
        background:hsl(180,50%,50%);
        height:340px;
        margin:10px;
        border-radius:50%;
    }
    .rainbow>div>div>div>div>div{
        background:hsl(240,50%,50%);
        height:320px;
        margin:10px;
        border-radius:50%;
    }
    .rainbow>div>div>div>div>div>div{
        background:hsl(300,50%,50%);
        height:300px;
        margin:10px;
        border-radius:50%;
    }
    .rainbow>div>div>div>div>div>div>div{
        background:white;
        height:280px;
        margin:10px;border-radius:50%;
    }
    </style>
~~~



## 布局

### 浮动布局

**子组件使用浮动时，要在父组件加clearfix**

~~~
.clearfix:after{
	content:"";
	display:block;
	clear:both;
}
用选择器在浮动后面加一个空的块级元素，清除浮动，使得浮动能够被文档流包起来
~~~

>* 最后一个不写宽度，最好设置最大宽度
>* 浮动布局，不需要使用响应式
>* ie6 7 双倍margin 的bug 

### 常见布局

>* vertical-align 垂直对齐方式 
>  如果元素下有多余背景色之类的，设置top 或者middle
>* 有时候素材尺寸不好，不可以完全居中
>  设置inline-height

**写代码网站布局思路**

>**header**
>
>1. 配置环境：包括盒模型、清除默认样式、设置最大宽度、清除浮动
>2. 将配置父元素子元素的浮动，注意父子元素之间的内间距等
>3. 配置左侧元素，设置为inline-block以缩小宽度，vertical居中
>
>**header**
>
>

### css tricks

**[弹性盒子详解](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)**

![image-20220102185026830](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20220102185026830.png)

display：flex

flex 从左上角为起点，向右边和下边拓展

**当弹性盒子位于主轴上时不会换行，如果超过，原先设置的宽高就会不好使了，都会挤在一起

#### 属性

* flex-direction  弹性方向 更改主轴
  row、row-reverse、column、column-reverse
* flex-wrap 是否换行
  nowrap  wrap  wrap-reverse（从下至上包裹）

二者进行简写：

~~~css
.container{
    flex-flow:column wrap;
}
~~~

* justify-content（主轴对齐方式

  >* flex-start
  >  对着起点对齐
  >* flex-end
  >  对着终点对齐
  >* center
  >  居中
  >* space-between
  >  第一项在开始行、最后一项在结束行，中间均匀分布
  >* space-around
  >  均匀分布在一行周，中间等距，外边距不重叠
  >* space-evenly
  >  任意两个项目以及到边缘的空间相等

* align-items 次轴对齐方式

  >* stretch 拉伸以填充容器
  >  与start不同之处在于如果各个元素不一样长，会保持所有元素和最长的对齐
  >
  >* flex-start/start/self-start 位于交叉轴开始
  >* end   center
  >* baseline

* align-content多行元素次轴对齐方式

  >* normal
  >* start/end/center
  >* space-between
  >  均匀分布，注意开头和结尾
  >* space-around
  >  均匀分布，等距
  >* space-evently
  >  均匀分布
  >* strech
  >  拉伸，填满

* 其他属性

  >order 调整顺序
  >
  >flex-grow 多余空间分配比例
  >
  >flex-shrink 谁缩小的更多
  >
  >flex-basis  基准宽度
  >
  >缩写flex： grow  shrink  basis
  >
  >align-self  对某个元素的副轴对齐方式单独进行设置