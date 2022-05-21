# MySQL2

## 数据表的关联关系

### 关联关系

> 不仅可以存储数据，还可以维护数据与数据之间的关系。通过在数据表中建立外键约束

数据关联关系

* 一对一关联
* 一对多关联
* 多对一关联
* 多对多关联

### 一对一关联

* 主键关联
  两张数据表中主键相同的数据为互为对应的数据。
* 外键约束
  在用户表中添加did字段，与详情表的主键进行关联，要求didi字段中添加的值必须在其关联的主键中存在，并且是唯一的。

### 一对多关联、多对一关联

外键约束不再要求唯一性

### 多对多关联

额外创建一张关系表来维护多对多关联

关系表的列是各个表的主键，每一个记录是一条对应关系。

### 外键约束

> 外键约束：将一个列添加外键约束与另一张表的主键进行关联之后，这个外键约束的列添加的数据，必须要在关联的字段中。

~~~sql
//先创建一张班级表
create table classes(
	class_id int primary key auto_increment,
	class_name varchar(40) not null unique,
    class_remark varchar(200)
);
    
    //创建学生表，添加外键与班级表的主键进行关联
create table students(
	stu_num char(8) primary key,
    stu_name varchar(20) not null,
    stu_gender char(2) not null,
    stu_age int not null,
	cid,
    constraint FK_STUDENTS_CLASSESforeign key(cid) references classes(class_id)
);
    //cid列要与classes表的class、id进行关联，因此类型、长度要保持一致
    
    //向班级表添加班级信息
 insert into classes(class_name,class_remark) values('','');
 ...
 select * from classes;
 
 //向学生表中添加学生信息
 
 insert into students(stu_num, stu_name, stu_gender, stu_age, cid) values('','','','')
 
 //添加学生时，设置给cid外键列的值必须在其关联的主表classes的clasess_id列存在
    
 
~~~

>  当学生表中存在学生信息关联班级表中的某条记录时，我们就不能对班级表的这条记录修改id、删除操作，因为这条数据被引用了。
>
> 如果要进行相关操作，首先要对于学生表中的数据清除引用，将cid更改为null，随后进行修改操作。
>
> 如果一定要修改班级id，如何实现？
>
> * 修改引用该班级id的学生记录的cid为null
> * 修改班级信息表中的class_id
> * 将学生表中cid设置为null的记录的cid重修修改为这个班级中的新id

#### 外键约束 级联操作

我们可以使用级联操作实现上述操作

* 在添加外键时，设置级联修改和级联删除

  ~~~sql
  //删除原有的外键约束
  alter table students drop foreign key FK_STUDENTS-CLASSES；
  
  //重新添加外键约束，并且设置外键约束
  alter table students add constraint FK-STUDENTS_CLASSES foreign key(cid) references classes(class_id)  ON UPDATE CASCADE ON DELETE CASCADE
  ~~~

* 测试级联修改

~~~sql
//直接修改2104的class_id ,关联2104这个班级的学生记录的cid也会同步修改

update classes set class_id=1 where class_name = '2104';
~~~

* 测试级联删除

~~~sql
//删除2104的班级信息，学生表引用该班级的记录也会被同步删除
delete from classes where class_id = ‘2104’
~~~

## 连接查询

> 在企业的应用开发中，我们经常需要从多张表中查询数据，可以通过链接查询从多张数据表中提取数据
>
> mysql可以使用join实现多表的联合查询--连接查询，按照功能不同join分为三个操作
>
> * inner join 内连接
> * left join 左连接
> * right join 右链接

### 数据准备

1. 创建班级信息表和学生信息表

~~~sql
mysql> create table classes(
    -> class_id int primary key auto_increment,
    -> class_name varchar(40) not null unique,
    -> class_remark varchar(200)
    -> );
    
    
 mysql> create table students(
    -> stu_num char(8) primary key,
    -> stu_name varchar(20) not null,
    -> stu_gender char(2) not null,
    -> stu_age int not null,
    -> cid int,
    -> constraint FK_STUDENTS_CLASSES foreign key(cid) references classes(class_id) ON UPDATE CASCADE ON DELETE CASCADE); 
