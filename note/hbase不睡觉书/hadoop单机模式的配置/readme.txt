mkdir -p /data/hadoop/hdfs/nn
mkdir -p /data/hadoop/hdfs/dn
chown -R hadoop.hadoop /data/hadoop 

hdfs namenode -format

sbin/start-dfs.sh
sbin/stop-dfs.sh

tail -200f hadoop-hadoop-namenode-nn01.log 
