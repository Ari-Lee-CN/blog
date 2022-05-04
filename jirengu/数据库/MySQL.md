# MySQL

# SQL

structured Query Language 结构查询语言，用于存取、查询、更新数据以及管理关系型数据库

### SQL分类

* DDL 数据定义语言
  完成对于数据库对象的创建删除修改
* DML 数据操纵语言
  完成对于数据表中数据的添加、删除、修改等操作
* DQL 数据查询语言
  用于将数据表中的数据查询出来
* DCL 数据控制语言
  用于完成事务管理等控制性操作

### SQL基本语法

* SQL指令不区分大小写
* 每条SQL指令结束之后都以；结尾
* SQL指令之间可以不限制换行，关键词之间以空格进行分割

### DDL数据定义语言

1. 创建数据库  create database 【name】；
   * 避免重复 create database [name] if not exists；
   * 指定数据集 create database [name] character set utf8;

2. 显示数据库列表 show databases；

   * 显示语法 show create database [ name]

3. 修改数据库字符集 alter database 【name】character set utf8/gbk

4. 删除数据库   drop database 【name】

   * drop database 【name】 if exist

5. 使用数据库 use database

6. 创建数据表 create table students（

   ​		stu_num char(8) not null,

   ​		stu_name varchar(20) not null,

   ​		stu_gender char(2) not null,

   ​		stu_age int not null ,

   ​		stu_tel cha(11) not null unique

   );

7. 查询删除数据表

   * 查询表结构 desc【name】
   * 删除数据表 drop table 【name】
     drop table  if exists [name]

8. 修改数据表 

   * 修改表名 alter tabel 【name】 rename to 【name】;
   * 数据表字符集默认与数据库一致
     later table [name] character set utf8
   * 添加字段（列）
     lalter table <tablename> add <columnname> varchar(200)
   * 修改字段的列表和类型
     alter table <tablename> change <oldColumnName> <newColumnName> <type>；
   * 直接修改字段类型
     alter table <tablename> modify <columnname><type>
   * 删除字段
     alter table <tablename> drop<columnname>

### 数据类型

指的是数据表中列中支持存放的数据的类型

#### 数值类型

多种数据类型可以存放数值，但是不同类型存放的数据的范围或者形式是不同的。

| 类型         | 内存空间大小 | 范围                                    | 说明                                          |
| ------------ | ------------ | --------------------------------------- | --------------------------------------------- |
| tinyint      | 1byte（8wei) | 有符号 -128~127<br />无符号 0~255       | 小型整数                                      |
| smallint     | 2byte        | 有符号 -32768~32767<br />无符号 0~65535 | 小型整数                                      |
| mediumint    | 3            |                                         | 中型整数                                      |
| int /integer | 4            |                                         | 整数                                          |
| bigint       | 5            |                                         | 大型整数                                      |
| float        | 4            |                                         | 单精度                                        |
| double       | 8            |                                         | 双精度                                        |
| decimal      | 第一个参数+2 |                                         | decimal（10，2）表示数值一共有十位，小数位2位 |



#### 字符类型

存储字符序列的类型

| 类型       | 字符序列的长度范围 | 说明                                                         |
| ---------- | ------------------ | ------------------------------------------------------------ |
| char       | 0~255字节          | 定长字符串，党指定数据表字段位char(n)时，此列中的数据最长位n个字符，如果添加的数据少于n，则用0自动补全。 |
| varchar    | 0~65536字节        | 可变长度字符串，最大长度位65535                              |
| tinyblob   | 0~255字节          | 存储二进制字符串                                             |
| blob       | 0~65535            | 存储二进制字符串                                             |
| mediumblob | 0~1677215          |                                                              |
| longblob   | 0~4294967295       |                                                              |
| tinytext   | 0~255              | 文本数据（字符串）可变                                       |
| text'      |                    |                                                              |
| longtext   |                    |                                                              |



#### 日期类型

我们可以使用字符串来存储时间，但是如果我们要基于时间段进行查询操作，就不便于查询实现。

