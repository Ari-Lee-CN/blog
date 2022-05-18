library(dplyr)

install.packages("nyclights13")

myFlights <- select(flights,year,month,dat,dep_delay,arr_delay,distance,dest)
# 用来筛选变量列
myFlight <- rename(myFlight, destination =dest)
# 重命名列名  使用renma函数

myFlight <- filter(myFlights,!is.na(dep_delay),!is.na(arr_delay))
myFlights
# is.na()找出缺失值，采用逻辑运算符”！X“将限定有小数数据，最后使用filter函数”过滤“的到有效数据，成功删除了缺失数据

# 数组排序 arrang()函数 默认升序 desc则为降序
myFlight <- arrange(myFlights,desc(arr-delay))
myFlights

# 数据计算：数据分组、应用函数、组合结果
# group by 数据分组函数

by_dest <- group_by(myFlights,destination)
class(by_dest)
by_dest

# summarize()函数 
# 统计各个分组目的地的航班数量
delay_sum <- summarise(by_dest,count =n)
dist = mean(distance,na.rm = TRUE),
delay = mean(arr_delay,na.r= TRUE)
#按照航班数降序排序
delay_sum <- arrange(delay_sum,desc(count))
delay_sum

delay_sum <- arrange(delay_sum,desc(count))
delay_sum <- filter(delay_sum,count>20)

# 按目的地分组
by_dest <- group_by(myFlights,destination)
# 统计各分组目的地的航班数
delay_sum <- summarise(by_dest, count=n())
# 计算平均航行距离
dist = mean(distance,na.m= TRUE)
# 计算平均延误时间
delay = mean(arr_delay,na.rm = TRUE)
# 按照航班数降序排列
delay_sum <- arrange(delay_sum, desc(count))
# 剔除噪音数据
delay_sum <- filter(delay_sum,count>20)

# 使用管道
delay_sum <- myFlights %>%
group_by(destination) %>%
summarise(count = n()),
dist = mean(distance,na_me = TRUE),
delay = mean(arr_delay,na.m=TRUE)%>%
filter(count>20)
delay_sum

ggplot(data = delay_sum)+
geom_point(mapping = aes(x=dist,y=delay))+
geom_smooth(mapping =aes(x=dist,y=delay))
# 绘制平均航线和平均延误时间的散点图，拟合一条平滑曲线