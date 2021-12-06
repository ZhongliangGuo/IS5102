# MySQL概述

由**[Zhongliang Guo](mailto:zg34@st-andrews.ac.uk)**总结于2020年3月，跟着bilibili大学的千峰学院学的（2333 <img src="https://s4.ax1x.com/2021/12/07/oyHCrR.png" style="zoom: 25%;" />)。

学的是MySQL，但是跟SQLite差不多，可以直接拿来用。

这个笔记应该是我GitHub上为数不多的华人特供了 <img src="https://s4.ax1x.com/2021/12/07/oyHCrR.png" style="zoom: 25%;" />,用 `Typora` 食用更佳。

St Andrews的 `IS5102 DBMS` 这门课我从头到尾没听过，全程吃老本，三次作业两次跟SQL本身技术相关的作业分别是16.5/20， 17.5/20，第三次的essay还没出分，在Alex不改教学大纲的前提下够用了。

BTW，Alex的口音好重 捏妈的 给<img src="https://s4.ax1x.com/2021/12/07/oyHass.png" style="zoom:8%;" />听麻了 <img src="https://s4.ax1x.com/2021/12/07/oyHCrR.png" style="zoom: 25%;" />。

## MySQL语法分类

1. DDL：Data Definition Language——数据定义语言

   ​	定义数据库对象

   ​	主要关键字：create，drop，alter

2. DML：Data Manipulation Language——数据操作语言

   ​	对数据库表里的数据进行增删改

   ​	主要关键字：insert，delete，update

3. DQL：Data Query Language——数据查询语言

   ​	用来查询数据库中的记录

   ​	主要关键字：select，where

4. DCL：Data Control Language——数据控制语言

   ​	定义数据库访问权限和安全级别、创建用户

   ​	主要关键字：grant， revoke

## MySQL数据类型

| 数据类型  | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| int       | 整数型                                                       |
| double    | 小数类型 eg: score double(5,2)表示最大5位数，小数点后保留2位 |
| date      | 日期 只包含年月日，yyyy-MM-dd                                |
| datetime  | 日期 包含年月日时分秒，yyyy-MM-dd HH:mm:ss                   |
| timestamp | 时间戳类型 格式和datetime一样，使用时不赋值或赋值null则默认使用系统时间赋值 |
| varchar   | 字符串 varchar(长度)                                         |

# DDL语法

## 操作数据库

### 创建

```mysql
-- 创建数据库：
	create database 数据库名;
-- 创建数据库，判断不存在，再创建：
	create database if not exists 数据库名称;
-- 创建数据库，并指定字符集：
	create database 数据库名称 character set 字符集名;
```

### 查询

```mysql
-- 查询所有数据库名称：
	show databases;
-- 查询某个数据库的字符集、创建语句：
	show create database 数据库名称;
```

### 修改

```mysql
-- 修改数据库的字符集：
	alter database 数据库名称 character set 字符集名称;
```

### 删除

```mysql
-- 删除数据库：
	drop database 数据库名称;
-- 判断数据是否存在，如果存在，删除：
	drop database if exists 数据库名称;
```

### 使用数据库

```mysql
-- 查询当前正在使用的数据库名称：
	select database();
-- 使用数据库：
	use 数据库名称;
```

## 操作表

### 创建

```mysql
-- 在db1数据库中创建一个表：
	use db1;
	create table 表名(列名1 数据类型1, 列名2 数据类型2,···, 列名n 数据类型n)
-- 复制表：
	create table 表名 like 被复制的表名;
```

### 查询

```mysql
-- 查询所有表：
	show tables;
-- 查询表结构：
	desc 表名;
```

### 修改

```mysql
-- 修改表名：
	alter table 表名 rename to 新表名;
-- 修改表的字符集：
	alter table 表名 character set 字符集名称;
-- 添加一列：
	alter table 表名 add 列名 数据类型;
-- 修改列名称、类型：
	alter table 表名 change 列名 新列名 新数据类型;
	alter table 表名 modify 列名 新数据类型;
-- 删除列：
	alter table 表名 drop 列名;
```

### 删除

```mysql
-- 删除表：
	drop table 表名;
	drop table if exists 表名;
```

# DML语法

## 添加数据

```mysql
-- 在表中添加一条数据：
	insert into 表名(列名1, 列名2,···, 列名n) values(值1, 值2,···, 值n);
```

注意：

