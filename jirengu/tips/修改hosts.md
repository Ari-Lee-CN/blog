# 修改hosts

1. 修改本地hosts文件，使本地对于被防护站点的请求经过高防。以Windows操作系统为例，操作步骤如下。

   1. 定位到hosts文件。一般hosts文件存储在C:\Windows\System32\drivers\etc\文件夹下。

   2. 使用文本编辑器打开hosts文件。

   3. 在最后一行添加如下内容：`高防IP地址 网站域名`。

      例如高防IP是`180.xx.xx.173`，域名是`www.aliyundemo.com`，则在hosts文件最后一行添加的内容为`180.xx.xx.173 www.aliyundemo.com`。![hosts](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/2641849951/p34923.png)

   4. 保存修改后的hosts文件。

2. 在本地计算机对被防护的域名运行Ping命令。

   预期解析到的IP地址是在hosts文件中绑定的高防IP地址。如果依然是源站地址，请尝试刷新本地的DNS缓存（在Windows的命令提示符中运行`ipconfig/flushdns`命令。）

3. 确认本地解析已经切换到高防IP以后，使用原来的域名进行测试，如果能正常访问则说明配置已经生效。