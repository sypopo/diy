#/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================

#echo '修改feeds'
#sed -i '1,2s/coolsnowwolf/sypopo/g' ./feeds.conf.default

echo '修改网关地址'
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\nset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#echo '修改机器名称'
#sed -i 's/OpenWrt/OpenWrt-x64/g' package/base-files/files/bin/config_generate

echo '修改banner'
cp -f diy/sypopo/banner package/base-files/files/etc/
date=`date +%m.%d.%Y`
sed -i "s/SyPopo$/SyPopo $date/g" package/base-files/files/etc/banner

echo '添加软件包'
svn co https://github.com/vernesong/OpenClash/branches/master/luci-app-openclash package/luci-app-openclash
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/fw876/helloworld.git package/luci-app-ssr-plus
svn co https://github.com/sypopo/openwrt-package/trunk/lienol/luci-app-passwall/  package/lienol/luci-app-passwall
rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon -b 19.07_stable package/lean/luci-theme-argon

echo '定义默认值'
cat > package/default-settings/files/zzz-default-settings <<-EOF
#!/bin/sh
# set time zone
uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai
uci commit system

# set distfeeds
cp /etc/opkg/distfeeds.conf /etc/opkg/distfeeds.conf_BK
sed -i 's#http://downloads.openwrt.org#http://mirrors.tuna.tsinghua.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '/sypopo/d' /etc/opkg/distfeeds.conf

# set menu
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
   
# set firewall
sed -i '/REDIRECT --to-ports 53/d' /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user

# clear tmp
rm -rf /tmp/luci*
exit 0
EOF

echo '当前路径'
pwd


