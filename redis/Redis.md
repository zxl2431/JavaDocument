# Redis

### 一、NoSql



### 二、Redis概述



### 三、Redis安装



### 四、性能测试



### 五、五大数据类型

#### 1、String



#### 2、List 

​	list 实际是一个链表

```bash
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> lpush list one
(integer) 1
127.0.0.1:6379> lpush list two
(integer) 2
127.0.0.1:6379> lpush list three
(integer) 3
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "two"
3) "one"
127.0.0.1:6379> lrange list 0 1
1) "three"
2) "two"
127.0.0.1:6379> Rpush list right #将一个值或者多个值插入头部
(integer) 4
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "two"
3) "one"
4) "right"
####################################################
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "two"
3) "one"
4) "right"
127.0.0.1:6379> Lpop list
"three"
127.0.0.1:6379> Rpop list
"right"
127.0.0.1:6379> lrange list 0 -1
1) "two"
2) "one"
####################################################
127.0.0.1:6379> lindex list 1
"one"
127.0.0.1:6379> lindex list 0
"two"
####################################################
127.0.0.1:6379> flushdb
OK
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> lpush list one
(integer) 1
127.0.0.1:6379> lpush list two
(integer) 2
127.0.0.1:6379> lpush list three
(integer) 3
127.0.0.1:6379> llen list
(integer) 3
####################################################
127.0.0.1:6379> lpush list three
(integer) 4
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "three"
3) "two"
4) "one"
127.0.0.1:6379> lrem list 1 one #移除值 移除指定个数的某个值
(integer) 1
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "three"
3) "two"
127.0.0.1:6379> lrem list 1 three
(integer) 1
127.0.0.1:6379> lrange list 0 -1
1) "three"
2) "two"
########################## trim截取 ##########################
127.0.0.1:6379> clear
127.0.0.1:6379> Rpush mylist hello1
(integer) 1
127.0.0.1:6379> Rpush mylist hello2
(integer) 2
127.0.0.1:6379> Rpush mylist hello3
(integer) 3
127.0.0.1:6379> Rpush mylist hello4
(integer) 4
127.0.0.1:6379> lrange mylist 0 -1
1) "hello1"
2) "hello2"
3) "hello3"
4) "hello4"
127.0.0.1:6379> ltrim mylist 1 2
OK
127.0.0.1:6379> lrange mylist 0 -1
1) "hello2"
2) "hello3"

########################## RpopLpush ##########################
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> rpush mylist hello1
(integer) 1
127.0.0.1:6379> rpush mylist hello2
(integer) 2
127.0.0.1:6379> rpush mylist hello3
(integer) 3
127.0.0.1:6379> rpush mylist hello4
(integer) 4
127.0.0.1:6379> lrange mylist 0 -1
1) "hello1"
2) "hello2"
3) "hello3"
4) "hello4"
127.0.0.1:6379> rpoplpush mylist myotherlist #source右边pop destin左边push
"hello4"
127.0.0.1:6379> lrange mylist 0 -1
1) "hello1"
2) "hello2"
3) "hello3"
127.0.0.1:6379> lrange myotherlist 0 -1
1) "hello4"
127.0.0.1:6379> lpoplpush mylist myotherlist
(error) ERR unknown command 'lpoplpush'
127.0.0.1:6379> lpoprpush mylist myotherlist
(error) ERR unknown command 'lpoprpush'

########################## exists lset更新值 ##########################
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> exists list
(integer) 0
127.0.0.1:6379> lset list 0 item #将列表中指定下标的值替换为另外一个值 更新操作
(error) ERR no such key
127.0.0.1:6379> lpush list value1
(integer) 1
127.0.0.1:6379> lrange list 0 -1
1) "value1"
127.0.0.1:6379> lset list 0 item
OK
127.0.0.1:6379> lrange list 0 -1
1) "item"
127.0.0.1:6379> lset list 1 other 	# 不存在就会报错
(error) ERR index out of range

########################## linsert ##########################
127.0.0.1:6379> clear
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> Rpush mylist hello 
(integer) 1
127.0.0.1:6379> Rpush mylist world
(integer) 2
127.0.0.1:6379> lrange mylist 0 -1
1) "hello"
2) "world"
127.0.0.1:6379> linsert mylist before world old #将某个具体的value插入到列表中某个元素的前/后
(integer) 3
127.0.0.1:6379> lrange mylist 0 -1
1) "hello"
2) "old"
3) "world"
127.0.0.1:6379> linsert mylist after world new
(integer) 4
127.0.0.1:6379> lrange mylist 0 -1
1) "hello"
2) "old"
3) "world"
4) "new"

```



