# HTML常用标签

## a

### 属性

#### href 跳转界面 

1. href取值  
2.  伪协议 tel： 等、
3. id ref=#
4. 外部界面  // 路径
   内部界面  相对路径

#### target 在哪里打开

* _blank  空白页打开
* _top 顶层页面打开
* _parent 父页面打开
* _self 当前页面打开

download 

rel=noopener 

### 作用

跳转外部界面  //路径  免得写错http https  

跳转内部锚点  可以使用相对路径

### 拓展

 href取值   伪协议 tel： 等、id ref=#

## iframe标签

### table标签

#### thead tbody tfoot

~~~html
<table>
    <thead>
       <tr>
         <th></th>
       </tr>
          <tr>
         <th></th>
       </tr>
          <tr>
         <th></th>
       </tr>
    </thead>
    <tbody>
    
    
    
    
    </tbody>
</table>
~~~

#### 样式

* table-layout  表格布局
  auto、fixed
* boder-collapse：
  collapse单元格合并

## img

永远不能让图片变形

### 属性

* src 图片源

* alt 加载失败  代替显示

* width heitght 高和宽

### 事件

onload 监听是否加载成功

onerror 监听是否加载出现错误

### 响应式

百分比设置宽度

## form

发送get、post请求刷新页面

required 必须填

### 属性

action 请求内容

target 提交的目标页面

method 请求方法 get post

autocompelete 自动补全

### 事件

onsubmit 

onchangge

onfocus

onblur

### input 

input里面要有name

type

* type=text 输入框

* type= submit 提交按钮 value=按钮名称
  与button 区别在于 button还可以包括其他内容

* type=password 不显示输入内容

* type=radio 多选  用相同name关联

* type=checkbox 多选框
* type=file 传输文件 multiple多选文件
* type=hidden 看不见的

### textarea

多段文字

### select

value 真正的值 

标签包含的是显示值



