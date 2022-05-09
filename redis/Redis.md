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











### 六、三种特殊数据类型



