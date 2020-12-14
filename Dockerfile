FROM redis:alpine

RUN wget -qO /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk \
    && apk add --no-cache glibc-2.32-r0.apk \
    && rm -rf glibc-2.32-r0.apk

ADD aria2.conf /root/aria2/aria2.conf
ADD run.sh /root/cloudreve/run.sh

RUN wget -qO cloudreve.tar.gz https://github.com/moeYuiYui/Cloudreve/releases/download/3.1.1/cloudreve_sp_3.1.1_linux_amd64.tar.gz \
	&& tar -zxvf cloudreve.tar.gz -C /root/cloudreve \
	&& chmod +x /root/cloudreve/cloudreve /root/cloudreve/run.sh

RUN apk add --no-cache aria2 \
	&& wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
	&& wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat \
	&& touch /root/aria2/aria2.session /root/aria2/aria2.log

CMD /root/cloudreve/run.sh
