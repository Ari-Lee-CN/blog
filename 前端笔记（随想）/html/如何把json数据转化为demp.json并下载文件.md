有两种思路:

* json视为字符串，可以利用DataURL进行下载
Text -> DataURL
* 还可以转化为Object URL进行下载

Text -> Blob -> Object URL

~~~js
function download(url,name){
    const a = document.createElement("a");
    a.download = name;
    a.rel = "noopener";
    a.href = url;
    //触发模拟点击
    a.dispatchEvent(new MouseEvent("click"));
    //a.click()

    const json = {
        a: 3,
        b: 4,
        c: 5,
    };
    const str = JSON.stringify(json,null,2);

    //方案一：无法保留缩进和会被删除空格
    const dataUrl = `data:,${str}`;
    download(dataURL,"demo.json");

    //方案二：
    const url = URL.createObjectURL(new Blob(str.split("")));
    download(url,"demo.json")
}
~~~