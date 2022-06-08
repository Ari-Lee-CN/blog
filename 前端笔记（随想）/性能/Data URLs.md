# data URL
> 一种将图片嵌入到HTML中的方法，图片被转换为base64编码的字符串形式，并存储在URL中，加上mime-type
> 使用Data URL可以优化网站加载速度和执行效率

img图片与data URLs
~~~js
//img
<img src="images/myimage.gif ">

//Data URL
<img src="data:image/gif;base64,R0lGODlhMwAxAIAAAAAAAP///
yH5BAAAAAAALAAAAAAzADEAAAK8jI+pBr0PowytzotTtbm/DTqQ6C3hGX
ElcraA9jIr66ozVpM3nseUvYP1UEHF0FUUHkNJxhLZfEJNvol06tzwrgd
LbXsFZYmSMPnHLB+zNJFbq15+SOf50+6rG7lKOjwV1ibGdhHYRVYVJ9Wn
k2HWtLdIWMSH9lfyODZoZTb4xdnpxQSEF9oyOWIqp6gaI9pI1Qo7BijbF
ZkoaAtEeiiLeKn72xM7vMZofJy8zJys2UxsCT3kO229LH1tXAAAOw==">
~~~

一个引用了外部资源，一个使用了Data URL

## 语法
~~~
data:[mediatype][;base64], data
~~~
## 相较于传统优缺点

应用场景：
* 当访问外部资源很麻烦或受限时
* 当图片是在服务器端用程序动态生成，每个访问用户显示的都不同时
* 当图片的体积太小，占用一个HTTP会话不是很值得时

缺陷：
* Base64编码的数据体积通常是原数据的体积的4/3
* 不会被浏览器缓存，但是可以放在css中规避