# js高程 BOM DOM

## window对象

### global作用域

### 窗口关系

top对象指向最外层窗口

parent对象指向当前窗口的父窗口

self对象始终指向window

### 窗口位置与像素比

确定位置
screenLeft与screenTop用来表示窗口相对于屏幕左侧和顶部的位置

移动窗口
moveT接受要移动到的新位置的绝对坐标
moveBy接收相对当前位置在两个方向上移动的像素数

像素比
window.devicePixelRatio表示物理像素与逻辑像素之间的缩放系数

窗口大小
浏览器支持四个属性：innerWidth、innerHeight、outerWidth、outerHeight
document.documentElement.clientWidth和document.documentEkement.clientHeight返回页面视口的宽度和高度

视口位置
使用scroll（）、scrollTo（）、scrollBy（）方法滚动页面
![image-20211109084415662](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211109084415662.png)

### 导航与打开新窗口window.open（）

window.open()方法可用于导航到指定URL，也可以用于打开新浏览器窗口，接受四个参数：要加载的URK、目标窗口、特性字符串和表示新窗口在浏览器历史记录中是否替代当前加载页面的布尔值。

第二个参数如果不是已有窗口，则回打开一个新窗口或标签页
第三个参数，用于指定新窗口配置
![image-20211109090326361](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211109090326361.png)
![image-20211109090343792](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211109090343792.png)

#### 弹出窗口的处理

.close（）方法关闭新打开的窗口，但是只能用于window.open（）创建的弹出窗口。

新创建窗口的windo对象有一个属性opener，指向打开它的窗口
将opener属性设置为null，可以使得标签页运行在独立的进程中，但是也不再和打开它的标签页通信

如果浏览器内置的弹幕屏蔽程序阻止了弹窗，那么window.open()很可能回返回null，通过检查该方法的返回值即可得知弹窗是否被屏蔽。
![image-20211109092434037](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211109092434037.png)

#### 定时器

setTimeout（）用于指定在一定时间后执行某些代码
        setInterval（）用于指定每隔一段时间执行某些代码

setTimeout()方法通常接受两个参数：要执行的代码和在执行回调函数前等待的时间（毫秒），执行时回返回一个表示该超时排期的数值ID。要取消等待中的排期任务，可以通过调用clearTimeout（）方法并传入超时ID

setInterval（）接受两个参数：要执行的代码（字符串或函数），以及把下一次执行定时代码的任务添加到队列等待的时间（毫秒）取消等待中的任务方法同上，该种方法用的较少，因为相邻两个任务开始的时间间隔是无法保证的。

#### 系统对话框

alert（）显示在一个系统对话框中，接受一个要显示给用户的字符串。通常用于向用户显示一些他们无法控制的消息，如警告框

confirm（）确认框

prompt（）提示框

还有两种对话框：find（）和print（）

### location对象

location对象既是window的属性，也是document的属性。

![image-20211109095805933](C:\Users\A\AppData\Roaming\Typora\typora-user-images\image-20211109095805933.png)