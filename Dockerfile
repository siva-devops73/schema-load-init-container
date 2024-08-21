FROM         dokken/centos-stream-8
RUN          cd /etc/yum.repos.d/
RUN          sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN          sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN          yum -y install java
CMD          /bin/bash
RUN          yum install epel-release git -y
COPY         mongo.repo /etc/yum.repos.d/mongo.repo
RUN          yum install mysql mongodb-org-shell -y
COPY         run.sh /run.sh
ENTRYPOINT  [ "bash", "/run.sh" ]