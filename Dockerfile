FROM docker.io/centos
MAINTAINER John Byrd <johnwbyrd@gmail.com>
# Run hdhomerun_dvr on Synology
RUN yum -y install wget
RUN yum -y update
RUN if [ ! -d /hdhomerun ];then mkdir /hdhomerun; fi
RUN if [ ! -d /hdhomerun/video ];then mkdir /hdhomerun/video; fi
RUN if [ ! -d /hdhomerun/etc ];then mkdir /hdhomerun/etc; fi
RUN if [ ! -d /hdhomerun/bin ];then mkdir /hdhomerun/bin; fi
ADD hdhomerun.conf /hdhomerun/etc/
WORKDIR /hdhomerun/bin
ADD hdhomerun_start.sh /hdhomerun/bin/
RUN curl -O -L http://download.silicondust.com/hdhomerun/hdhomerun_record_linux
RUN chmod 755 /hdhomerun/bin
RUN chmod 755 /hdhomerun/etc
RUN chmod 755 /hdhomerun/video
RUN chmod 755 /hdhomerun/bin/*
RUN chmod 744 /hdhomerun/etc/*
EXPOSE 65001
CMD ["/hdhomerun/bin/hdhomerun_start.sh"]

