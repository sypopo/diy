#/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#echo '修改feeds'
#sed -i '1,2s/coolsnowwolf/sypopo/g' ./feeds.conf.default

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

#echo '取消bootstrap为默认主题'
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

echo '删除默认密码'
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

echo '添加软件包'
git clone https://github.com/vernesong/OpenClash.git && mv OpenClash/luci-app-openclash package/luci-app-openclash
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
#svn checkout https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus  package/lean/luci-app-ssr-plus
#svn checkout https://github.com/sypopo/openwrt-package/trunk/lienol/luci-app-passwall/  package/lienol/luci-app-passwall
#svn checkout https://github.com/sypopo/openwrt-package/trunk/package/tcping/ package/tcping
#svn checkout https://github.com/sypopo/openwrt-package/trunk/package/chinadns-ng/ package/chinadns-ng
#svn checkout https://github.com/sypopo/openwrt-package/trunk/package/brook/ package/brook
git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/lean/luci-theme-opentomato
sed -i "s/LeoJo/SyPopo/g" package/lean/luci-theme-opentomato/luasrc/view/themes/opentomato/footer.htm

echo '当前路径'
pwd


