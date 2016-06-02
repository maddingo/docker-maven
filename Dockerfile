FROM ubuntu:xenial

ENV MAVEN_VERSION=3.2.5
ENV MAVEN_SHA1=41009327d5494e0e8970b25b77ffed8934cd7ca1

USER root

# Download and install maven
RUN \
  mkdir -p /usr/share/maven && \
  cd /tmp && \
  curl -O https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  sha1sum apache-maven-$MAVEN_VERSION-bin.tar.gz | grep $MAVEN_SHA1 && \
  tar -xz -f apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/share/maven --strip-components=1 && \
  rm /tmp/apache-maven*

# configure maven
RUN \
  chmod +x /usr/bin/mvn && \
  echo export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 >/etc/mavenrc

# for the time being we use the root user, later the entry point script should take care of this

CMD ["mvn", "-version"]
