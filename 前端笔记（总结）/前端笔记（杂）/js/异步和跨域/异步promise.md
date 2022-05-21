# promise和异步

> promise用于异步编程，抽象的表示一个异步操作

要理解同步和异步就要理解操作系统的虚拟化、线程。

## 要点

### 如何创建一个new promise

### 如何使用 Promise.prototype.then

### 如何使用 Promise.all

### 如何使用 Promise.race

## promise简介

* promise是一种引用类型，创建新期约时需要传入执行器（executor）来作为参数
* promise是一种状态机 待定、兑现、拒绝。
* 期约故意将一部行为封装起来，隔绝外部代码，不能直接检测到状态和修改状态
* 期约状态改变后及不再改变，兑现生成私有内部值，拒绝生成私有内部理由，期约的状态只能改变一次。
* 期约状态私有，内部操作通过执行器函数来执行，执行器函数负责初始化期约的异步行为和控制状态的最终转换。
* 执行器函数同步进行
* promise.reject promise.resolve 创建拒绝、兑现的期约
  兑现如果传入期约，会保留其状态，拒绝如果传入期约，会编程拒绝理由
* 非重入期约方法
  当期约进入落定状态时，与该状态相关的处理程序仅仅会被排期，而非立即执行

## promise实例方法

### promise.prototype.then()

> 添加 onResolved和onReject处理程序

* promise.prototype.then()会创建一个新的期约实例，基于resolved的返回值

### promise.prototye.catch()

上一个的语法糖，只处理reject

### promise.prototye.finally()

> 状态无关方法，最终执行，无论状态如何，最后都会原样后传

## 期约连锁与期约合成

期约连锁：连着写，串行化方式解决回调地狱

期约合成：promise.all()  promise.race()

### promise.all()

合成的期约与所有内部期约共进退，状态保持一致

### promise.race()

返回第一个落定的理由，之后的不管

## await/asyc

> 语法关键字，表示异步