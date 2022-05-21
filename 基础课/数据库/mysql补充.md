# 补充

> 现在运营需要查看用户来自于哪些学校，请从用户信息表中取出学校的去重数据。
>
> 使用关键字distinct 
>
> ~~~sql
> selct distinct university from user_profile
> ~~~
>

>现在运营只需要查看前2个用户明细设备ID数据，请你从用户信息表 user_profile 中取出相应结果。
>
>使用关键字 limit
>
>~~~sql
>select device_id from user_profile limit 0,2
>~~~

>现在你需要查看前2个用户明细设备ID数据，并将列名改为 'user_infos_example',，请你从用户信息表取出相应结果。
>
>使用关键字as
>
>~~~sql
>select device_id as user_infos_example    form user_profile limit 0,2;
>~~~

>运营想要知道复旦大学学生gpa最高值是多少，请你取出相应数据
>
>~~~sql
>select gpa from user_profile 
>where university = "复旦大学" 
>order by gpa desc
>limit 1;
>~~~
>
>



> ​	多表查询
>
> ~~~sql
> select device_id,question_id,result 
> from question_practice_detail
> where device_id=(
>     select device_id
>     from user_profile
>     where university = "浙江大学"
> )
> order by question_id;
> ~~~
>
> ~~~sql
> select q.device_id,q.question_id,q.result
> from question_practice_detail q join user_profile u on q.device_id=u.device_id
> where u.university='浙江大学'
> order by q.question_id;
> ~~~
>
> 