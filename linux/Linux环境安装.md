## 									Linux

### 一、VMware安装

#### 1、VMware-xxx-xxx.exe 点击执行

#### 2、软件更新

​	启动时检查产品更新 [不选]

​	是否愿意向VMware发送反馈 [不选]

#### 3、输入许可证秘钥

​	a, 注册机生产一个

​	b, 各种方式找一个



### 二、Linux系统挂载

#### 1、基本硬件配置

​	点击"文件" --> 新建虚拟机 --> 典型 --> 稍后安装操作系统 --> 选择Linux的版本(centOS) --> 

虚拟机安装位置自己定 --> 磁盘容量 --> 自定义硬件(内存,处理器,) --> 新CD/DVD(使用iso映像文件) -->

网络适配器(NAT模式) --> 完成. 

#### 2、linux系统安装

#####  a, 开启此虚拟机 

#####  b, Install or upgrade an existing system 采用CentOS图形安装程序

#####  c, 跳过检查

##### d, 选择语言环境 [简体中文]

##### e, 选择键盘类型 [美国英语式]

##### f, 选择存储设备 [基本存储设备]

##### g, 格式化硬盘 [是, 忽略所有数据]

##### h, 设置网络 (重中之重)

​	这里暂时没有设置

##### i, 设置时区 [亚洲/上海]

##### j, 设置密码 [至少六位]

##### k, 选择磁盘分区配置 

​	[使用所有空间] 和 [替换现有Linux系统] 首次安装任意选择一个 ---> 将修改写入磁盘

##### l, 选择系统安装类型 [Basic Server]

##### m, 安装

​	开始安装 ---> 重启 ---> 登录 



**注意常用快捷键:** Ctrl+alt 和 Ctrl+G



#### 2.1、网络配置

#### 1、桥接模式

​	同一个网段 占用同一个网段的IP. 在IP不够用的情况下容易造成IP冲突

#### 2、NAT模式

​	相当于使用的是主机IP做的代理, 里面用的Vmnet8是代理路由

​	centOS6用的是 eth0

​	centOS7用的是 eth33 	

​	是可以通过修改配置文件去整, 

​	**/etc/sysconfig/network-scripts/ifcfg-eth0**

```
DEVICE=eth0
TYPE=Ethernet
UUID=d9e88750-f219-4e56-a125-277f432b6905
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME="System eth0"
HWADDR=00:0C:29:71:59:16
PEERDNS=yes
PEERROUTES=yes
```

​	配置完成以后 重启网络命令**systemctl restart network**

#### 	3、仅主机模式

​	独立IP 不能访问



### 三、Xshell安装使用

### 四、Xftp安装使用

### 五、JDK安装

1. 下载jdk  

2. 从windows上传到linux(可以使用FileZilla软件)

3. 检查系统上是否安装了jdk(若安装了就需要先卸载再使用我们自己的)

   ```
   java -version 
   ```

4. 查看出安装的java的软件包

   ```
   rpm -qa | grep java
   ```

5. 卸载linux自带的jdk

   ```
   rpm -e --nodeps java-1.6.0-openjdk-1.6.0.0-1.66.1.13.0.el6.i686
   rpm -e --nodeps java-1.7.0-openjdk-1.7.0.45-2.4.3.3.el6.i686 tzdata-java-2013g-1.el6.noarch
   ```

6. 在 /usr/local 新建一个文件夹 java

   ```
   mkdir /usr/local/java
   ```

7. 移动 jdk-8u171-linux-i586.tar.gz 到 /usr/local/java下

   ```
   mv jdk-8u171-linux-i586.tar.gz /usr/local/java
   ```

8. 进入 /usr/local/java 目录,解压jdk到当前目录

   ```
   cd /usr/local/java 
   tar -zxvf  jdk-8u171-linux-i586.tar.gz
   ```

9. 配置环境变量  

   ```
   vi /etc/profile
      
   #在文件的最后面添加如下代码
   export JAVA_HOME=/usr/local/java/jdk1.8.0_171
   export PATH=$JAVA_HOME/bin:$PATH
   ```

10. 保存退出

11. 重新加载配置文件

   ```
   source /etc/profile
   ```



### 六、MySql安装





​	

