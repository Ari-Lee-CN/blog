# 题目

给定一个正整数 n，生成一个包含 1 到 n^2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。

示例:

输入: 3 输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]

## 思路

模拟排列过程，要记录坐标位置、每次填充的元素数还有旋转圈数。除此之外还要充分考虑奇偶数。
需要注意区间的开闭问题。

~~~JavaScript

var generateMatrix = function(n){
    let startX = startY = 0;//起始位置
    let loop = Math.floor(n/2);//
    let mid = Math.floor(n/2);
    let offset = 1; //控制每一层填充元素的个数
    let count = 1; //更新填充数字
    let res = new Array(n).fill(0).map(()=> new Array(n).fill(0));//快速创建一个零填充数组，并纵向再创建零填充数组，最终形成零填充二维数组。

    while(loop--){
        let row = startX, col = startY;
        for(;col < startY + n - offset; col++){
            res[row][col] = count++; 
        }
        //上行从左到右
        for(;row < startX + n - offset; row++){
            res[row][col] = count++; 
        }
        //右列从上到下
        for(;col > startX; col--){
            res[row][col] = count--; 
        }
        //下行从右向左
        for(;row > startY; row--){
            res[row][col] = count--;
        }
        startX++;
        startY++;

        offset += 2;

        //考虑n为奇数的情况
        if(n % 2 === 1){
            res[mid][mid] = count;
        }
    }
    return res;
}
~~~

零填充二维数组的创建方法