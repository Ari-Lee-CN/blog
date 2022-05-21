# js知识

## 类

### 私有变量与公有变量

如果直接向类中写赋值语句，

let反而会报错

会变成实例的属性，公有属性会放在这里面，私有变量有放在构造器里面，后续可以不断地更改

## 杂七杂八

### 展开运算符

~~~javascript
<script type="text/javascript">
    let arri = [1,3,5,7,9]
    let arr2 = [2,4,6,10]
    console.log(...arr1);//展开一个数组
//最后所得结果为 1 3 5 7 9
    console.log(arr1)//直接输出一个数组
//最后所得结果为[1,3,5,7,9]

//链接两个数组
let arr3 = [...arr1,...arr2]
把数组1和数组2合并起来

//函数传参
funtion sum(...numbers){
    return    numbers.reduce((preValue,cuurrentValue)=>{
    renturn preValue + currentValue
    })
}

let person ={name:'Tom',age:18}
let person2 = {...person}
这样是可行的，因为被视为是以字面量的形式克隆一个对象

console.log(...person)；是报错的


let person3 = {...person,name:'jack',address:'地球'}
console.log(person3);
~~~

...运算符没有办法展开一个对象

### 对象相关知识