1. 列名和值需要相对应。
2. 如果直接用：
   insert  into  表名  values(值1,  值2,  ···,  值2)
   默认给所有列添加值
3. 除了int，其他全都得用引号括起来，单双都可。

## 删除数据

```mysql
-- 删除一个表中的某一项：
	delete from 表名 where 列名 = 值1;
-- 清空表：
	delete from 表名;    -- 效率低
	TRUNCATE TABLE 表名; -- 效率高
```

## 修改数据

```mysql
-- 修改一个表中的数据：
	update 表名 set 列名1 = 值1, 列名2 = 值2,···,列名n = 值n where 条件
```

注意：
		不加条件所有数据都遍历一次

# DQL语法

```mysql
select
	字段列表 
from
	表名列表 
where
	条件列表 
group by
	分组字段 
having
	分组之后的条件 
order by
	排序 
limit
	分页限定
```

## 基础查询

```mysql
-- 去除重复结果：
	select distinct 列名 from 表名;
-- 起别名：
	select 列名 as 别名 from 表名;  -- as可省略
```

## 条件查询

运算符：

| 比较运算符              | 说明                                                         |
| ----------------------- | ------------------------------------------------------------ |
| >、<、<=、>=、=、<>     | SQL中没有==，<>表示不等于，!=是mysql的方言，在SQL中不通用。  |
| between···and···        | between 100 and 200  →  [100,200]，两边都可取到。            |
| in(集合)                | 集合表示多个值，用逗号分隔，相当于python中的集合{}换成了()。 |
| like '张%' 和 like'张_' | 模糊查询，_表示单个任意字符，%表示任意多个字符。             |
| is null                 | SQL中不能用=null，is null起到=null的作用。                   |
| and或&&                 | 与，and通用，&&不通用。                                      |
| or或\|\|                | 或                                                           |
| not或!                  | 非                                                           |

## 排序查询

```mysql
-- 升序查询：
	select * from 表名 order by 列名 ASC;
-- 降序查询：
	select * from 表名 order by 列名 DESC;
-- 多条件排序查询：
	select * from 表名 order by 列名1 排序方式, 列名2 排序方式;
```

## 聚合函数

聚合函数将一列数据作为一个整体，进行纵向计算，默认排除null值。

1. count：计数
2. max：求最大值
3. min：求最小值
4. sum：求和
5. avg：求平均值

```mysql
-- 语法：
	select 聚合函数(列名) from 表名;
-- 不排除值为null的数据：
	select count(ifnull(列名,替换null的值)) from 表名;
```

## 分组查询

把拥有相同特征的一类数据划分为一组进行操作。 

以查询学生信息为例：

```mysql
-- 按照性表分组，分别查询男、女学生的平均分。
	select sex, avg(score) from student group by sex;
-- 按照性表分组，分别查询男、女学生的平均分，低于70分的不计。
	select sex, avg(score) from student where math > 70 group by sex;
-- 按照性表分组，分别查询男、女学生的平均分，低于70分的不计；查询结果中少于2人的组不计。
	select sex, avg(score) from student where math > 70 group by sex having count(name);
```

where和having如何区分：
	where在分组前限定，如果不满足条件，则不参与分组。不可以跟聚合函数。
	having在分组后限定，如果不满足条件，则不会被输出。可以跟聚合函数。

## 分页查询

```mysql
-- 每页显示三条记录：
	select * from 表名 (当前页码-1)×每页显示条数, 每页显示条数;
```

分页查询是“方言”，只有MySQL中才有limit这种用法。

## 多表查询

语法：

```mysql
select
	列名列表
from
	表名列表
where
	······
```

结果中有多余的笛卡尔积。

消除方法：

1. 内连接查询：
   注意：从那些表中查询、条件是什么、查询哪些字段
   1. 隐式内连接：
      用where消除所有的冗余信息	eg：where xx = xx;
   2. 显式内连接：
      select 字段列表 from 表名 [inner] join 表名 on 条件;
2. 外连接查询：
   1. 左外连接：
      select 字段列表 from 表1 left [outer] join 表2 on 条件;
      查询的是左表所有数据以及交集部分。
   2. 右外连接：
      select 字段列表 from 表1 right [outer] join 表2 on 条件;
      查询的是左表所有数据以及交集部分。
3. 子查询：
   查询中嵌套查询。加个括号就行，跟加法交换律加括号差不多。
   1. 子查询的结果是单行单列的：
      子查询可以作为条件用运算符去判断。只能使用>、<、=、>=、<=、<>
   2. 子查询的结果是多行单列的：
      子查询可以作为条件，使用运算符in来判断。
   3. 子查询的结果是多行多列的：
      子查询可以作为一张虚拟表参与查询。

