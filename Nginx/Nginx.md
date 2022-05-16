## Nginx 

### 一、概念

​	Nginx是一个高性能的HTTP和反向代理web服务器. 50000个并发连接数. 



	> 正向代理

​	装在本机 VPN 



> 反向代理 

​	装在服务器 



### 二、安装

​	下载地址: https://nginx.org/en/download.html

```bash
tar -zxvf nginx-1.20.2.tar.gz
./configure
make
make install 

[root@centOS6-01 sbin]# whereis nginx
nginx: /usr/local/nginx

# 开端口 80 
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



### 三、常用命令

```bash
# 进入目录
cd /usr/local/nginx/sbin

./nginx #启动
./nginx -s stop #停止
./nginx -s quit #安全退出
./nginx -s reload #重新加载配置文件
ps aux | grep nginx #查看nginx进程
```



### 四、配置

```bash
################################# 全局配置 ###########################################
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;

###################################### events块 ######################################
events {
    worker_connections  1024;
}

#################################### http块 ########################################
http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;
    
    #### 负载均衡配置
    upstream travel {
    	# 服务器资源
    	server 127.0.0.1:8080 weight=1;
    	server 127.0.0.1:8080 weight=1;
    }
    
    ######################## server块 每个server就相当于一个虚拟主机 ########################
   server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
            #代理 
            proxy_pass http://travel;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}
        
        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}


```



