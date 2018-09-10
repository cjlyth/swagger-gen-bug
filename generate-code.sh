#!/usr/bin/env bash

# Clean the output directory
rm -Rf target/

# Download the latest generator from the maven repo
mvn dependency:get \
  -Ddest=./target/dependency/swagger-codegen-cli-2.4.0-SNAPSHOT.jar \
  -Dartifact=io.swagger:swagger-codegen-cli:2.4.0-SNAPSHOT

# Generate sources
java -jar ./target/dependency/swagger-codegen-cli-2.4.0-SNAPSHOT.jar \
   generate \
   -l spring \
   -c spring-boot-config.json \
   -i api.yml \
   -o target/generated-sources/swagger

# Try to compile the generated code
mvn clean package -U -f target/generated-sources/swagger/pom.xml