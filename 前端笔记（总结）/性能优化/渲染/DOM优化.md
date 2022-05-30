# DOM优化

## DOM慢的原因

* js执行DOM操作涉及js引擎和渲染引擎之间的两个进程之间的通信
* 修改之后会导致渲染树的改变，触发回流和重绘

关于回流和重绘：
* 回流:当我们对DOM的修改引发了DOM集合尺寸的变化时，浏览器需要重新加蒜元素的集合属性，可能影响到其他元素集合属性和位置，再将计算结果绘制出来
* 重绘：不需要改变集合属性，直接绘制新样式，（跳过了回流环节）
尽量减少回流与重绘次数

## 应对方案
* 减少DOM操作
~~~js
//减少DOM操作优化示例
//1.
for(let i = 0; i <10000;i++){
    document.getElementById('container').innerHTML ='<span>123</span>';
}

//2.减少DOM通信，提取getElementById；
//减少DOM操作，提取 innerHTML
let container = document.getElementById('container');
for(let i = 0; i <10000;i++){
    count += "";
}
container.innerHTML = content.substring()

//3.应用DOM Fragement
let container = document.getElementById('container')
// 创建一个DOM Fragment对象作为容器
let content = document.createDocumentFragment()
for(let count=0;count<10000;count++){
  // span此时可以通过DOM API去创建
  let oSpan = document.createElement("span")
  oSpan.innerHTML = '我是一个小测试'
  // 像操作真实DOM一样操作DOM Fragment对象
  content.appendChild(oSpan)
}
// 内容处理好了,最后再触发真实DOM的更改
container.appendChild(content)
~~~