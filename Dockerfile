FROM openjdk:11
RUN apt-get update
RUN apt-get install -y curl gnupg

# FROM documenation: https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update
RUN apt-get install -y sbt
RUN mkdir /workdir
WORKDIR /workdir
RUN git clone https://github.com/rtyley/bfg-repo-cleaner.git
WORKDIR /workdir/bfg-repo-cleaner
RUN sbt bfg/assembly

FROM openjdk:11
RUN mkdir /bfg && mkdir /workdir
COPY --from=0 /workdir/bfg-repo-cleaner/bfg/target/*.jar /bfg/bfg.jar
WORKDIR /workdir
ENTRYPOINT ["java", "-jar", "/bfg/bfg.jar"]
