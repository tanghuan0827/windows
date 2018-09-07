hbase的单机模式

请先关闭zookeeper
hbase有自己的zookeeper

hbase中有一个master用于管理元数据
regionserver用于存储数据
zookeeper负责维护hbase的所有节点

建立hbase用户 hbase h

vim ~/.bashrc

cp -r hbase-1.2.6.1 /usr/local/hbase
chown -R hbase.hbase /usr/local/hbase

bin/start-hbase.sh

bin/hbase shell
create 'testTable', 'testFamily'
put 'testTable','row1','testFamily:name','jack'
scan 'testTable'

bin/stop-hbase.sh 

vim conf/hbase-site.xml
删除刚刚单机模式产生的hbase的数据
rm -rf /home/hbase/hbase /home/hbase/zookeeper 




























































































