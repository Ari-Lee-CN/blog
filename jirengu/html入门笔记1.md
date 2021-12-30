# html入门笔记1

# 作业相关

HTML发明者 Tim Berners-Lee

起手式

全局属性 class 、contenteditable、dir、hidden、id、lang、style 

起手写什么：

~~~html
<!DOCTYPE html>
<html lang="zh-CN">
    //表示中国中文
    <head>
        <meta charset="UFF-8"/>
        //表示编码形式
        <meta name="viewport" content="width-device-width",initial-scale="1.0"/>
        //自适应布局
        <meta http-equiv="X-UA-Compatible" content="ie-edge"/>
        //浏览器兼容
    </head>
    
</html>
~~~





## URL

~~~
https://www.example.com:80/path/to/myfile.html?key1=value1&key2=value2#anchor
~~~

URL由以下几个部分组成：

协议名、主机名、端口名、路径、？查询参数、#锚点

### URL转义字符

![image-20211230105307043](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211230105307043.png)

### 绝对URL和相对URL

相对URL以/开头

《base》标签 指定了网页内部所有相对URL的计算基准值

## 网页元素

tabindex tab键的顺序  

hidden 隐藏 优先级比css低

lang表示所用的语言

dir 表示阅读方向

## 语义结构

### 常用标签

《header》

《footer》

《main》

《article》

《aside》

《section》

《nav》

《hgroup》：表示一群h之类的标签

## 文本标签

《span》 表示通用目的的行内标签

《wbr》需要就断行，不需要就不用断行

《strong》 内容的重要性 《b》不建议使用

《em》表示强调 斜体表示 《i》不建议使用



《sub》表示下标 《sup》表示上标 var表示变量或者代码



《s》 删除线



《blockqutoe》引用内容 cite属性表示引言来源地址

《cite》 表示引言出处或者作者



《code》表示代码



* 《kbd》用户输入

《samp》 表示计算机程序输出



《mark》 关键内容 亮黄色

《small》 小号字体



《time》 使机器可读，以便于搜索引擎抓取

《data》 也是这样  方便引擎抓取

《adress》 联系方式 一般放在footer里

pre  保留空格回车tab

## 列表标签

ol 有序列表

ul 无序列表

li 列表项

dl 描述性标签 dt标签    dd数据

## 补充

id的全局唯一性没有偶保障，就算有重复的id 也不会提示

tabindex若为负数表示不参与tab遍历