# DCL语法

## 管理用户

```mysql
-- 切换到mysql数据库：
	use mysql;
```

1. 添加用户

   ```mysql
   create user '用户名'@'主机名' identified by '密码';
   ```

2. 删除用户

   ```mysql
   DROP USER '用户名'@'主机名';
   ```

3. 修改用户密码

   ```mysql
   UPDATE USER SET PASSWORD = PASSWORD('新密码') WHERE USER = '用户名';
   UPDATE USER SET PASSWORD = PASSWORD('abc') WHERE USER = 'lisi';
   ```

4. 查询用户：

   ```mysql
   select * from user;
   ```

## 权限管理

1. 查询权限

   ```mysql
   SHOW GRANTS FOR '用户名'@'主机名';
   ```

2. 授予权限

   ```mysql
   grant 权限列表 on 数据库名.表名 to '用户名'@'主机名';
   -- 给张三用户授予所有权限，在任意数据库任意表上
   ```

3. 撤销权限

   ```mysql
   revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名';
   ```

# 约束

约束是指对表中的数据进行限定，保证数据的正确性、有效性和完整性。

**约束的分类：**

1. 主键约束：primary key
2. 非空约束：not null
3. 唯一约束：unique
4. 外键约束：foreign key

## 非空约束

该列的值不能为空。

```mysql
-- 在创建表时添加非空约束：
	create table stu(id int, 
                     name varchar(20) not null -- 添加了非空约束
                    );
-- 删除name的非空约束：
	alter table stu modify name varchar(20);
-- 创建表后对name添加非空约束：
	alter table stu modify name varchar(20) not null;
```

## 唯一约束

该列的值不能重复，但寻在没有添加非空约束的情况下可以都为null。

```mysql
-- 创建表时添加唯一约束：
	create table stu(id int, 
                     phone_number varchar(20) unique -- 添加了唯一约束
                     );
-- 删除phone_number的唯一约束：
  × alter table stu modify phone_number varchar(20); -- 无法删除唯一约束
  √ alter table stu drop index phone_number;         -- 可以删除唯一约束
-- 创建表后对phone_number添加唯一约束：
	alter table stu modify phone_number varchar(20) unique; -- 只有表中的phone_number没有重复的值，才能执行成功。
```

## 主键约束

该列的值非空且唯一。

```mysql
-- 在创建表时添加主键约束：
	create table stu(id int primary key, -- 添加了主键约束
                     name varchar(20)
                    );
-- 删除id的主键约束：
  × alter table stu modify id int;    -- 无法删除主键约束
  √ alter table stu drop primary key; -- 可以删除主键约束
-- 创建表后对id添加主键约束：
	alter table stu modify id int primary key; -- 只有表中的id没有重复的值，才能执行成功。
-- 创建联合主键：
	create table 表名(id1 int,
                     id2 int,
                     primary key(id1, id2)
                    );
```

## 自动增长

自动增长只跟上一条数据有关。

```mysql
-- 在创建表的时候，添加主键约束并完成主键自动增长：
	create table stu(id int primary key auto_increment, -- 添加了主键约束并实现自动增长
                     name varchar(20)
                    );
-- 删除id的自动增长：
	alter table stu modify id int;
-- 创建表后对id添加自动增长：
	alter table stu modify id int auto_increment;
```

## 外键约束

让表与表产生关系，从而保证数据的正确性。

```mysql
-- 添加一个部门表：
	create table department(id int,
                            loc varchar(20)
                           );
-- 在创建表的时候，添加外键约束：
	create employee(e_id int,
                    name varchar(20),
                    dep_id int constraint emp_dep_fk foreign key (dep_id) references department(id)
                   )
-- 删除外键：
	alter table employee drop foreign key emp_dep_fk;
-- 创建表后添加外键：
	alter table employee add constraint emp_dep_fk foreign key (dep_id) references department(id);
```

级联操作允许主表更的时候，从表跟着更改。

```mysql
-- 添加外键，设置级联更新：
	alter table employee add constraint emp_dep_fk foreign key (dep_id) references department(id) on update cascade;
	-- department表中的id改变后employee表中的dep_id跟着变
-- 设置级联删除：
	alter table employee add constraint emp_dep_fk foreign key (dep_id) references department(id) on delete cascade;
	-- department 表中的某一id被删除后employee表中带有该id的数据都被删除
```

