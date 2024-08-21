FROM         dokken/centos-8
RUN          cd /etc/yum.repos.d/
RUN          sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN          sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN          sudo yum update -y
RUN          sudo yum install epel-release -y
COPY         mongo.repo /etc/yum.repos.d/mongo.repo
RUN          yum install mqsql mongodb-org-shell -y
COPY         run.sh /run.sh
ENTRYPOINT   [ "bash", "/run.sh" ]