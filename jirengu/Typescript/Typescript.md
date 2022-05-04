# Typescript

## 项目

### 声明空间

typescript有类型声明空间和变量声明空间

~~~
//类型声明空间
class Foo {}
type Bas = {};
//类型声明空间只能用来当作类型注释的内容

//变量声明空间
class Foo{}
const someVar = Foo;

//var声明只能在变量声明空间使用，不饿能用作类型注释
//class声明能在两个变量声明空间中共同使用
//interface声明之恶能在类型声明空间中使用
~~~

## 模块

typescript默认开启全局模块，相同项目的不同文件共享变量空间。

由此引入文件模块（外部模块）：ts文件跟级别文职含有import或者export 会在文件中创建一个本地作用域：引入必须显示引入import {} from ‘’

## 类型系统

### 基本注释

对数组进行注解，可以防止赋值错误类型

### 接口

接口可以合并众多类型声明至一个类型声明

~~~ts
interface Name {
    first: string;
    second:string;
}

let name: Name;
name = {
    first:'John',
    second:'1337
};
~~~

可以强制对接口中地每个成员进行类型检查

### any

any提供一个类型系统的后门，ts会将类型检查关闭，能够兼容所有地类型，因此所有类型都能赋值给它，他也能被赋值给其他任何类型。

### null和undefined、void

和其他被标注了any类型地变量一样，都能被赋值给任意类型地变量

:void 用来表示一个函数没有一个返回值

~~~ts
function log(message:string):void{
    console.log(message);
}
~~~

### 泛型

~~~ts

function reverse<T>(items:T[]):T[]{
    const toreturn = [];
    for (let i = items.length-1;i>= 0;i--){
        toreturn.push(items[i]);
    }
    return toreturn; 
}
~~~

在上述例子中，reverse接受一个类型为T地数组，返回值为类型T地一个数组，函数的返回值类型与接受的参数类型一样，当你传入参数时，就能推断出reverse为u何种类型，从而确保类型安全

### 联合类型与交叉类型

~~~联合类型
function formatCommandline(command:string[] | string){
    let line = '';
    if(typeof command === 'string'){
        line = command.trim();
    }else{
        line = command.join('').trim();
    }
}
~~~

~~~交叉类型
function extend<T extends object, U extends object>(first: T, second: U): T & U {
  const result = <T & U>{};
  for (let id in first) {
    (<T>result)[id] = first[id];
  }
  for (let id in second) {
    if (!result.hasOwnProperty(id)) {
      (<U>result)[id] = second[id];
    }
  }

  return result;
}

const x = extend({ a: 'hello' }, { b: 42 });

// 现在 x 拥有了 a 属性与 b 属性
const a = x.a;
const b = x.b;
~~~

联合类型可以设置属性为多个类型之一，交叉类型可以从两个对象中创建一个新对象，新对象拥有两个对象所有地功能。联合类型使用|，交叉类型使用extend。

### 元组类型

使用以下类似地方式去实现元组

~~~ts
let nameNumber: [string, number];
nameNumber = ['Jenny', 322134];

const [name, num] = nameNumber;
~~~

### 类型别名

可以为联合类型或者交叉类型设置别名

~~~ts
type StiOrNum = string | number;

//使用
let sample: StrOrNum；
sample = 123;
sample = "123";

//类型检查
sample = true;
~~~

## 从js中迁移

## @types

## 环境声明
