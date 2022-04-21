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



### 六、Tomcat安装

1. 下载tomcat

2. 上传到linux

3. 在 /usr/local 新建一个文件夹tomcat

   ```
   mkdir /usr/local/tomcat
   ```

4. 移动 tomcat...tar.gz 到 /usr/local/tomcat

   ```
   mv apache-tomcat-8.5.27.tar.gz /usr/local/tomcat/
   ```

5. 进入/usr/local/tomcat目录,解压Tomcat

   ```
   cd /usr/local/tomcat
   tar -zxvf apache-tomcat-8.5.27.tar.gz
   ```

6. 进入 /usr/local/tomcat/apache-tomcat-8.5.27/bin

   ```
   cd /usr/local/tomcat/apache-tomcat-8.5.27/bin
   ```

7. 启动tomcat(执行startup.sh文件)

   ```
   方式1:
   	sh startup.sh
   方式2:
   	./startup.sh
   ```

8. 修改防火墙的规则

   ```
   方式1:service iptables stop  关闭防火墙（太危险了!!!） 
   方式2:放行8080 端口
   	修改配置文件
   		cd /etc/sysconfig
   		vi iptables
   			复制(yy , p)	
   				-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
   			改成
   				-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
   		重启加载防火墙或者重启防火墙
   			service iptables reload  
   			或者
   			service iptables restart
   ```



### 七、MySql安装

1. 下载mysql

2. 上传到linux  在CRT下,按Alt+P

3. 检查系统上是否安装了mysql( 若安装了就需要先卸载再使用我们自己的)

   ```
   rpm -qa |grep -i mysql                          #查看
   rpm -e --nodeps mysql-libs-5.1.71-1.el6.i686    #卸载
   ```

4. 在 /usr/local 新建一个文件夹mysql

   ```
   mkdir /usr/local/mysql
   ```

5. 把mysql压缩包移动 到/usr/local/mysql

   ```
   mv MySQL-5.6.22-1.el6.i686.rpm-bundle.tar /usr/local/mysql/
   ```

6. 进入 /usr/local/mysql,解包mysql(**不要加Z**)

   ```
   cd /usr/local/mysql
   tar -xvf MySQL-5.5.49-1.linux2.6.i386.rpm-bundle.tar
   ```

7. 安装 服务器端

   ```
   rpm -ivh MySQL-server-5.5.49-1.linux2.6.i386.rpm 
   ```

8. 安装 客户端 

   ```
   rpm -ivh MySQL-client-5.5.49-1.linux2.6.i386.rpm 
   ```

9. 启动Mysql

   ```
   service mysql start  #启动mysql (注意:只启动一次)  
   ```



11. 查看密码:在root目录下 :cat .mysql_secret

    **会生成一个随机密码**

12. 登录mysql **第一次用产生的随机密码登录**

    ```
    mysql -uroot -p密码
    ```

13. 修改密码:set password for root@localhost = password('root'); 

14. 放行3306端口号

   ```
   修改配置文件
      	cd /etc/sysconfig
      	vi iptables
      复制(yy  p)	
      	-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
      改成
      	-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
      重启加载防火墙或者重启防火墙
      	service iptables reload  
      	或者
      	service iptables restart
   ```

15. mysql默认是不允许远程连接的，所以要先设置允许远程连接 mysql

   ```
    在linux上 先登录mysql	
      	cd /usr/local/mysql   #进入mysql目录
      	mysql -uroot -proot    #登录
      创建远程客户
      	create user 'root'@'%' identified by 'root';
      授权
      	grant all on *.* to 'root'@'%' with grant option;
      刷新权限
      	flush privileges;
   ```



### 八、Redis的安装

