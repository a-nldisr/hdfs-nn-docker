# gen core-site.xml
sed s/HOSTNAME/$(ip addr show prod | grep -Po 'inet \K[\d.]+')/ /etc/hadoop/conf/core-site.xml.tmp > /etc/hadoop/conf/core-site.xml
cat /etc/hadoop/conf/core-site.xml

# log dir
mkdir -p /var/log/hadoop
chown -R hdfs:hadoop /var/log/hadoop

# We will implement this in our test environment later, eventually we ansible encrypt the UUID like we did with Ceph
#if [ ! -f /opt/bin/uuid ]; then
#	git pull your bitbucketrepo:/file
#else
#	uuidgen > /opt/bin/uuid
#	git add /opt/bin/uuid
#	git commit -m "Ansible update cluster uuid content"
#	git push
#fi
UUID="13b34e97-c99e-4b48-ac26-81c3397661b5"
#UUID=`cat /opt/bin/management/uuid`

# create and format namenode if doesn't exist
if [ ! -d /hdfs-nn/cdh5/nn/current ]; then
  mkdir -p /hdfs-nn/cdh5/nn
  chown -R hdfs:hadoop /hdfs-nn/cdh5/nn
  chmod 700 /hdfs-nn/cdh5/nn
  sudo -u hdfs hadoop namenode -format -clusterId $UUID # always format with the same cluster id
fi