~~~

2. 添加信息

~~~sql
mysql> insert into classes(class_name,class_remark) values('java2104','...');
Query OK, 1 row affected (0.03 sec)

mysql> insert into classes(class_name,class_remark) values('java2105','...');
Query OK, 1 row affected (0.01 sec)

mysql> insert into classes(class_name,class_remark) values('java2106','...');
Query OK, 1 row affected (0.01 sec)

mysql> insert into classes(class_name,class_remark) values('java2107','...');
Query OK, 1 row affected (0.01 sec)



mysql> insert into students(stu_num,stu_name,stu_gender,stu_age,cid) value('20210101','张三','男',20,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age,cid) value('20210102','李四','男',20,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age,cid) value('20210103','王五','男',20,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age,cid) value('20210104','赵柳','女',20,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age,cid) value('20210105','孙七','男',20,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age)values('20210106','小红','女',20);
Query OK, 1 row affected (0.01 sec)

mysql> insert into students(stu_num,stu_name,stu_gender,stu_age)values('20210107','小明','男',20);
Query OK, 1 row affected (0.01 sec)
~~~

### 内连接 inner join

产生两张数表的笛卡尔积

~~~sql
mysql> select * from students INNER JOIN classes;
//获取两张数表中的数据集合的笛卡尔积
~~~

* 内连接条件

  > 两张表用内连接产生的数据中很多都是无意义的数据，如何消除？————添加两张表进行连接查询的条件

* 解决方案：

  * 使用where 连接过滤条件，先生成笛卡尔积然后从笛卡尔积中过滤，效率较低
  * 使用 on 链接  先判断连接条件是否成立如果成立再进行组合，生成一条结果数据。

### 左连接 left join

~~~sql
mysql> select * from students LEFT JOIN classes ON students.cid = classes.class_id；
~~~

左连接显示左表中的所有数据，如果在右表中存在与左表记录满足匹配条件的数据，则进行匹配，如果右表中不存在匹配数据，则显示为null。

### 右链接

和左连接相似，是显示右表中的数据的

如果再链接查询的多张表中存在相同名字的字段，可以使用



## 子查询/嵌套查询

> 先进行一次查询，第一次查询的结果作为第二次查询的源。

~~~sql
//查询Java2104班级中的学生信息（只知道班级名称，不知道班级id
1.
//查询2104班级的班级编号

//查询学生信息

2.嵌套查询/子查询

select * from students where cid = (select class_id from classes where class_name = 'java2104');
~~~

~~~sql
//返回多行单列
//返回所有java班级中的学生信息
select * from students where cid IN (select class_id from classes where class_name LIKE 'java%')

//注意使用关键字IN  NOT IN也是可以使用的
不使用子查询也可以用UNION链接多个查询语句
~~~

~~~sql
//返回多行多列
//查询cid = 1的班级中性别为男的学生信息

//多条件查询
select * from students where cid = 1 and stu_gender = '男'）；

//子查询：先查询cid=1班级内所有的学生信息，再将这些信息作为一个整体的虚拟表，在基于这个虚拟表查询性别为男的学生信息。（虚拟表是需要别名的）例如这里的t

select * from（select * from students where cid = 1） t where t.stu_gender = '男'；

~~~

### 存储过程

> * 概念
>
> 将能够完成特定功能的sql指令进行封装，编译之后存储在数据库中，并且为之取一个名字。
>
> 当客户端需要执行这个功能时，不需要编写sql指令，只需要通过封装的sql指令的名字完成调用。
>
> * 优点
>
> 1. 无需客户端编写，通过网络传递，可以节省网络开销，避免sql指令再传输过程中被恶意篡改，提高安全性
> 2. 存储过程经过编译创建并保存在数据库中，执行过程无需重复的进行编译操作，对sql1指令的执行过程进行了性能提升
> 3. 存储过程中多个sql指令之间存在逻辑关系，可以实现更加复杂的业务
>
> * 缺点
>
> 1. 存储过程时根据不同的数据库进行编译，创建并存储在数据库中，当切换数据库时。需要重新编写存储过程，针对于新数据库的存储过程。
> 2. 存储过程受限于数据库产品，性能优化会因此受到影响
> 3. 在互联网项目中如果需要数据库的高并发访问，会增加数据库的链接执行时间