1. 下载redis(http://redis.io/)

2. 上传到linux

3. 在 usr/local下新建文件夹 redis

   ```
   mkdir /usr/local/redis
   ```

4. 将root下的redis移动到 /usr/local/redis 然后解包

   ```
   mv redis-3.0.7.tar.gz  /usr/local/redis/
   cd /usr/local/redis
   tar -zxvf redis-3.0.7.tar.gz
   ```

5. 安装c语言环境

   ```
   yum install gcc-c++
   // 查看是否已经安装了gcc c++
   whereis gcc 
   whereis g++
   gcc --version
   ```

   **这里有很多问题针对centOS6.7**

   a, yum install gcc-c++ 报错 **YumRepo Error: All mirror URLs are not using ftp, http[s] or file**

   ​	参考https://blog.csdn.net/qq_39946015/article/details/111086184

   ​	主要是修改/etc/yum.repos.d/CentOs-Base.repo 修改前先复制一份

   b, 修改好之后还会报错 **[Errno 14] Peer cert cannot be verified or peer cert invalid**

   ​	修改 /etc/yum.conf文件增加

   ​	sslverify=false

   

6. 编译redis

   ```
   cd /usr/local/redis
   cd redis-3.0.7    进入redis-3.0.7目录
   make   执行make命令即可以编译
   
   // 报错 解决方法
   make MALLOC=libc
   ```

   **会报错**

   ```
   cd src && make all
   make[1]: Entering directory `/usr/local/redis/redis-3.0.7/src'
       CC adlist.o
   在包含自 adlist.c：34 的文件中:
   zmalloc.h:50:31: 错误：jemalloc/jemalloc.h：没有那个文件或目录
   zmalloc.h:55:2: 错误：#error "Newer version of jemalloc required"
   make[1]: *** [adlist.o] 错误 1
   make[1]: Leaving directory `/usr/local/redis/redis-3.0.7/src'
   make: *** [all] 错误 2
   ```

7. 安装redis

   ```
   make PREFIX=/usr/local/redis install
   #安装成功之后 在redis目录下多出来一个bin目录
   ```

#### 4.启动(服务器)

##### 4.1方式一(前台启动,不推荐)

1. 在bin目录,执行 ./redis-server   默认端口号是6379

##### 4.2方式二(后台启动,推荐)

1. 将redis-3.0.7目录下的redis.conf文件复制到 /usr/local/redis/bin 下

   ```
   cp redis.conf /usr/local/redis/bin    #此时 bin目录下会多出一个dump.rdb,相当于redis备份
   ```

2. 修改redis/**bin**目录下的redis.conf 设置为 后台启动

   ```
   vi redis.conf  
   ```

3. 进入到编辑redis.conf文件页面后，在命令模式下输入"/daemonize"表示查找"daemonize"这个关键字

   ```
   /daemonize  
   ```

4. 将 daemonize 值改成yes即可

5. 启动

   ```
   在bin目录中执行   ./redis-server redis.conf
   ```

#### 5.使用redis的客户端连接redis服务器

##### 5.1方式1:默认连接的本机6379端口	

```
./redis-cli
```

##### 5.2方式2:连接指定主机 指定端口号

```
./redis-cli -h 192.168.92.128 -p 6379
```

##### 在其他电脑连接redis服务器

放行6379端口号

* 1.cd /etc/sysconfig
* 2.vi iptables
* 3.修改iptables文件，放行6379端口
* 4.service iptables reload,重启防火墙



#### 6.基本命令  

+ set key value:设置     
+ get key:获取指定的key对应的值
+ del key:删除指定的key
+ ping :测试是否连接成功
+ quit:退出

#### 7.关闭服务

##### 7.1方式一杀死进程(掌握)

```
kill -9  pid


```

##### 7.2方式二使用客户端发送关闭命令(了解)

+ 已经登录客户端,执行

  ```
  shutdown
  
  ```

+ 或者没有登录客户端情况下,执行(不用掌握)

  ```bash
  ./redis-cli -h ip地址  -p 端口号(6379) shutdown
  ```



### 九、Oracle安装

#### 	1、关闭防火墙

操作用户: root

```bash
systemctl stop firewalld.service
systemctl disable firewalld.service
```

#### 2、安装依赖包

操作用户: root

```bash
yum install -y automake autotools-dev binutils bzip2 elfutils expat \
gawk gcc gcc-multilib g++-multilib lib32ncurses5 lib32z1 \
ksh less lib32z1 libaio1 libaio-dev libc6-dev libc6-dev-i386 \
libc6-i386 libelf-dev libltdl-dev libodbcinstq4-1 libodbcinstq4-1:i386 \
libpth-dev libpthread-stubs0-dev libstdc++5 make openssh-server rlwrap \
rpm sysstat unixodbc unixodbc-dev unzip x11-utils zlibc unzip cifs-utils \
libXext.x86_64  glibc.i686
```

如果报错执行这个安装依赖包

```
yum install -y automake autotools-dev binutils bzip2 elfutils expat \
gawk gcc gcc-multilib g++-multilib lib32ncurses5 lib32z1 \
ksh less lib32z1 libaio1 libaio-dev libc6-dev libc6-dev-i386 \
libc6-i386 libelf-dev libltdl-dev libodbcinstq4-1 libodbcinstq4-1:i386 \
libpth-dev libpthread-stubs0-dev libstdc++5 make openssh-server rlwrap \
rpm sysstat unixodbc unixodbc-dev unzip x11-utils zlibc unzip cifs-utils \
libXext.x86_64  glibc.i686
```

#### 3、创建Oracle用户

操作用户: root

```bash
groupadd -g 502 oinstall
groupadd -g 503 dba
groupadd -g 504 oper
groupadd -g 505 asmadmin
useradd -u 502 -g oinstall -G oinstall,dba,asmadmin,oper -s /bin/bash -m oracle
passwd oracle
```

 上述命令执行完毕后，为oracle用户设置密码，例如，我这里设置的密码为oracle 

#### 4、解压Oracle数据库安装包

 操作用户：oracle
操作目录：/home/oracle 

```
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip
```

#### 5、修改操作系统配置

 操作用户：root
操作文件：/etc/security/limits.conf 

```bash
vim /etc/security/limits.conf
```

在文件末尾添加如下配置:

```bash
oracle          soft      nproc   2047
oracle          hard      nproc   16384
oracle          soft      nofile  1024
oracle          hard      nofile  65536
oracle          soft      stack   10240
```

#### 6、创建Oracle安装目录

 操作用户：oracle 

```bash
mkdir ~/tools/oracle11g
```

#### 7、修改环境变量

 操作用户：oracle
操作目录：/home/oracle 

```
vim ~/.bash_profile
```

 在文件末尾添加如下配置项 

```bash
export ORACLE_BASE=/home/oracle/tools/oracle11g
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
export ORACLE_UNQNAME=orcl
export NLS_LANG=.AL32UTF8
export PATH=${PATH}:${ORACLE_HOME}/bin/:$ORACLE_HOME/lib64
```

 使得环境变量生效

```bash
source ~/.bash_profile
```

#### 8、修改Oracle配置文件

操作用户：oracle
操作目录：/home/oracle

复制文件模板

```bash
cp /home/oracle/database/response/db_install.rsp .
```

**注意：复制命令的最后一个 . 不能省略，表示将db_install.rsp文件从/home/oracle/database/response目录拷贝到当前目录。**

对db_install.rsp文件进行编辑。

 需要修改的配置项如下所示，这里，我将修改后的配置项列举出来

```bash
oracle.install.option=INSTALL_DB_AND_CONFIG
ORACLE_HOSTNAME=localhost #实际上可以修改成你自己的主机名或者域名(IP)
UNIX_GROUP_NAME=oinstall
INVENTORY_LOCATION=/home/oracle/tools/oraInventory
SELECTED_LANGUAGES=en,zh_CN
ORACLE_HOME=/home/oracle/tools/oracle11g/product/11.2.0/dbhome_1
ORACLE_BASE=/home/oracle/tools/oracle11g
oracle.install.db.InstallEdition=EE
oracle.install.db.DBA_GROUP=dba
oracle.install.db.OPER_GROUP=oper
oracle.install.db.config.starterdb.type=GENERAL_PURPOSE
oracle.install.db.config.starterdb.globalDBName=orcl
oracle.install.db.config.starterdb.SID=orcl
oracle.install.db.config.starterdb.characterSet=AL32UTF8
oracle.install.db.config.starterdb.memoryOption=true
oracle.install.db.config.starterdb.memoryLimit=1024
oracle.install.db.config.starterdb.installExampleSchemas=false
oracle.install.db.config.starterdb.password.ALL=Oracle#123456
oracle.install.db.config.starterdb.control=DB_CONTROL
oracle.install.db.config.starterdb.dbcontrol.enableEmailNotification=false
oracle.install.db.config.starterdb.dbcontrol.emailAddress=test@qq.com #可以填写你自己的邮箱地址
oracle.install.db.config.starterdb.automatedBackup.enable=false
oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE
oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/home/oracle/tools/oracle11g/oradata
oracle.install.db.config.starterdb.fileSystemStorage.recoveryLocation=/home/oracle/tools/oracle11g/fast_recovery_area
oracle.install.db.config.starterdb.automatedBackup.enable=false
DECLINE_SECURITY_UPDATES=true

```

#### 9、静默安装Oracle 11gR2

 操作用户：oracle
操作目录：/home/oracle/database 

```bash
./runInstaller -silent -ignoreSysPrereqs -responseFile /home/oracle/db_install.rsp
```

 接下来，就是默默的等待Oracle自行安装了，等待一段时间后，如果输出如下信息，则表明Oracle数据库已经安装成功。 

```bash
The following configuration scripts need to be executed as the "root" user.
#!/bin/sh
#Root scripts to run

/home/oracle/tools/oraInventory/orainstRoot.sh
/home/oracle/tools/oracle11g/product/11.2.0/dbhome_1/root.sh
To execute the configuration scripts:

        1. Open a terminal window
         2. Log in as "root"
         3. Run the scripts
         4. Return to this window and hit "Enter" key to continue

Successfully Setup Software.
```



#### 10、