| 类型      | 格式                 | 说明               |
| --------- | -------------------- | ------------------ |
| data      | 2021-09-13           | 日期，只存储年月日 |
| time      | 11：12：13           | 只存储时分秒       |
| year      | 2022                 | 年份               |
| datatime  | 2022-4-21 11：12：13 |                    |
| datastamp | 2022421111213        | 日期戳             |

### 字段约束

在创建数据表的时候，指定的对数据表中的列的数据限制性的要求（对表的列中的数据进行限制）

* 保证数据的有效性
* 保证数据的完整性
* 保证数据的正确性

常见约束：

* 非空约束not null
* 唯一约束unique
* 主键约束 primary key  能够唯一标识数据表中唯一的数据
* 外键约束 foreign key 建立不同表之间的关联关系

#### 非空约束

#### 唯一约束

#### 主键约束

主键是数据表中记录的唯一标识，一张表中最多只能有一个主键。

~~~sql
定义主键方式一：
create table books(
	boo_isbn char(4) primary key,
    book_name varchar(10) not null,
	book_author varchar(6)
);

定义主键方式二：
create table books(
	boo_isbn char(4),
    book_name varchar(10) not null,
	book_author varchar(6)，
    primary key（book_isbn)
);
~~~

党一个字段声明为逐渐之后，添加数据时：

1. 此字段数据不能为null

2. 此字段数据不能重复

删除主键约束

~~~sql
alter table books drop primary key;
~~~

创建表之后添加主键约束

~~~sql
create table books(
	boo_isbn char(4),
    book_name varchar(10) not null,
	book_author varchar(6)，
);

后续添加主键约束
alter table books modify [字段名] char(4) primary key;
~~~



#### 主键自动增长

在创建一张数据表时，如果数据表中有可以作为主键的我们可以直接认为这个列是主键；党有些数据表中没有合适的列作为主键时，我们可以额外定义一个与记录本身无关的列（id列）作为主键，此列数据没有具体含义，主要是为了标识一个记录，在mysql中可以将此列定义为int类型，同时设置为自动增长。

当我们像数据表中新增一条记录时，无需提供id列的值，它会自动生成

##### 定义主键自动增长

~~~sql
定义int 类型字段自动增长
create table type{
	type_id int primary key auto_increamenht,
	type_name varchar(20) not null,
	type_remark varchar(100)
};
~~~

* 注意，自动增长从1开始，每次添加一条记录，自动增长的列会自动加一，如果我们把某条记录删除，自动增长的数据也不会重复生成（自动增长只保证唯一性，不保证连续性）

#### 联合主键

将数据表中的多列组合在一起设置为表的主键

定义联合组件

~~~sql
create table grades(
	stu_num char(8),
    couse_id int,
    score int,
    primary key(stu_num,couse_id)
)
~~~

在实际应用中，联合组件使用频率较低

### DML数据操纵语言

DML用于完成对于数据表中数据的插入、删除、修改操作。

~~~sql
create table students(
	stu_num char(8) primary key,
    stu_name varchar(20) not null,
    stu_gender char(2) not null,
    stu_age int not null,
    stu_tel char(11) not null unique,
    stu_qq varchar(11) unique
);
~~~

#### 插入数据

~~~sql
insert into <tablename>(columnname,columnName...) values(value1,value2);

//不允许为空的列必须添加数据
//数据表中的字段名列表顺序可以与表中不一致，但是values中值的顺序必须与表后字段名顺序对应。
//当向表中的所有列添加数据时，数据表后面的字段列表可以省略，但是values中的值的顺序要与数据表定义的字段保持一致
~~~

#### 删除数据

从数据表中删除满足特定条件的数据

~~~sql
delete from <tablename> where condition
~~~



#### 修改数据

~~~sql
 update <tablename> set <columnName> value(多个条件用,隔开) where condition
 
//若没有where子句，则说明修改相应的所有数据
~~~

### DQL数据查询语言

