URL=http://www.confluent.io
VERSION?=3.3.0
LICENSE='The Apache License, Version 2.0'
VENDOR=Confluent
ARCHITECTURE=all
MAINTAINER=jeremy@confluent.io
OUTPUT=target
OUTPUT_EL6=$(OUTPUT)/el6
OUTPUT_EL7=$(OUTPUT)/el7
ITERATION?=`date '+%s'`
FPM_RPM_DEFAULT=fpm --input-type dir --output-type rpm --rpm-os linux --rpm-digest sha256 --version $(VERSION) --iteration $(ITERATION) --url $(URL) --license $(LICENSE) --vendor $(VENDOR) --architecture $(ARCHITECTURE) --maintainer $(MAINTAINER)
EL7_RPM_FILENAME=$(VERSION)-$(ITERATION).el7.rpm
EL6_RPM_FILENAME=$(VERSION)-$(ITERATION).el6.rpm

#package descriptions
DESCRIPTION_SCHEMA_REGISTRY="Confluent Schema Registry Server"
DESCRIPTION_ZOOKEEPER="Apache Zookeeper provided by Confluent."
DESCRIPTION_KAFKA="Apache Kafka provided by Confluent."
DESCRIPTION_KAFKA_CONNECT="Apache Kafka provided by Confluent."
DESCRIPTION_CONTROL_CENTER="Confluent Control Center."

clean:
	rm -rf $(OUTPUT)
	mkdir -p $(OUTPUT_EL6) $(OUTPUT_EL7)

schema-registry-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir schema-registry/el6/root \
	--name confluent-schema-registry-server \
	--description $(DESCRIPTION_SCHEMA_REGISTRY) \
	--package $(OUTPUT_EL6)/confluent-schema-registry-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install schema-registry/scripts/before-install \
	--depends confluent-schema-registry \
	.

schema-registry-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir schema-registry/el7/root \
	--name confluent-schema-registry-server \
	--description $(DESCRIPTION_SCHEMA_REGISTRY) \
	--package $(OUTPUT_EL7)/confluent-schema-registry-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install schema-registry/scripts/before-install \
	--depends confluent-schema-registry \
	.

zookeeper-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir zookeeper/el6/root \
	--name confluent-zookeeper-server \
	--description $(DESCRIPTION_ZOOKEEPER) \
	--package $(OUTPUT_EL6)/confluent-zookeeper-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install zookeeper/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.

zookeeper-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir zookeeper/el7/root \
	--name confluent-zookeeper-server \
	--description $(DESCRIPTION_ZOOKEEPER) \
	--package $(OUTPUT_EL7)/confluent-zookeeper-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install zookeeper/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.

kafka-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka/el6/root \
	--name confluent-kafka-server \
	--description $(DESCRIPTION_KAFKA) \
	--package $(OUTPUT_EL6)/confluent-kafka-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.

kafka-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka/el7/root \
	--name confluent-kafka-server \
	--description $(DESCRIPTION_KAFKA) \
	--package $(OUTPUT_EL7)/confluent-kafka-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.

control-center-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir control-center/el6/root \
	--name confluent-control-center-server \
	--description $(DESCRIPTION_CONTROL_CENTER) \
	--package $(OUTPUT_EL6)/confluent-control-center-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install control-center/scripts/before-install \
	--depends confluent-control-center-2.11 \
	.

control-center-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir control-center/el7/root \
	--name confluent-control-center-server \
	--description $(DESCRIPTION_CONTROL_CENTER) \
	--package $(OUTPUT_EL7)/confluent-control-center-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install control-center/scripts/before-install \
	--depends confluent-control-center-2.11 \
	.
	
kafka-connect-standalone-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka-connect-standalone/el6/root \
	--name confluent-kafka-connect-standalone-server \
	--description $(DESCRIPTION_KAFKA_CONNECT) \
	--package $(OUTPUT_EL6)/confluent-kafka-connect-standalone-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka-connect-standalone/scripts/before-install \
	--depends confluent-kafka-connect-standalone-2.11 \
	--depends confluent-kafka-connect-elasticsearch \
	--depends confluent-kafka-connect-hdfs \
	--depends confluent-kafka-connect-jdbc \
	--depends confluent-kafka-connect-replicator \
	--depends confluent-kafka-connect-s3 \
	--depends confluent-kafka-connect-storage-common \
	.

kafka-connect-standalone-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka-connect-standalone/el7/root \
	--name confluent-kafka-connect-standalone-server \
	--description $(DESCRIPTION_KAFKA_CONNECT) \
	--package $(OUTPUT_EL7)/confluent-kafka-connect-standalone-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka-connect-standalone/scripts/before-install \
	--depends confluent-kafka-connect-standalone-2.11 \
	--depends confluent-kafka-connect-elasticsearch \
	--depends confluent-kafka-connect-hdfs \
	--depends confluent-kafka-connect-jdbc \
	--depends confluent-kafka-connect-replicator \
	--depends confluent-kafka-connect-s3 \
	--depends confluent-kafka-connect-storage-common \
	.

kafka-connect-distributed-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka-connect-distributed/el6/root \
	--name confluent-kafka-connect-distributed-server \
	--description $(DESCRIPTION_KAFKA_CONNECT) \
	--package $(OUTPUT_EL6)/confluent-kafka-connect-distributed-server_$(EL6_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka-connect-distributed/scripts/before-install \
	--depends confluent-kafka-connect-distributed-2.11 \
	--depends confluent-kafka-connect-elasticsearch \
	--depends confluent-kafka-connect-hdfs \
	--depends confluent-kafka-connect-jdbc \
	--depends confluent-kafka-connect-replicator \
	--depends confluent-kafka-connect-s3 \
	--depends confluent-kafka-connect-storage-common \
	.

kafka-connect-distributed-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir kafka-connect-distributed/el7/root \
	--name confluent-kafka-connect-distributed-server \
	--description $(DESCRIPTION_KAFKA_CONNECT) \
	--package $(OUTPUT_EL7)/confluent-kafka-connect-distributed-server_$(EL7_RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install kafka-connect-distributed/scripts/before-install \
	--depends confluent-kafka-connect-distributed-2.11 \
	--depends confluent-kafka-connect-elasticsearch \
	--depends confluent-kafka-connect-hdfs \
	--depends confluent-kafka-connect-jdbc \
	--depends confluent-kafka-connect-replicator \
	--depends confluent-kafka-connect-s3 \
	--depends confluent-kafka-connect-storage-common \
	.

el6: schema-registry-el6 zookeeper-el6 kafka-el6 control-center-el6 kafka-connect-standalone-el6 kafka-connect-distributed-el6
el7: schema-registry-el7 zookeeper-el7 kafka-el7 control-center-el7 kafka-connect-standalone-el7 kafka-connect-distributed-el7
all: el6 el7

