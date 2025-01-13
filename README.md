# Hadoop Docker

## Quick Start

Для развертывания игрушечного кластера HDFS просто запустите:
```
  docker-compose up
```

Проверочная джоба wordcount:
```
  make wordcount
```

`docker-compose` создает сеть docker network, которую можно посмотреть по команде `docker network list`, например, `dockerhadoop_default`.

Запустите `docker network inspect` на вашей сети (`dockerhadoop_default`), чтобы найти адреса опубликованных интерфейсов hadoop. Доступ будет по следующим адресам:

* Namenode: http://<dockerhadoop_IP_address>:9870/dfshealth.html#tab-overview
* History server: http://<dockerhadoop_IP_address>:8188/applicationhistory
* Datanode: http://<dockerhadoop_IP_address>:9864/
* Nodemanager: http://<dockerhadoop_IP_address>:8042/node
* Resource manager: http://<dockerhadoop_IP_address>:8088/

## Настройка переменных окружения

Все настройки хранятся в файое hadoop.env file в качестве переменных:
```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF соответствует core-site.xml. fs_defaultFS=hdfs://namenode:8020 будет выглядеть:
```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```
Для использования тире в конфигурации используйте тройное нижнее подчеркивание, например YARN_CONF_yarn_log___aggregation___enable=true (yarn-site.xml):
```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

Все доступные конфигурации находятсся по адресам:
* /etc/hadoop/core-site.xml CORE_CONF
* /etc/hadoop/hdfs-site.xml HDFS_CONF
* /etc/hadoop/yarn-site.xml YARN_CONF
* /etc/hadoop/httpfs-site.xml HTTPFS_CONF
* /etc/hadoop/kms-site.xml KMS_CONF
* /etc/hadoop/mapred-site.xml  MAPRED_CONF

Для изменения конфигурации см. скрипт base/entrypoint.sh.
