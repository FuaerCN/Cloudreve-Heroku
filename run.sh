#!/bin/sh

if [ "$HerokuMysql" = "true" ]
	then
	echo "Heroku Mysql"
	Host=${JAWSDB_URL:42:57}
	Port=${JAWSDB_URL:100:4}
	User=${JAWSDB_URL:8:16}
	Password=${JAWSDB_URL:25:16}
	Name=${JAWSDB_URL##*/}
else  
	echo "Remote MySQL"
	Host=$DB_Host
	Port=$DB_Port
	User=$DB_User
	Password=$DB_Pwd
	Name=$DB_Name
fi

cat <<-EOF > /root/cloudreve/conf.ini
[System]
; 运行模式
Mode = master
; 监听端口
Listen = :${PORT}
; 是否开启 Debug
Debug = false
; Session 密钥, 一般在首次启动时自动生成
SessionSecret = oXIYVNP23Z9cXRCqn8C8z8etztNo5E33Qd6n6q3TFe3Z7aPPSer4nOEmADwljdIh
; Hash 加盐, 一般在首次启动时自动生成
HashIDSalt = 2je20slhtLqQXalz7a0mCA9hU0H88B0D7vy3jiW4Zw97z35VBeglaFuDBEwmNma9

[Redis]
Server = ${REDIS_URL##*@}
Password = ${REDIS_URL:9:65}
DB = 0

[Database]
; 数据库类型，目前支持 sqlite | mysql
Type = mysql
; 数据库地址
Host = $Host
; MySQL 端口
Port = $Port
; 用户名
User = $User
; 密码
Password = $Password
; 数据库名称
Name = $Name
; 数据表前缀
TablePrefix = V3
EOF

trackerlist=`wget -qO- https://trackerslist.com/all.txt |awk NF|sed ":a;N;s/\n/,/g;ta"`
sed -i '$a bt-tracker='${trackerlist} /root/aria2/aria2.conf
nohup aria2c --conf-path=/root/aria2/aria2.conf  &

/root/cloudreve/cloudreve -c /root/cloudreve/conf.ini
