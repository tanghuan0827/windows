# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export JAVA_HOME=/usr/local/jdk1.7
export PATH=$PATH:$JAVA_HOME/bin

export HBASE_HOME=/usr/local/hbase
export PATH=$PATH:$HBASE_HOME/bin
