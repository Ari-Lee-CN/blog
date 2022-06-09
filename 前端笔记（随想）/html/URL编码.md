## 为什么需要URL编码

通常如果一样东西需要编码，说明这样东西并不适合传输。原因多种多样，如Size过大，包含隐私数据，**对于Url来说，之所以要进行编码，是因为Url中有些字符会引起歧义**。

例如Url参数字符串中使用key=value键值对这样的形式来传参，键值对之间以&符号分隔，如/s?q=abc& ie=utf-8。如果你的value字符串中包含了=或者&，那么势必会造成接收Url的服务器解析错误，因此必须将引起歧义的&和= 符号进行转义，也就是对其进行编码。

又如，Url的编码格式采用的是ASCII码，而不是Unicode，这也就是说你不能在Url中包含任何非ASCII字符，例如中文。否则如果客户端浏览器和服务端浏览器支持的字符集不同的情况下，中文可能会造成问题。

**Url编码的原则就是使用安全的字符（没有特殊用途或者特殊意义的可打印字符）去表示那些不安全的字符。**

Url中只允许包含英文字母（a-zA-Z）、数字（0-9）、-_.~4个特殊字符以及所有保留字符。

## URL中对非法字符进行编码

Url编码通常也被称为百分号编码（Url Encoding，also known as percent-encoding），是因为它的编码方式非常简单，使用%百分号加上两位的字符——0123456789ABCDEF——代表一个字节的 十六进制形式。Url编码默认使用的字符集是US-ASCII。例如a在US-ASCII码中对应的字节是0x61，那么Url编码之后得到的就 是%61，我们在地址栏上输入[Google](https://link.zhihu.com/?target=http%3A//g.cn/search%3Fq%3D%61%62%63)，实际上就等同于在google上搜索abc了。又如@符号 在ASCII字符集中对应的字节为0x40，经过Url编码之后得到的是%40。

**对于非ASCII字符，需要使用ASCII字符集的超集进行编码得到相应的字节，然后对每个字节执行百分号编码**。 对于Unicode字符，RFC文档建议使用utf-8对其进行编码得到相应的字节，然后对每个字节执行百分号编码。如“中文”使用UTF-8字符集得到 的字节为0xE4 0xB8 0xAD 0xE6 0x96 0x87，经过Url编码之后得到“%E4%B8%AD%E6%96%87”。

**如果某个字节对应着ASCII字符集中的某个非保留字符，则此字节无需使用百分号表示**。 例如“Url编码”，使用UTF-8编码得到的字节是0x55 0x72 0x6C 0xE7 0xBC 0x96 0xE7 0xA0 0x81，由于前三个字节对应着ASCII中的非保留字符“Url”，因此这三个字节可以用非保留字符“Url”表示。最终的Url编码可以简化成 “Url%E7%BC%96%E7%A0%81” ，当然，如果你用"%55%72%6C%E7%BC%96%E7%A0%81”也是可以的。

## Javascript中的escape,encodeURI和encodeURIComponent的区别

Javascript中提供了3对函数用来对Url编码以得到合法的Url，它们分别是escape / unescape,encodeURI / decodeURI和encodeURIComponent / decodeURIComponent。由于解码和编码的过程是可逆的，因此这里只解释编码的过程。

这三个编码的函数——escape，encodeURI，encodeURIComponent——都是用于将不安全不合法的Url字符转换为合法的Url字符表示，它们有以下几个不同点。

**对Unicode字符的编码方式不同**

这三个函数对于ASCII字符的编码方式相同，均是使用百分号+两位十六进制字符来表示。但是对于Unicode字符，escape的编码方式是%u*xxxx*，其中的xxxx是用来表示unicode字符的4位十六进制字符。这种方式已经被W3C废弃了。但是在ECMA-262标准中仍然保留着escape的这种编码语法。**encodeURI和encodeURIComponent则使用UTF-8对非ASCII字符进行编码，然后再进行百分号编码**。这是RFC推荐的。因此建议尽可能的使用这两个函数替代escape进行编码。

另外，很多HTTP监视工具或者浏览器地址栏等在显示Url的时候会自动将Url进行一次解码（使用UTF-8字符集），这就是为什么当你在 Firefox中访问Google搜索中文的时候，地址栏显示的Url包含中文的缘故。但实际上发送给服务端的原始Url还是经过编码的。你可以在地址栏 上使用Javascript访问location.href就可以看出来了。在研究Url编解码的时候千万别被这些假象给迷惑了。