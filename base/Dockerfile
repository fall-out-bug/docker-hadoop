FROM debian:12

RUN echo  "deb http://deb.debian.org/debian unstable main non-free-firmware contrib" >> /etc/apt/sources.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-8-jdk \
      net-tools \
      curl \
      netcat-traditional \
      gnupg \
      libsnappy-dev \
      zip unzip python3\
      procps \
    && rm -rf /var/lib/apt/lists/*
      
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

ENV HADOOP_VERSION=3.2.4
ENV HIVE_VERSION=3.1.3
ENV TEZ_VERSION=0.9.2
ENV SPARK_VERSION=3.5.2
ENV SPARK_URL=https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-without-hadoop.tgz
ENV HIVE_URL=https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV TEZ_URL=https://archive.apache.org/dist/tez/$TEZ_VERSION/apache-tez-$TEZ_VERSION-bin.tar.gz
ENV HADOOP_URL=https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HIVE_HOME=/opt/apache-hive-$HIVE_VERSION-bin
ENV TEZ_HOME=/opt/apache-tez-$TEZ_VERSION-bin

RUN set -x
RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && curl https://dist.apache.org/repos/dist/release/hadoop/common/KEYS | gpg --import && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -zxf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz
RUN curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && curl -fSL "$HIVE_URL.asc" -o /tmp/hive.tar.gz.asc \
    && curl https://archive.apache.org/dist/hive/KEYS | gpg --import && gpg --verify /tmp/hive.tar.gz.asc \
    && tar -zxf /tmp/hive.tar.gz -C /opt/ \
    && rm /tmp/hive.tar.gz 
RUN curl -fSL "$TEZ_URL" -o /tmp/tez.tar.gz \
    && curl -fSL "$TEZ_URL.asc" -o /tmp/tez.tar.gz.asc \
    && curl https://archive.apache.org/dist/tez/KEYS | gpg --import && gpg --verify /tmp/tez.tar.gz.asc \
    && tar -zxf /tmp/tez.tar.gz -C /opt/ \
    && rm /tmp/tez.tar.gz
RUN curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && curl -fSL "$SPARK_URL.asc" -o /tmp/spark.tar.gz.asc \
    && curl https://archive.apache.org/dist/spark/KEYS | gpg --import && gpg --verify /tmp/spark.tar.gz.asc \
    && tar -zxf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz

RUN curl -fSL "https://jdbc.postgresql.org/download/postgresql-42.7.5.jar" -o $HIVE_HOME/lib/postgresql-jdbc.jar \
    && rm $HIVE_HOME/lib/guava-*.jar \
    && rm $TEZ_HOME/lib/guava-*.jar \
    && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $HIVE_HOME/lib/ \
    && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $TEZ_HOME/lib/

RUN ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop
RUN ln -s $HADOOP_HOME /opt/hadoop
RUN ln -s /opt/apache-tez-$TEZ_VERSION-bin /opt/tez
RUN ln -s /opt/apache-hive-$HIVE_VERSION-bin /opt/hive
RUN ln -s /opt/spark-$SPARK_VERSION-bin-without-hadoop /opt/spark

RUN mkdir $HADOOP_HOME/logs

RUN mkdir /hadoop-data

ENV HIVE_EXECUTION_ENGINE=tez
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=$HIVE_HOME/bin:$TEZ_HOME/bin:$HADOOP_HOME/bin/:$PATH

ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/tez-site.xml $TEZ_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
