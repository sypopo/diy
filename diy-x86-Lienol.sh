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
cp -f diy/sypopo/lienol/zzz-default-settings package/default-settings/files/
cp -Rf diy/sypopo/files/aria2/* feeds/packages/net/aria2/
git clone https://github.com/vernesong/OpenClash.git && mv OpenClash/luci-app-openclash package/luci-app-openclash
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
#git clone https://github.com/sypopo/helloworld.git package/helloworld
svn checkout https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus  package/lean/luci-app-ssr-plus
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks/  package/lean/microsocks
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2/  package/lean/redsocks2
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/tcpping/  package/lean/tcpping
svn checkout https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev/  package/lean/shadowsocksr-libev
svn checkout https://github.com/sypopo/openwrt-package/trunk/lienol/luci-app-passwall/  package/lienol/luci-app-passwall
mkdir -p package/luci-app-diskman && \
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Makefile -O package/luci-app-diskman/Makefile
mkdir -p package/parted && \
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile

echo '当前路径'
pwd