#### 3、Set 

set里面的值不能重复, 无序

```bash
#######################################################
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> sadd myset hello 	#往set添加值
(integer) 1
127.0.0.1:6379> sadd myset mr.zhang
(integer) 1
127.0.0.1:6379> sadd myset world
(integer) 1
127.0.0.1:6379> smembers myset	#查看set所有值
1) "world"
2) "hello"
3) "mr.zhang"
127.0.0.1:6379> sismember myset hello #看set里面是否有某个值
(integer) 1
127.0.0.1:6379> sismember myset nihao
(integer) 0
127.0.0.1:6379> scard myset #获取set集合中的元素的个数
(integer) 3
127.0.0.1:6379> srem myset hello #移除set中的某个元素
(integer) 1
127.0.0.1:6379> smembers myset #
1) "world"
2) "mr.zhang"


#######################################################
127.0.0.1:6379> sadd myset hello 
(integer) 1
127.0.0.1:6379> sadd myset hello1 
(integer) 1
127.0.0.1:6379> sadd myset hello2
(integer) 1
127.0.0.1:6379> srandmember myset #随机获取set里面的一个值
"world"
127.0.0.1:6379> srandmember myset
"hello1"
127.0.0.1:6379> srandmember myset
"hello2"
127.0.0.1:6379> srandmember myset 2
1) "world"
2) "hello"
127.0.0.1:6379> srandmember myset 2
1) "mr.zhang"
2) "hello2"


#######################################################
127.0.0.1:6379> spop myset #随机移除set中的一个值
"hello2"
127.0.0.1:6379> smembers myset
1) "mr.zhang"
2) "world"
3) "hello"
4) "hello1"
127.0.0.1:6379> smembers myset
1) "mr.zhang"
2) "world"
3) "hello"
4) "hello1"
127.0.0.1:6379> spop myset
"mr.zhang"
127.0.0.1:6379> smembers myset
1) "world"
2) "hello"
3) "hello1"

#######################################################
移动一个指定的值,到另外一个set集合中
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> sadd myset hello
(integer) 1
127.0.0.1:6379> sadd myset world
(integer) 1
127.0.0.1:6379> sadd myset hello1
(integer) 1
127.0.0.1:6379> sadd myset hello2
(integer) 1
127.0.0.1:6379> smembers
(error) ERR wrong number of arguments for 'smembers' command
127.0.0.1:6379> smembers myset
1) "hello1"
2) "world"
3) "hello"
4) "hello2"
127.0.0.1:6379> sadd myset2 myset2
(integer) 1
127.0.0.1:6379> smove myset myset2 "world" #移动set集合中的某个值到另外一个集合中
(integer) 1
127.0.0.1:6379> smembers myset
1) "hello1"
2) "hello"
3) "hello2"
127.0.0.1:6379> smembers myset2
1) "world"
2) "myset2"

#######################################################
叉集 交集 并集
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> sadd key1 a
(integer) 1
127.0.0.1:6379> sadd key1 a
(integer) 0
127.0.0.1:6379> sadd key1 b
(integer) 1
127.0.0.1:6379> sadd key1 c
(integer) 1
127.0.0.1:6379> sadd key1 d
(integer) 1
127.0.0.1:6379> sadd key2 c 
(integer) 1
127.0.0.1:6379> sadd key2 d
(integer) 1
127.0.0.1:6379> sadd key2 e
(integer) 1
127.0.0.1:6379> sadd key2 f
(integer) 1
127.0.0.1:6379> sdiff key1 key2 #叉集
1) "b"
2) "a"
127.0.0.1:6379> sdiff key2 key1
1) "f"
2) "e"
127.0.0.1:6379> sinter key1 key2 #交集 共同好友就可以这样实现
1) "d"
2) "c"
127.0.0.1:6379> sunion key1 key2 #并集
1) "c"
2) "f"
3) "b"
4) "a"
5) "d"
6) "e"
#######################################################
```



