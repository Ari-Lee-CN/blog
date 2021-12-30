# sass

## 功能

### 嵌套

允许将一套css样式嵌套进另一套样式之中，内部样式将外层的选择器作为父选择器

```sass
#main p {
  color: #00ff00;
  width: 97%;

  .redbox {
    background-color: #ff0000;
    color: #000000;
  }
}
```



#### 父选择器

```sass
a {
  font-weight: bold;
  text-decoration: none;
  &:hover { text-decoration: underline; }
  body.firefox & { font-weight: normal; }
}
```

需要嵌套父选择器等时，可以用&代替父选择器

多层嵌套时，最外层父选择器会一层层地向下传

### 属性嵌套

```sass
.funky {
  font: 20px/24px {
    family: fantasy;
    weight: bold;
  }
}
```

属性名：属性地具体设置{

​	命名空间

}

### 占位选择符 %foo

## 注释

/*    多行注释会在编译地时候被输出  */

// 单行注释编译时不会被输出



## SassScript

### 变量$

```