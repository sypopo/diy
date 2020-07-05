#/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================

#echo '修改feeds'
#sed -i '5s/Lienol/sypopo/g' ./feeds.conf.default

echo '修改网关地址'
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#echo '修改机器名称'
#sed -i 's/OpenWrt/OpenWrt-x64/g' package/base-files/files/bin/config_generate

echo '修改banner'
cp -f diy/sypopo/banner package/base-files/files/etc/
date=`date +%m.%d.%Y`
sed -i "s/SyPopo$/SyPopo $date/g" package/base-files/files/etc/banner

echo '添加软件包'
#sed -i 's/0.32.1/0.33.0/g' package/diy/frp/Makefile
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
#git clone https://github.com/sypopo/helloworld.git package/helloworld
svn checkout https://github.com/vernesong/OpenClash/branches/master/luci-app-openclash package/luci-app-openclash
svn checkout https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus  package/lean/luci-app-ssr-plus
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks/  package/lean/microsocks
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2/  package/lean/redsocks2
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/tcpping/  package/lean/tcpping
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev/  package/lean/shadowsocksr-libev
#svn checkout https://github.com/sypopo/openwrt-package/trunk/lienol/luci-app-passwall/  package/lienol/luci-app-passwall
#mkdir -p package/luci-app-diskman && \
#wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Makefile -O package/luci-app-diskman/Makefile
#mkdir -p package/parted && \
#wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile

echo '定义默认值'
cat > package/default-settings/files/zzz-default-settings <<-EOF
#!/bin/sh

touch /etc/crontabs/root

uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon_dark_purple
uci commit luci

uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai
uci commit system

uci set fstab.@global[0].anon_mount=1
uci commit fstab

sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/aria2.lua
sed -i 's/services/nas/g' /usr/lib/lua/luci/view/aria2/overview_status.htm
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/hd_idle.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/samba.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/minidlna.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/transmission.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/mjpg-streamer.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/p910nd.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/usb_printer.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/xunlei.lua
sed -i 's/services/nas/g'  /usr/lib/lua/luci/view/minidlna_status.htm
sed -i 's/\"services\"/\"vpn\"/g' /usr/lib/lua/luci/controller/shadowsocksr.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/checkport.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/refresh.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/server_list.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/status.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/subscribe.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/shadowsocksr/check.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/shadowsocksr/server.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/shadowsocksr/servers.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/shadowsocksr/client-config.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/shadowsocksr/server-config.lua
sed -i 's/\"services\"/\"vpn\"/g' /usr/lib/lua/luci/controller/openclash.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/download_game_rule.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/server_list.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/update.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/status.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/state.htm
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/client.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/config.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/config-subscribe.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/game-rules-manage.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/game-settings.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/groups-config.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/log.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/proxy-provider-config.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/servers.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/servers-config.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/settings.lua

ln -sf /sbin/ip /usr/bin/ip

sed -i '/lienol/d' /etc/opkg/distfeeds.conf
#sed -i 's/downloads.openwrt.org/openwrt.proxy.ustclug.org/g' /etc/opkg/distfeeds.conf
#sed -i 's/http/https/g' /etc/opkg/distfeeds.conf
sed -i "s/# //g" /etc/opkg/distfeeds.conf

#sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

#uci set dhcp.lan.ra='server'
#uci set dhcp.lan.dhcpv6='server'
#uci set dhcp.lan.ra_management='1'
#uci set dhcp.lan.ra_default='1'
uci set dhcp.@dnsmasq[0].localservice=0
uci set dhcp.@dnsmasq[0].nonwildcard=0
uci commit dhcp

#设置网络
#uci set network.wan.proto='pppoe'
#uci set network.wan.username='account'
#uci set network.wan.password='password'
uci set network.wan.ifname='eth3'
uci set network.wan6.ifname='eth3'
uci set network.lan.ipaddr='192.168.2.1'
uci set network.lan.proto='static'
uci set network.lan.type='bridge'
uci set network.lan.ifname='eth0 eth1 eth2'
uci commit network   

sed -i '/REDIRECT --to-ports 53/d' /etc/firewall.user
echo "# iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user
echo "# iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user

sed -i '/option disabled/d' /etc/config/wireless
sed -i '/set wireless.radio${devidx}.disabled/d' /lib/wifi/mac80211.sh
wifi up

sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='SNAPSHOT'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt '" >> /etc/openwrt_release

sed -i '/log-facility/d' /etc/dnsmasq.conf
echo "log-facility=/dev/null" >> /etc/dnsmasq.conf

sed -i 's/LuCI 17.01 Lienol/LuCI 17.01 /g' /usr/lib/lua/luci/version.lua

# 删除状态页不需显示的
mv -f /usr/lib/lua/luci/view/admin_status/index /usr/lib/lua/luci/view/admin_status/index_backup 2>/dev/null

rm -rf /tmp/luci-*

exit 0
EOF

echo '当前路径'
pwd