~~~SQL
select colnumName from <tablename>;

//如果要显示查询到记录的所有列，可以使用*代替字段名列表

select * from stus;
~~~

#### where 子句

用于添加条件筛选满足特定条件进行删除、修改、查询操作

|         | 说明                     | 示例 |
| ------- | ------------------------ | ---- |
| =       | 等于、筛选字段的精确匹配 |      |
| != 和<> | 不等于                   |      |
| >       | 大于                     |      |
| <       | 小于                     |      |
| >=      |                          |      |
| <=      |                          |      |

多条件查询

> 在where子句中，可以将多个逻辑运算（and or not）进行连接，通过多个条件来进行筛选要操作的数据。

#### LIKE子句

在where子句中使用like进行模糊查询

~~~sql
select = from tableName where columnName like 'reg';
~~~

在like关键字后的reg表达式中

* % 表示任意多个字符
* _表示任意一个字符

#### 对查询结果的处理

声明显示查询结果的指定列

~~~sql
select colnumName1,columnName2 from stus where stu_age>20;
~~~

计算列

>  对数据表中查询的记录的列进行一定的运算之后显示出来

~~~sql
select stu_name,2021-stu_age as stu_birth_year from stus;
~~~



字段别名

> 可以为查询结果的列名设置一个语义性更强的别名

消除重复行

> 从查询的结果中将重复的记录消除

~~~sql
select distinct from 
~~~

#### 排序 order by

语法

~~~sql
select from tableName where condition order by columnName asc|desc,(columnName asc|desc)
~~~

> order by columnName 表示将查询结果按照指定的顺序进行排序
>
> * asc  顺序排序
> * desc 降序

#### 聚合函数

> sql种提供了一些可以对查询的记录的列进行计算的函数——聚合函数

* count 统计函数  统计满足条件的指定字段值的个数（记录数）

  ~~~sql
  select count() from stus;
  ~~~

* max()计算最大值，查询满足条件的指定列中的最大值

  ~~~sql
  select max() from     ;
  ~~~

* min()

* sum()

* avg() 求平均值

#### 日期函数、字符串函数

日期函数

> 当我们向日期类型的列添加数据时，可以通过字符串类型赋值（字符串的格式必须为yyyy-mm-dd hh:kk:kk)
>
> 如果想要获取当前系统时间可以使用now()和sysdate()

~~~sql
insert into time balues(now())
~~~

字符串函数

> 通过sql指令对字符串进行处理

~~~sql
//concat

select concat(    ,   ) from stus;

//upper(column) 转换为大写

//lower

//substring（column,start,len) 从指定列种截取部分显示
~~~

#### 分组查询

> 分组：将数据表中的记录按照指定的类进行分组

~~~SQL
select 分组字段/聚合函数 from 表名（where） group by 分组列名[having 操作] order by
~~~

* select 后使用* 表示对查询结果进行分组之后，显示魅族的第一条数据（通常是无意义的）
* select后 通常显示分组字段和聚合函数对分组后的数据进行统计、求和、平均值等
* 语句执行顺序 先根据where条件从数据库种查询记录，对查询记录进行分组，执行having分组对分组后的数据进行筛选

~~~SQL
select stu_age,count(stu_num) from stus group by stu_age order by stu_age

# 先对大学生进行分组，然后统计各组的学生数量，还可以对最终的结果排序
~~~

#### 分页查询

> 数据记录比较多的时候，分页查询，提高可读性，以获得比较好的用户体验。

~~~sql
select  ... from .... where ... limit param1,param2
~~~

* param1 int 表示获取查询语句结果中的第一条数据的索引
* param2 int 表示获取的查询数据记录的条数
* 如果剩下的数据条数<param2 则返回剩余所有数据

~~~sql
//查询第一页
select * from stus (where...) limit(0,3)

//查询第二页数据
select * from stus (where...) limit(3,6)

//查询第几页的数据
select * from <tablename> {where...} limit(pageNum - 1)* pageSize
~~~



