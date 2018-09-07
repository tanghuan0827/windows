zookeeper如何知道会话过期
zookeeper中都有一个会话session,如果某个机器宕机了，这个会话就会过期

最好是奇数个

useradd zookeeper 
passwd zookeeper

5台机器都装上zookeeper

tar -zxvf zookeeper-3.4.5
cp -r zookeeper-3.4.5 /usr/local/zookeeper
sudo chown -R zookeeper.zookeeper /usr/local/zookeeper
cd /usr/local
ll

配置环境变量
vim /etc/profile
export ZOOKEEPER_HOME=/usr/local/zookeeper
source /etc/profile

su zookeeper
cp zoo_sample.cfg zoo.cfg

mkdir -p /data/zookeeper
chown -R zookeeper.zookeeper /data/zookeeper

zookeeper数据存放的地方
vim conf/zoo.cfg
dataDir=/data/zookeeper

修改zookeeper日志文件的位置
vim bin/zkEnv.sh
ZOO_LOG_DIR="/data/logs/zookeeper"

给文件夹分配正确的权限
mkdir /data/zookeeper
chown -R zookeeper.zookeeper /data/zookeeper
mkdir /data/logs/zookeeper
chown -R zookeeper.zookeeper /data/logs/zookeeper

vim /data/zookeeper/myid
1 2 3 4 5

cat 1 /data/zookeeper/myid

启动zookeeper
bin/zkServer.sh start
bin/zkCli.sh
ls /

bin/zkServer.sh stop

清空日志目录和数据目录
rm -rf /data/logs/zookeeper/*
rm -rf /data/zookeeper/*

vim conf/zoo.cfg
server.1=nn01:2888:3888
server.2=nn02:2888:3888
server.3=dn01:2888:3888
server.4=dn02:2888:3888
server.5=dn03:2888:3888

bin/zkServer.sh start

添加zookeeper到自启动项
chmod +x zookeeper
service zookeeper start
chkconfig zookeeper on






















































































