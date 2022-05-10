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

```







### 六、三种特殊数据类型