### 创建存储过程语法

~~~sql
//创建一个存储过程实现加法运算

create procedure proc_test1( IN a int, IN b int, OUT c int)
begin
	SET c = a + b；
end;


~~~

### 调用存储过程

~~~sql
call proc_test1(3,2,@m)

select @m from dual 
//从系统表中查看
~~~

### 存储过程中变量的使用

> 变量分为两种：局部变量、用户变量
>
> 局部变量只能在存储过程内部使用

~~~sql
局部变量
create procedure proc_test2(IN a int, OUT r int)
begin
declare x int default 0;//定义x默认值为0，类型为int
declare y int default 1；
set x = a*a;
set y = a/2;
set r = x+y;
end;

select x from dual; //无法找到  因为x为局部变量
局部变量定义
declare <attr_name> <type> {default value}


用户变量/全局变量

用户变量会存储在数据字典中，可以使用select @attrName from dual查询

用户变量定义
set @n = 1；

~~~

* 在存储过程中使用select...into...将查询结果赋值

~~~sql
//查询学生数量
create procedure proc_test3( OUT c int)
begin
	select count(stu_num) INTO c from students;
end;

call proc_test3(@n);
select @n from dual;
~~~

### 存储过程参数

> 参数有三种 ＩＮ　ＯＵＴ　ＩＮＯＵＴ

＊　ＩＮ输入参数



### 语句

* 分支语句

  1. if-then-else

  ~~~sql
  create procedure proc_test7(IN a int)
  begin
  	if a = 1 then
  		insert into classes(class_name,remark)values('java2109','test');
  else
  	insert into students(stu_num,stu_name,stu_gender,stu_age,cid,remark)values('20210110','小花','女',19,1,'...');
  	end if;
  end;
  
  call proc_test7(2);
  ~~~

  2. case

  ~~~sql
  create procedure proc_test8(IN a int)
  begin 
  	case a
  	when 1 then
  	SQL1
  	when 2 then
  	SQL2
  	else
  	SQL3
  	end case;
  end;
  ~~~

* 循环语句

  1. while

     ~~~sql
     create procedure proc_test9(IN num int)
     begin 
     	declare i int;
     	set i = 0;
     	while i < num do
     		SQL1
     	end while
     end;
     ~~~

  2. repeat

     ~~~sql
     create procedure proc_test10(IN num int)
     begin 
     	declare i int;
     	set i = 0;
     	repeat
     		SQL
     	until 条件
     	end repeat;
     end;
     ~~~

  3. loop

     ~~~sql
     create procedure proc_test10(IN num int)
     begin 
     	declare i int;
     	set i = 0;
     	myloop:loop
     		SQL
     		if 条件 then
     			SQL
     		end if;
     	end loop;
     end;
     ~~~

     

### 存储过程管理

* 查询存储过程

  ~~~sql
  //根据数据库名字，查询当前数据库中的存储过程
  show procedure status where db="db_test2"
  
  //查询存储过程创建的细节
  show create procedure db_test2.proce_test2
  ~~~

* 修改

  ~~~sql
  alter procedure <proc_test> 特征 特征 特征
  
  ~~~

  特征参数

  * CONTAIN SQL 程序包含SQL 不包含读写数据的语句
  * NO SQL 不包含SQL语句
  * READS SQL DATA 表示子程序中包含读数据的语句
  * MODIFIES SQL DATA 表示子程序中包含写数据的语句
  * SQL SECURITY{DEFINER| INVOKER} 知名谁有权限来执行
  * DEFINER 表示只有定义这自己能够执行
  * INVOKER 表示调用者才能够执行
  * COMMENT ’string‘  表示注释信息

