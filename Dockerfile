FROM debian:latest
MAINTAINER River Riou

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo Asia/Taipei > /etc/timezone

RUN apt-get update --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install curl net-tools


# Few handy utilities which are nice to have
RUN apt-get -y install vim wget unzip --no-install-recommends
#JAVA & git
RUN apt-get -y install default-jdk git --no-install-recommends
#Spigot 無人值守安裝
WORKDIR /data
RUN cd /data
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar ./BuildTools.jar --rev latest
RUN mv /data/spigot-*.jar /data/spigot.jar
RUN apt-get clean
RUN echo "set pastetoggle=<F11> " >> ~/.vimrc

RUN echo 'eula=true' >> /data/eula.txt
EXPOSE  25565
CMD ["/java -Xmx2048M -Xms1024M -jar /data/spigot.jar"]


