#!/bin/bash

hdfs dfs -mkdir       /tmp
hdfs dfs -mkdir -p    /user/hive/warehouse
hdfs dfs -chmod g+w   /tmp
hdfs dfs -chmod g+w   /user/hive/warehouse
hdfs dfs -mkdir       /apps
hdfs dfs -mkdir       /apps/hive
mkdir /opt/tez_lib
cp /opt/tez/lib/*.jar /opt/tez_lib
cp /opt/hive/lib/*.jar /opt/tez_lib
tar -czvf tez.tar.gz -C /opt/tez_lib .
hdfs dfs -put tez.tar.gz /apps/
hdfs dfs -put /opt/hive/lib/*.jar /apps/hive

if [ ! -f /opt/hive/conf/.metastore_initialized ]; then
echo "Инициализация схемы Hive Metastore..."
/opt/hive/bin/schematool -initSchema -dbType postgres
touch /opt/hive/conf/.metastore_initialized
fi

cd $HIVE_HOME/bin
./hive --service metastore
./hiveserver2 --hiveconf hive.server2.enable.doAs=false