#### 4、Hash

Map集合, key-map 

hash更适合对象的存储

```bash
#######################################################
127.0.0.1:6379> hset myhash field1 zhang #设置一个Key-value
(integer) 1
127.0.0.1:6379> hget myhash field1
"zhang"
127.0.0.1:6379> hmset myhash field1 hello field2 world #设置多个
OK
127.0.0.1:6379> hmget myhash field1 field2 #获取
1) "hello"
2) "world"
127.0.0.1:6379> hgetall myhash
1) "field1"
2) "hello"
3) "field2"
4) "world"
127.0.0.1:6379> hdel myhash field1
(integer) 1
127.0.0.1:6379> hgetall
(error) ERR wrong number of arguments for 'hgetall' command
127.0.0.1:6379> hgetall myhash
1) "field2"
2) "world"
127.0.0.1:6379> hlen myhash
(integer) 1
127.0.0.1:6379> hexists myhash field1
(integer) 0
127.0.0.1:6379> hexists myhash field2
(integer) 1


#######################################################
127.0.0.1:6379> hset myhash field1 hello
(integer) 1
127.0.0.1:6379> hset myhash field3 zhang
(integer) 1
127.0.0.1:6379> hgetall myhash
1) "field2"
2) "world"
3) "field1"
4) "hello"
5) "field3"
6) "zhang"
127.0.0.1:6379> hkeys myhash
1) "field2"
2) "field1"
3) "field3"
127.0.0.1:6379> hvals myhash
1) "world"
2) "hello"
3) "zhang"
127.0.0.1:6379> hset myhash field4 5
(integer) 1
127.0.0.1:6379> hgetall myhash
1) "field2"
2) "world"
3) "field1"
4) "hello"
5) "field3"
6) "zhang"
7) "field4"
8) "5"
127.0.0.1:6379> hincrby myhash field4 1
(integer) 6
127.0.0.1:6379> hincrby myhash field4 -2
(integer) 4
127.0.0.1:6379> hsetnx myhash field5 yi #是否存在
(integer) 1
127.0.0.1:6379> hgetall myhash
 1) "field2"
 2) "world"
 3) "field1"
 4) "hello"
 5) "field3"
 6) "zhang"
 7) "field4"
 8) "4"
 9) "field5"
10) "yi"

#######################################################
127.0.0.1:6379> hmset user:1 name zhang age 18
OK
127.0.0.1:6379> hgetall user:1
1) "name"
2) "zhang"
3) "age"
4) "18"
127.0.0.1:6379> hget user:1 nage
(nil)
127.0.0.1:6379> hget user:1 name
"zhang"
#######################################################
```



#### 5、Zset有序集合

set k1 v1

zset k1 score v1

