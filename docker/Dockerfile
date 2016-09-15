#FROM mesosphere/mesos:0.26.0-0.2.145.ubuntu1404
#trying same version than we installed
FROM mesosphere/mesos:0.28.2-2.0.27.ubuntu1404

ENV ZEPPELIN_VERSION      0.6.1
ENV ZEPPELIN_HOME         /zeppelin
ENV ZEPPELIN_CONF_DIR     $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV ZEPPELIN_PORT         8080

# setup basic packages, including JDK-8
RUN apt-get update && \
    apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && \
    apt-get install --yes \
    openjdk-8-jdk\
    wget \
    curl \
    tar

# TODO add hadoop(client) config, so we can use hdfs-HA URLs
#ENV HADOOP_CONF_DIR /etc/hadoop
#ADD ./conf/hadoop/hdfs-site.xml /etc/hadoop/hdfs-site.xml
#ADD ./conf/hadoop/core-site.xml /etc/hadoop/core-site.xml
##ADD ./conf/hadoop/mesos-site.xml /etc/hadoop/mesos-site.xml

# java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

# spark
ENV SPARK_VERSION 2.0.0-bin-hadoop2.7
ENV BASE_DIR /usr/local/tl
ENV SPARK_HOME /usr/local/tl/spark-2
ENV PATH $PATH:${SPARK_HOME}/bin
RUN mkdir $BASE_DIR
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}.tgz | tar -xz -C $BASE_DIR
RUN cd $BASE_DIR && ln -s spark-${SPARK_VERSION} ${SPARK_HOME}


# zeppelin
#RUN wget http://mirror.serversupportforum.de/apache/zeppelin/zeppelin-$ZEPPELIN_VERSION/zeppelin-$ZEPPELIN_VERSION-bin-all.tgz
#RUN tar xzvf zeppelin-$ZEPPELIN_VERSION-bin-all.tgz
RUN curl -s http://mirror.serversupportforum.de/apache/zeppelin/zeppelin-$ZEPPELIN_VERSION/zeppelin-$ZEPPELIN_VERSION-bin-all.tgz | tar -xz -C /
RUN cd / && ln -s /zeppelin-$ZEPPELIN_VERSION-bin-all $ZEPPELIN_HOME

#WORKDIR /zeppelin-$ZEPPELIN_VERSION-bin-all
WORKDIR $ZEPPELIN_HOME

ADD zeppelin-env.sh conf/zeppelin-env.sh

# add our user and group first to make sure their IDs get assigned consistently
#ENV ZEP_USER  zeppelin
#ENV ZEP_GROUP zeppelin
ENV ZEP_USER  spark
ENV ZEP_GROUP spark

RUN groupadd -r ${ZEP_GROUP} && useradd -r -m -g ${ZEP_GROUP} ${ZEP_USER}
RUN chown -R ${ZEP_USER}:${ZEP_GROUP} /zeppelin-$ZEPPELIN_VERSION-bin-all
#RUN chown -R ${ZEP_USER}:${ZEP_GROUP} /etc/hadoop

USER ${ZEP_USER}

CMD ["bin/zeppelin.sh", "start"]
