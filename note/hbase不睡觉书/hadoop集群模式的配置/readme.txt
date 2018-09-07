在所有namenode节点上 
rm -rf share/doc

scp -r /usr/local/hadoop root@nn02:/usr/local/

chown -R hadoop.hadoop /usr/local/hadoop

在所有的机器 配置hadoop 环境
建立数据目录
mkdir -p /data/hadoop/hdfs/nn
mkdir -p /data/hadoop/hdfs/dn
chown -R hadoop.hadoop /data/hadoop 

建立日志目录
mkdir /data/logs
mkdir /data/logs/hadoop
chown hadoop.hadoop /data/logs/hadoop

vim /usr/local/hadoop/etc/hadoop/core-site.xml 
###################################
fs.defaultFS修改为各自的节点域名 nn01:8020  nn02:8020 dn01:8020  dn02:8020 dn03:8020

hdfs namenode -format

sbin/start-dfs.sh

查看效果 nn01:50070 nn02:50070 dn01:50070 dn02:50070 dn03:50070

sbin/stop-dfs.sh

============================================================
step_2
vim /usr/local/hadoop/etc/hadoop/core-site.xml 
###################################
fs.defaultFS修改为所有的节点域名 nn01:8020

删除 namenode和datanode数据
dn01 dn02 dn03
rm -rf /data/hadoop/hdfs/nn/current

nn01 nn02  dn01 dn02  dn03
 rm -rf /data/hadoop/hdfs/dn/current
 
nn01
hdfs namenode -format
sbin/hadoop-daemon.sh --script hdfs start namenode
jps

dn01 dn02 dn03
sbin/hadoop-daemon.sh --script hdfs start datanode

etc/hadoop 
需要配置
slaves文件
































































