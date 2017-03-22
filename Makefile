URL=http://www.confluent.io
VERSION=3.2.0
LICENSE='The Apache License, Version 2.0'
VENDOR=Confluent
ARCHITECTURE=all
MAINTAINER=jeremy@confluent.io
OUTPUT=target
OUTPUT_EL6=$(OUTPUT)/el6
OUTPUT_EL7=$(OUTPUT)/el7
ITERATION=`date '+%s'`
FPM_RPM_DEFAULT=fpm --iteration $(ITERATION) --input-type dir --output-type rpm --version $(VERSION) --url $(URL) --license $(LICENSE) --vendor $(VENDOR) --architecture $(ARCHITECTURE) --maintainer $(MAINTAINER) --rpm-os linux
RPM_FILENAME=$(VERSION)-$(ITERATION).rpm


DESCRIPTION_SCHEMA_REGISTRY="Confluent Schema Registry Server"
DESCRIPTION_ZOOKEEPER="Apache Zookeeper provided by Confluent."

clean:
	rm -rf $(OUTPUT)
	mkdir -p $(OUTPUT_EL6) $(OUTPUT_EL7)

schema-registry-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir schema-registry/el6/root \
	--name confluent-schema-registry-server \
	--description $(DESCRIPTION_SCHEMA_REGISTRY) \
	--package $(OUTPUT_EL6)/confluent-schema-registry-server_$(RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install schema-registry/scripts/before-install \
	--depends confluent-schema-registry \
	.

schema-registry-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir schema-registry/el7/root \
	--name confluent-schema-registry-server \
	--description $(DESCRIPTION_SCHEMA_REGISTRY) \
	--package $(OUTPUT_EL7)/confluent-schema-registry-server_$(RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install schema-registry/scripts/before-install \
	--depends confluent-schema-registry \
	.

zookeeper-el6: clean
	$(FPM_RPM_DEFAULT) \
	--chdir zookeeper/el6/root \
	--name confluent-zookeeper-server \
	--description $(DESCRIPTION_ZOOKEEPER) \
	--package $(OUTPUT_EL6)/confluent-zookeeper-server_$(RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install zookeeper/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.

zookeeper-el7: clean
	$(FPM_RPM_DEFAULT) \
	--chdir zookeeper/el7/root \
	--name confluent-zookeeper-server \
	--description $(DESCRIPTION_ZOOKEEPER) \
	--package $(OUTPUT_EL7)/confluent-zookeeper-server_$(RPM_FILENAME) \
	--config-files etc/sysconfig \
	--before-install zookeeper/scripts/before-install \
	--depends confluent-kafka-2.11 \
	.


el6: schema-registry-el6 zookeeper-el6
el7: schema-registry-el7 zookeeper-el7
all: el6 el7

