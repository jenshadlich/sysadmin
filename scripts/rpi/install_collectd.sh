#/bin/sh
apt-get install -y collectd-core
mount -t tmpfs -o size=16M none /var/lib/collectd/
echo 'tmpfs    /var/lib/collectd/    tmpfs    defaults,size=16M      0       0' >> /etc/fstab