```bash
#######################################################
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> zadd myset 1 one
(integer) 1
127.0.0.1:6379> zadd myset 2 two 3 three
(integer) 2
127.0.0.1:6379> zrange myset 0 -1
1) "one"
2) "two"
3) "three"
127.0.0.1:6379> zadd salary 2500 xianghong 5000 zhangsan 200 lisi
(integer) 3
127.0.0.1:6379> zrange salary 0 -1
1) "lisi"
2) "xianghong"
3) "zhangsan"
127.0.0.1:6379> zrangebyscore salary -inf +inf
1) "lisi"
2) "xianghong"
3) "zhangsan"
127.0.0.1:6379> zrevrange salary 0 -1
1) "zhangsan"
2) "xianghong"
3) "lisi"
127.0.0.1:6379> zrangebyscore salary -inf +inf withscores
1) "lisi"
2) "200"
3) "xianghong"
4) "2500"
5) "zhangsan"
6) "5000"
127.0.0.1:6379> zrangebyscore salary -inf 2500 withscores
1) "lisi"
2) "200"
3) "xianghong"
4) "2500"

#######################################################
127.0.0.1:6379> zrange salary 0 -1
1) "lisi"
2) "xianghong"
3) "zhangsan"
127.0.0.1:6379> zrange myset 0 -1
1) "one"
2) "two"
3) "three"
127.0.0.1:6379> zrem myset one
(integer) 1
127.0.0.1:6379> zrange myset 0 -1
1) "two"
2) "three"

#######################################################
127.0.0.1:6379> keys *
1) "salary"
2) "myset"
127.0.0.1:6379> zcard salary
(integer) 3
127.0.0.1:6379> zcard myset
(integer) 2

#######################################################
127.0.0.1:6379> zcount myset 1 3
(integer) 2
127.0.0.1:6379> zgetall myset
(error) ERR unknown command 'zgetall'
127.0.0.1:6379> zrange myset 0 -1
1) "two"
2) "three"
127.0.0.1:6379> zadd myset 4 four
(integer) 1
127.0.0.1:6379> zadd myset 5 five
(integer) 1
127.0.0.1:6379> zcount myset 1 4
(integer) 3
#########################################################


```

Zset 比set多了一个排序 存储班级成绩表 工资表排序 带权重执行 Top-N





### 六、三种特殊数据类型

#### 1、geospatial

​	地理位置, 朋友的定位,附近的人,打车距离. Redis3.2版本就推出了. 

​	可以计算两地之间的距离

​	位置信息的底层是现实其实就是Zset.可以使用Zset来操作geo

```bash
#########################################################
#规则:两级无法直接添加 java程序可以通过配置文件一次导入
geoadd china:city 116.40 39.90 beijin #添加城市经纬度 180到-180 85到-85

geopos china:city beijin #获取指定的城市的经纬度

geodist china:city beijin shanghai km #定位距离 单位m km 

georadius chian:city 110 30 1000 km withdist  #附近的人 参数 以某个经纬度为中心 半径 多少

georadiusbymember china:city beijing 1000 km # 找出位于指定元素周围的城市

geohash china:city beijing chongqing # 返回的当前城市的经纬度转换成一维的字符串
```



#### 2、Hyperloglog

​	什么是基数? 不重复的元素. 可以接受误差 

​	Redis 2.8.9版本就更新了Hyperloglog数据结构! 基数统计的算法

​	应用场景: 访问量,一个人访问多次算一次.

​	优点:占用内存是固定的, 2^64不同的元素,只需要12KB内存. 有误差0.81%的误差

```bash
#########################################################
127.0.0.1:6379> Pfadd mykey a b c d e f
(integer) 1
127.0.0.1:6379> pfcount mykey
(integer) 6
127.0.0.1:6379> Pfadd mykey a b c d e f
(integer) 0
127.0.0.1:6379> pfcount mykey
(integer) 6
127.0.0.1:6379> pfadd mykey2 a b c z y z
(integer) 1
127.0.0.1:6379> pfcount mykey2
(integer) 5
127.0.0.1:6379> pfmerge mykey3 mykey mykey2
OK
127.0.0.1:6379> pfcount mykey3
(integer) 8

```



#### 3、Bitmaps

​	位存储 

​	统计用户信息, 活跃/不活跃 、登录/未登录、 打卡/未打卡. 只有两个状态的,都可以使用Bitmaps!

```bash
#########################################################
#周一到周日的打卡情况
127.0.0.1:6379> clear
127.0.0.1:6379> keys * 
(empty list or set)
127.0.0.1:6379> setbit sign 0 1 #设置每一天打卡的情况
(integer) 0
127.0.0.1:6379> setbit sign 1 1 
(integer) 0
127.0.0.1:6379> setbit sign 2 1 
(integer) 0
127.0.0.1:6379> setbit sign 3 1 
(integer) 0
127.0.0.1:6379> setbit sign 4 1 
(integer) 0
127.0.0.1:6379> setbit sign 5 0 
(integer) 0
127.0.0.1:6379> setbit sign 6 0 
(integer) 0
127.0.0.1:6379> getbit sign 5 	#查看某一天的打卡情况
(integer) 0
127.0.0.1:6379> getbit sign 4
(integer) 1
127.0.0.1:6379> bitcount sign 0 6 #统计这一周打卡的情况
(integer) 5


```



