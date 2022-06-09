两种方法：
* .test(navigator.userAgent)
* navigator.userAgent.match()

Navigator对象包含了有关于浏览器的信息
userAgent属性是一个只读的字符串，声明了浏览器用于HTTP请求的用户代理头的值
可以通过获取Navigator userAgent属性的属性值，再和相关的移动端类型进行匹配，来判断浏览器的类型，通过调整 match 方法的参数，也可以判断不同的浏览器类型

示例：
~~~js
    <script>
        if (isMobile()) {
            console.log("mobile");
        } else {
            console.log("pc");
        }

        function isMobile() {
            let flag = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
            return flag;
        }
    </script>
~~~

~~~js
<script>
        if (isMobile()) {
            console.log("mobile");
        } else {
            console.log("pc");
        }

        function isMobile() {
            let flag = navigator.userAgent.match(
                /(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i
            );
            return flag;
        }
    </script>

~~~