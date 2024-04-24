#!/bin/sh

if [ -f "zax.sh" ]; then
    rm "zax.sh"
    killall zax.sh >/dev/null 2>&1
fi

if ! command -v sudo >/dev/null 2>&1; then
    opkg update >/dev/null 2>&1 && opkg install sudo >/dev/null 2>&1
fi

mv zax.sh /usr/bin/zax.sh
chmod +x /usr/bin/zax.sh

if [ -f "/etc/init.d/zax.service" ]; then
    rm "/etc/init.d/zax.service"
fi
if [ -f "/etc/init.d/zax" ]; then
    rm "/etc/init.d/zax"
fi

mv zax /etc/init.d/zax && chmod +x /etc/init.d/zax
/etc/init.d/zax enable


mv zax.config /etc/config/zax

mkdir -p /usr/lib/lua/luci/model/cbi
mv cbi.lua /usr/lib/lua/luci/model/cbi/zax.lua


mkdir -p /usr/lib/lua/luci/controller
mv controller.lua /usr/lib/lua/luci/controller/zax.lua

chmod +x /etc/config/zax >/dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Install zax net Success."
fi

rm /tmp/luci-modulecache/* >/dev/null 2>&1
rm /tmp/luci-indexcache* >/dev/null 2>&1
service zax reload >/dev/null 2>&1
