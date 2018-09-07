先关闭全部的集群
sbin/stop-dfs.sh

journalnode用于同步namenode所有操作
journalnode用于同步两个namenode之间的额操作，并防止脑裂现象。

mkdir /data/hadoop/hdfs/jn
chown hadoop.hadoop /data/hadoop/hdfs/jn

journalnode防止脑裂
nn01 nn02  nn03  nn04 nn05
sbin/hadoop-daemon.sh start journalnode

nn01
hdfs namenode -format
sbin/hadoop-daemon.sh start namenode

nn02
hdfs namenode -bootstrapStandby
hdfs namenode -initializeSharedEdits
sbin/hadoop-daemon.sh start namenode

nn01:50070  --> standby
nn02:50070  --> standby

手动执行将nn01切换成为active 
hdfs haadmin -failover nn02 nn01

hdfs haadmin -transitionToActive --forcemanual nn01

先启动zookeeper集群

使用hadoop自带的工具初始化

nn01 使用hadoop自带的工具初始化zookeeper集群
bin/hdfs zkfc -formatZK

nn01 nn02
 sbin/hadoop-daemon.sh stop namenode
 sbin/hadoop-daemon.sh start namenode

nn01 nn02
启动zkfc  zkfc检测哪台namenode是否宕机
sbin/hadoop-daemon.sh start zkfc
sbin/hadoop-daemon.sh start zkfc

dn01 dn02 dn03
rm -rf /data/hadoop/hdfs/dn/*






















