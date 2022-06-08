# performance

- memory：显示此刻内存占用情况，是一个动态值

- - usedJSHeapSize：JS对象占用的内存数
  - jsHeapSizeLimit：可使用的内存
  - totalJSHeapSize：内存大小限制

正常usedJSHeapSize不大于totalJSHeapSize，如果大于，说明可能出现了内存泄漏。

- navigation：显示页面的来源信息

- - redirectCount：表示如果有重定向的话，页面通过几次重定向跳转而来，默认为0
  - type：表示页面打开的方式。0-正常进入；1-通过window.reload()刷新的页面；2-通过浏览器的前进后退按钮进入的页面；255-非以上方式进入的页面。

- onresourcetimingbufferfull：在resourcetimingbufferfull事件触发时会被调用的一个event handler。它的值是一个手动设置的回调函数，这个回调函数会在浏览器的资源时间性能缓冲区满时执行。

- timeOrigin：一系列时间点的基准点，精确到万分之一毫秒。

- timing：一系列关键时间点，包含网络、解析等一系列的时间数据。

![img](https://pic4.zhimg.com/80/v2-7e373a25f765d5ab0ee03c91370750a3_720w.jpg)

### **timing中的时间点**

下面我们来看下timing中的各个时间点：

- navigationStart：同一个浏览器上一个页面卸载(unload)结束时的时间戳。如果没有上一个页面，这个值会和fetchStart相同
- unloadEventStart: 上一个页面unload事件抛出时的时间戳。如果没有上一个页面，这个值会返回0。
- unloadEventEnd: 和 unloadEventStart 相对应，unload事件处理完成时的时间戳。如果没有上一个页面,这个值会返回0。
- redirectStart: 第一个HTTP重定向开始时的时间戳。如果没有重定向，或者重定向中的一个不同源，这个值会返回0
- redirectEnd: 最后一个HTTP重定向完成时（也就是说是HTTP响应的最后一个比特直接被收到的时间）的时间戳。如果没有重定向，或者重定向中的一个不同源，这个值会返回0
- fetchStart: 浏览器准备好使用HTTP请求来获取(fetch)文档的时间戳。这个时间点会在检查任何应用缓存之前。
- domainLookupStart: DNS 域名查询开始的UNIX时间戳。如果使用了持续连接(persistent connection)，或者这个信息存储到了缓存或者本地资源上，这个值将和fetchStart一致。
- domainLookupEnd: DNS 域名查询完成的时间。如果使用了本地缓存（即无 DNS 查询）或持久连接，则与 fetchStart 值相等
- connectStart: HTTP（TCP） 域名查询结束的时间戳。如果使用了持续连接(persistent connection)，或者这个信息存储到了缓存或者本地资源上，这个值将和 fetchStart一致。
- connectEnd: HTTP（TCP） 返回浏览器与服务器之间的连接建立时的时间戳。如果建立的是持久连接，则返回值等同于fetchStart属性的值。连接建立指的是所有握手和认证过程全部结束。
- secureConnectionStart: HTTPS 返回浏览器与服务器开始安全链接的握手时的时间戳。如果当前网页不要求安全连接，则返回0。
- requestStart: 返回浏览器向服务器发出HTTP请求时（或开始读取本地缓存时）的时间戳。
- responseStart: 返回浏览器从服务器收到（或从本地缓存读取）第一个字节时的时间戳。如果传输层在开始请求之后失败并且连接被重开，该属性将会被数制成新的请求的相对应的发起时间。
- responseEnd: 返回浏览器从服务器收到（或从本地缓存读取，或从本地资源读取）最后一个字节时。（如果在此之前HTTP连接已经关闭，则返回关闭时）的时间戳。
- domLoading: 当前网页DOM结构开始解析时（即Document.readyState属性变为“loading”、相应的 readystatechange事件触发时）的时间戳。
- domInteractive: 当前网页DOM结构结束解析、开始加载内嵌资源时（即Document.readyState属性变为“interactive”、相应的readystatechange事件触发时）的时间戳。
- domContentLoadedEventStart: 当解析器发送DOMContentLoaded 事件，即所有需要被执行的脚本已经被解析时的时间戳。
- domContentLoadedEventEnd: 当所有需要立即执行的脚本已经被执行（不论执行顺序）时的时间戳。
- domComplete: 当前文档解析完成，即Document.readyState 变为 'complete'且相对应的readystatechange 被触发时的时间戳
- loadEventStart: load事件被发送时的时间戳。如果这个事件还未被发送，它的值将会是0。
- loadEventEnd: 当load事件结束，即加载事件完成时的时间戳。如果这个事件还未被发送，或者尚未完成，它的值将会是0

通过上面这些时间点，我们看能计算到哪些时间：

- 重定向耗时：redirectEnd - redirectStart
- DNS查询耗时：domainLookupEnd - domainLookupStart
- TCP链接耗时：connectEnd - connectStart
- HTTP请求耗时：responseEnd - responseStart
- 解析dom树耗时：domComplete - domInteractive
- 白屏时间：responseStart - navigationStart
- DOM ready时间：domContentLoadedEventEnd - navigationStart
- onload时间：loadEventEnd - navigationStart
- 首屏时间: performance.getEntriesByName(“first-contentful-paint”)[0].startTime - navigationStart