* 删除

  ~~~sql
  drop procedure 
  ~~~

  

### 游标

> 如果我们需要创建一个存储过程，需要返回查询语句查询到的多条语句，该如何实现？
>
> 游标可以遍历查询的结果集

游标的使用

* 声明游标

  ~~~sql
  declare cursor_name CURSOR FOR select_statement;
  ~~~

* 打开游标

  ~~~sql
  open cursor_name;
  ~~~

* 使用游标

  //使用游标要结合循环语句

  ~~~sql
  set i = 0;
  while i < num do
  	FETCH mycursor INTO bname,bauthor,bprice；
  	set i = i+1;
  	set str = concat_ws('~',bname,bauthor,bprice);
  	//另一种写法 
  	//select concat_ws('~',bname,bauthor,bprice) INTO str;
  	set result = concat_ws(',',result, str);
  end while;
  ~~~

  

* 关闭游标

  ~~~sql
  close cursor；
  ~~~



### 触发器

> 一种特殊的存储过程，是一段能够完成特定功能，并且存储在数据库服务器上的SQL片段，但是触发器无需调用，当对数据表中的数据执行DML，会自动触发这个SQL片段的执行。

~~~sql
//日志信息表，记录对学生信息的操作

create table stulogs(
	id intmysql> create table stulogs(
    -> id int primary key auto_increment,
    -> time TIMESTAMP,
    -> log_text varchar(200)
    -> );

 //当向students表中添加学生信息时，同时要在stulogs表中添加一条操作日志。
    mysql> insert into students(stu_num,stu_name,stu_gender,stu_age) values('1004','夏利','女',20);
    
	mysql> insert into stulogs(time,log_text) values(now(),'添加1004学生信息'); 
~~~

#### 使用方法

~~~sql
//当向学生信息表添加、删除、修改时，自动使用触发器进行日志记录

//创建触发器

create trigger tri_name
before/after 		---定义触发时机
insert/delete/update  ---定义DML类型
ON <table_name>


//查看触发器

show triggers;
~~~

* 创建的触发器是在students表发生insert操作时触发，我们只需要执行学生信息的添加操作

~~~sql
//测试1，添加一个学生信息
insert into students(stu_num,stu_name,stu_gender,stu_age) values ('1005')
//测试2，添加两个学生信息 触发器执行两次
insert into students(stu_num,stu_name,stu_gender,stu_age) values ('1005')(...)


//删除触发器 
drop trigger tri_test1；


~~~

#### NEW与OLD

> 触发器相当于监听器，用于监听DML操作，在触发器中通常处理一些DML关联操作。new和old可以获取触发触发器操作的记录
>
> new：获取insert操作添加的数据、update修改后的数据
>
> old：获取delete删除前的数据或者update修改前的数据

~~~sql
create trigger tri_test1
after insert on students
for each row
insert into stulogs(time,log_text) values('添加',NEW.stu_num,‘学生信息');
~~~

### 使用总结

> * 优点
>   * 触发器是自动执行的，执行相应DML操作时立即执行
>   * 实现表中数据的级联操作，有利于保证数据的完整性
>   * 可以对DML操作进行更为复杂的合法性检验
> * 缺点（并不提倡使用了）
>   * 使用触发器实现的业务逻辑如果出现问题，将难于定位后期维护困难
>   * 大量使用容易导致代码结构杂乱
>   * 会降低执行效率
> * 使用建议
>   * 并发量不大的项目可以使用存储过程，但是互联网引用中不提倡使用存储过程

## 视图

> 数据表中一张表或者多张表根据特定条件查询出数据构造成的虚拟表
>
> * 提高安全性，授权用户访问视图
> * 便捷，使用视图多表查询

### 创建视图

~~~sql
//语法
create view name
AS
select * from 
//样例
mysql> create view view_test1
    -> AS
    -> select * from students where stu_gender = '男';
    

~~~

### 视图数据特性

> 对视图的增删减改会引起原数据表的变化

### 查看、修改、删除视图

~~~sql
// 查询视图
desc view_test1
// 查看视图结构



删除、修改、新增和数据表一样
~~~

### 索引

> 数据表的目录，提高数据表查询效率

#### 索引的分类

> 列的不同
>
> * 主键索引 主键字段
> * 唯一索引 唯一列unique
> * 普通索引 普通字段
> * 组合索引 两个及以上字段联合起来创建的索引
>
> 在创建数据表时，将字段声明为主键或者唯一约束时，都会在相应字段创建主键索引
>
> 

#### 创建索引

~~~sql
//查询数据表索引
show indexes from tb_testindex;

//创建唯一索引
create unique index index_test1 on tb_testindex(tid)

//创建普通索引
create index index_test2 on tb_testindex(...)

//创建组合索引
create index index_teset on tb_testindex(... , ...)

//全文检索

~~~

#### 索引使用

> 索引创建完成之后无需调用，当根据创建索引的列进行数据查询的时候，会自动使用索引
>
> 如果组合索引需要根据创建索引的所有字段进行。

#### 查看、删除索引

~~~sql
show create table tb_test/G --命令行

//查询数据表的索引
show indexes from tb_testindex；

//查询索引
show keys from tb_testindex

//删除索引
drop index index_test3 on tb_testindex;
~~~

因为所以是建立在表的字段上的，不同的表中可能会出现相同名称的索引，因此删除索引时需要加on

#### 使用总结

* 优点
  * 提高了查询效率
  * 避免服务器排序
* 缺点
  * 索引根据数据表列的值创建的，当数据表中数据进行DML操作时，会重新生成索引
  * 索引文件占据磁盘空间
* 数据不多时，全表扫描可能更快
* DML操作比较频繁不建议使用
* 不要在数据重复度高的列上创建索引
* 创建索引之后，要注意SQL语句的编写，避免索引失效

## 数据库事务

把完成特定业务的多个数据库DML操作步骤成为一个事务。

### ACID特性 ***

* 原子性

  一个事务中的多个DMl操作，要么同时执行完成，要么同时执行失败

* 一致性

  事务执行前后，数据一致，不被破坏

* 隔离性

  允许各种事务同时进行，但是不能相互影响

* 持久性

  事务完成后，对数据的操作时永久的

### 事务管理



~~~sql
//借书业务

insert into records(snum)
~~~

#### 自动提交与手动提交

默认自动提交，执行指令之后会自动同步到数据库内、、

手动提交先将结果保留在缓存中，然后手动同步到数据库中

#### 开启事务

即关闭自动提交

~~~sql
start transaction //手动提交
//借书

//修改借书记录

//如果出现问题，则事务回滚，清除连接缓存
rellback;

//如果没有问题，则commit；
~~~

#### 事务隔离级别

允许多个事务之间相互独立、隔离

* 读未提交

  T2可以读取T1执行但是未提交的数据，可能会导致脏读

  ~~~sql
  脏读：一个事务读取到了另一个事务中未提交的数据
  ~~~

* 读已提交

  T2只能读取T1已经提交的数据

  ~~~sql
  虚读（不可重复读） 同一事物中，两次查阅数据不一致
  ~~~

* ​	可重复读

  T2执行第一次查询之后，在事务结束前，其他食物不能修改对应的事务

  ~~~sql
  幻读：T2对数据表中的数据进行修改，然后查询，在查询之前T1像数据表中新增了一条数据没导致T2以为修改了所有数据，但是查询出了与修改不一致的数据
  ~~~

  

* 串行化

  同时只允许一个事务对数据表进行操作，避免了脏读、虚读、幻读问题

#### 设置默认隔离级别

默认时可重复读

~~~sql
//查看隔离级别

select @@transaction_isolation

//设置Mysql默认隔离级别

set session transaction isolation level read comitted
~~~

