#!/bin/sh

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
EOF


/root/cloudreve/cloudreve -c /root/cloudreve/conf.ini
