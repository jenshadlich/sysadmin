#/bin/sh

# check for root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install collectd
apt-get install -y collectd-core

# use tmpfs for rrd files (used by rrdtool plugin)
mount -t tmpfs -o size=16M none /var/lib/collectd/
echo 'tmpfs    /var/lib/collectd/    tmpfs    defaults,size=16M      0       0' >> /etc/fstab

# copy collectd.conf
cp scripts/rpi/templates/collectd.conf /etc/collectd/collectd.conf

# adjust hostname
HOSTNAME="$(hostname)"
sed -i "s/piXX/$HOSTNAME/g" /etc/collectd/collectd.conf
 
# done
service collectd start