# 数据库设计

## 多表关系

1. 一对一关系：
   A和B，一个A只能对应一个B，一个B也只能对应一个A，AB互为充要条件。如：人和身份证。
   **实现：在任意一方添加`唯一`外键指向另一方的主键**
2. 一对多 or 多对一：
   A和B，一个A有多个B，一个B只能对应一个A，A是B的必要不充分条件。如：部门和员工。
   **实现：在多的一方建立外键，指向一的一方的主键**
3. 多对多：
   A和B，一个A有多个B，一个B有多个A，AB互为既不必要也不充分条件。如：学生和选修课。
   **实现：建立一张中间表，中间表至少包含两个字段，这两个字段作为第三章表的外键，分别指向两张表的主键**

## 设计数据库的范式

### 第一范式（1NF）

每一列都是不可分割的原子数据项

### 第二范式（2NF）

在1NF基础上，非码属性必须完全依赖主码。（在1NF基础上消除非主属性对主码的部分函数依赖）

函数依赖：A-->B，如果通过A属性或属性组的值，可以确定唯一B属性的值，则称B依赖于A。
					eg：学号-->姓名      (学号, 课程名)-->分数

完全函数依赖：A-->B，如果A是一个属性组，则B属性值的确定需要依赖于A属性组中所有的属性值。
					eg：(学号, 课程名)-->分数

部分函数依赖：A-->B，如果A是一个属性组，则B的属性值的确定只需要依赖于A属性组中某一些值即可。
					eg：(学号, 课程名)-->姓名

传递函数依赖：A-->B，B-->C，如果通过A属性的值可以确定唯一B属性的值，再通过B属性的值可以确定唯一C属性的值，则称C传递函数依赖于A。
					eg：学号-->系名，系名-->系主任

码：如果在一张表中，一个属性或属性组被其他所有属性所完全依赖，则称这个属性或属性组为该表的码。

主属性：码属性组中的所有属性。

非主属性：除了码属性组的属性。

### 第三范式（3NF）

在2NF基础上，任何非主属性不依赖于其他非主属性。（在2NF基础上消除传递依赖）

# 数据库的备份和还原

## 命令行

备份：
	mysqldump -u用户名 -p密码 数据库名称 > 保存路径/文件名.sql

还原：

1. 创建数据库
2. 使用数据库
3. 执行文件。source 文件路径/文件名.sql

## GUI工具

备份：
	SQLYog右键导出。

还原：
	SQLYog右键执行SQL文件。

# 事务

## 介绍

概念：如果一个包含多个步骤的业务操作，被事务管理，那么这些操作要么同时成功，要么同时失败。

操作：

	1. 开启事务：start transaction；
	2. 回滚：rollback；
	3. 提交：commit；

MySQL事务默认自动提交，手动提交需要先开启事务，后提交。

查询提交方式：

```mysql
select @@autocommit; -- 1代表自动提交，0代表手动提交。
```

修改提交方式：

```mysql
set @@autocommit = 0;
```

## 特征

1. 原子性：不可分割的最小操作单位，要么同时成功，要么同时失败。
2. 持久性：当事务提交或者回滚后，数据库会持久化的保存数据。
3. 隔离性：多个事务之间相互独立。
4. 一致性：事务操作前后数据总量不变。

## 隔离级别

概念：
	多个事务之间是隔离的，相互独立的，但是如果多个事务操作同一批数据，则会引发一些问题。设置不同的隔离级别就可以解决这些问题。

存在的问题：

 	1. 脏读：一个事务读取到另一个事务没有提交的数据。
 	2. 不可重复读（虚读）：在同一个事务中，两次读取到的数据不一样。
 	3. 幻读：一个事务操作（DML）数据表中所有记录，另一个事务添加了一条数据，则第一个事务查询不到自己的修改。

隔离级别：（MySQL默认repeatable read）

1. read uncommitted：读未提交
   问题：脏读、不可重复读、幻读

2. read committed：读已提交
   问题：不可重复读、幻读

3. repeatable read：可重复读
   问题：幻读

4. serializable：串行化
   问题：没有问题

   注意：隔离级别从小大大安全性越来越高，但是效率越来越低。

数据库查询隔离级别：

```mysql
select @@tx_isolation;
```

数据库设置隔离级别：

```mysql
set global transaction isolation level 隔离级别;
```