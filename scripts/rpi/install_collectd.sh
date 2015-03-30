#/bin/sh

# install
apt-get install -y collectd-core

# tmpfs for rrd files
mount -t tmpfs -o size=16M none /var/lib/collectd/
echo 'tmpfs    /var/lib/collectd/    tmpfs    defaults,size=16M      0       0' >> /etc/fstab

# copy collectd.conf
cp scripts/rpi/templates/collectd.conf /etc/collectd/collectd.conf

HOSTNAME="$(hostname)"
sed -i "s/piXX/$HOSTNAME/g" /etc/collectd/collectd.conf
 
# start
service collectd start
