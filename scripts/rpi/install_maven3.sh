wget http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz
tar -xzvf apache-maven-3.2.5-bin.tar.gz
sudo mv apache-maven-3.2.5-bin /opt
sudo cp sysadmin/scripts/rpi/templates/maven.sh /etc/profile.d/maven.sh
echo please log off and on; check with 'mvn -version'
