FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get install wget -y

# Installing JDK 21.0.1
RUN wget https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-x64_bin.tar.gz
RUN tar -xf openjdk-21.0.1_linux-x64_bin.tar.gz
ENV JAVA_HOME=/jdk-21.0.1
ENV PATH=$PATH:$JAVA_HOME/bin
RUN rm openjdk-21.0.1_linux-x64_bin.tar.gz

# Installing Maven 3.9.6
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
RUN tar -xf apache-maven-3.9.6-bin.tar.gz
ENV M2_HOME=/apache-maven-3.9.6
ENV M2=$M2_HOME/bin
ENV PATH=$PATH:$M2
RUN rm apache-maven-3.9.6-bin.tar.gz

# Add springapp and use it
RUN adduser --disabled-password --gecos "" springapp
USER springapp

# Coping files
WORKDIR /app
COPY . .

# Set permition to execute sh file
USER root
RUN chown springapp:springapp ./app-start.sh
USER springapp

# Configuring app with maven
RUN mvn install

# Running app
RUN chmod +x ./app-start.sh

# Init CMD
CMD ["./app-start.sh"]