### 七、Redis事务

#### 1、什么是事务

	>事务的本质 = 一组命令的集合!

​	==Redis事务没有隔离级别的概念==

​	要么同时成功,要么同时失败, 原子性. 

​	==Redis单条命令是原子性, 事务是没有原子性的==

#### 2、Redis事务开启

- 开启事务 (multi)
- 命令入队 (....)
- 执行事务 (exec)

```bash
###########################################################
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set k1 v1
QUEUED
127.0.0.1:6379> set k2 v2
QUEUED
127.0.0.1:6379> get k2
QUEUED
127.0.0.1:6379> set k3 v3
QUEUED
127.0.0.1:6379> exec
1) OK
2) OK
3) "v2"
4) OK
################################################################
#取消事务
127.0.0.1:6379> multi 
OK
127.0.0.1:6379> set k1 v1
QUEUED
127.0.0.1:6379> set k2 v2 
QUEUED
127.0.0.1:6379> set k4 v4
QUEUED
127.0.0.1:6379> discard
OK
127.0.0.1:6379> get k4
(nil)
127.0.0.1:6379> get k3
"v3"
################################################################
```



#### 4、Redis事务异常

	>编译异常(语法有问题, 命令有问题), 事务中所有的命令都不会被执行

```bash
### 所有的命令都不会执行
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set k1 v1
QUEUED
127.0.0.1:6379> set k2 v2
QUEUED
127.0.0.1:6379> getset k3
(error) ERR wrong number of arguments for 'getset' command
127.0.0.1:6379> set k4 v4
QUEUED
127.0.0.1:6379> exec
(error) EXECABORT Transaction discarded because of previous errors.
127.0.0.1:6379> get k1
(nil)
```



>运行时异常(1/0)  异常的语句不会让它异常,其他的语句还是执行

```bash
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> set k1 v1
OK
127.0.0.1:6379> multi
OK
127.0.0.1:6379> incr k1 #只能对数字进行加减
QUEUED
127.0.0.1:6379> set k2 v2
QUEUED
127.0.0.1:6379> set k3 v3
QUEUED
127.0.0.1:6379> get k3
QUEUED
127.0.0.1:6379> exec
1) (error) ERR value is not an integer or out of range
2) OK
3) OK
4) "v3"

```



### 八、Redis的乐观锁

#### 1、锁

​	==悲观锁==

-  很悲观,认为什么时候都会出问题, 无论做什么都会枷锁! 

​	==乐观锁==

- 很乐观, 认为什么时候都不会出问题,不会上锁!更新数据时去判断一下,在此期间是否有人修改过这个数据
- 获取version
- 更新的时候比较version

#### 2、Redis的watch 

```bash
### 第一个客户端
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> set money 100
OK
127.0.0.1:6379> set out 0
OK
127.0.0.1:6379> watch money 	### 监视money
OK
127.0.0.1:6379> multi
OK
127.0.0.1:6379> decrby money 20
QUEUED
127.0.0.1:6379> incrby out 20
QUEUED
127.0.0.1:6379> exec 	### 在这个区间money没有变化 执行成功
1) (integer) 80
2) (integer) 20


### 第一个客户端
127.0.0.1:6379> watch money
OK
127.0.0.1:6379> multi 
OK
127.0.0.1:6379> decrby money 1
QUEUED
127.0.0.1:6379> incrby out 1 ### 还没有执行的时候 第二个客户端 改变了money
QUEUED
127.0.0.1:6379> exec
(nil)

### 第二个客户端
127.0.0.1:6379> incrby money 10
(integer) 90

```

