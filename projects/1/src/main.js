let html =document.querySelector('#demo');
let style = document.querySelector("#style");
//qs 快速编辑querySelector 这个api表示相对应的css元素
let string = `
/*你好，我是一名前端新人
接下来我要加样式了
我要加的样式是*/
body{
    color:red;
}
#div1{
    border:1px solid red;
    width:200px;
    height:200px;
}
/*接下来我把div变成一个八卦图
首先把div变成一个圆*/
#div1{
    border-radius:50%;
    box-shadow:0 0 3px rgba(0,0,0,0.5);
    border:none;
}
/* 做一个八卦*/
#div1{
background: rgb(255,255,255);
background: linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 50%, rgba(0,0,0,1) 50%, rgba(0,0,0,1) 100%);
}

/*加两个神秘的小球*/
#div1::before{
    width:100px;
    height:100px;
    top:0;
    left:50%;
    transform:translateX(-50%);
    background: rgb(255,255,255);
background: radial-gradient(circle, rgba(255,255,255,1) 0%, rgba(255,255,255,1) 25%, rgba(255,255,255,1) 25%, rgba(0,0,0,1) 25%, rgba(0,0,0,1) 100%);
    border-radius:50%;
}
#div1::after{
    width:100px;
    height:100px;
    bottom:0;
    left:50%;
    transform:translateX(-50%);
    background: rgb(0,0,0);
    background: radial-gradient(circle, rgba(0,0,0,1) 25%, rgba(255,255,255,1) 25%, rgba(255,255,255,1) 25%, rgba(255,255,255,1) 100%, rgba(0,0,0,1) 100%);
    border-radius:50%;
}
`;
let string2 = "";
//查询字符串某个位置是什么，
//按照[]查询，然后使用charCodeAt()获得asci编码
//正则表达式全局替换
//为什么会出现尖括号，因为使用innerhtml，将\n看作两个字符
let n = 0;
let step = () => {
    setTimeout(() => {
        if (string[n] === '\n'){
            string2 +="<br>";
        }else if(string[n]===" "){
            string2 +="&nbsp;";
        }else{
            string2 +=string[n];
        }
        html.innerHTML = string2;
        style.innerHTML = string.substring(0,n);
        n+=1;
        window.scrollTo(0,999999999);
        demo.scrollTo(0,999999999);     
        if(n>=string.length){
            return;
        };
        step();
    },0);
}
step();
//更新内容


