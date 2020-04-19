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
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#echo '修改机器名称'
#sed -i 's/OpenWrt/OpenWrt-x64/g' package/base-files/files/bin/config_generate

echo '修改banner'
cp -f diy/sypopo/banner package/base-files/files/etc/
date=`date +%m.%d.%Y`
sed -i "s/SyPopo$/SyPopo $date/g" package/base-files/files/etc/banner

echo '添加软件包'
git clone https://github.com/vernesong/OpenClash.git && mv OpenClash/luci-app-openclash package/luci-app-openclash
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
rm -Rf feeds/custom/luci/*
cd feeds/custom/luci
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone https://github.com/jerrykuku/luci-theme-argon -b 19.07_stable
svn co https://github.com/apollo-ng/luci-theme-darkmatter/branches/openwrt-19/luci/themes/luci-theme-darkmatter
git clone https://github.com/pymumu/luci-app-smartdns -b lede
git clone https://github.com/lisaac/luci-app-diskman
mkdir parted && cp luci-app-diskman/Parted.Makefile parted/Makefile
git clone https://github.com/tty228/luci-app-serverchan
svn co https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon
svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter && mv -f OpenAppFilter/* ./
svn co https://github.com/jsda/packages2/trunk/ntlf9t/luci-app-advancedsetting
git clone https://github.com/lisaac/luci-app-dockerman
svn co https://github.com/coolsnowwolf/packages/trunk/sound/forked-daapd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-sqm

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-passwall
svn co https://github.com/Lienol/openwrt-package/trunk/package/tcping
git clone https://github.com/pexcn/openwrt-chinadns-ng.git chinadns-ng
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
svn co https://github.com/solidus1983/luci-theme-opentomato/branches/dev-v19.07/luci/themes/luci-theme-opentomato

git clone https://github.com/garypang13/openwrt-adguardhome
git clone https://github.com/garypang13/luci-app-php-kodexplorer
git clone https://github.com/garypang13/luci-app-eqos
cd -
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/package/lean feeds/custom/luci
cp -Rf ../diy/* ./
./scripts/feeds update -a && ./scripts/feeds install -a

echo '配置aria2'
rm -Rf files/usr/share/aria2 && git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
sed -i 's/#rpc-secure/rpc-secure/g' files/usr/share/aria2/aria2.conf
sed -i 's/rpc-secret/#rpc-secret/g' files/usr/share/aria2/aria2.conf
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i 's/extra_setting\"/extra_settings\"/g' feeds/luci/applications/luci-app-aria2/luasrc/model/cbi/aria2/config.lua
sed -i "s/sed '\/^$\/d' \"\$config_file_tmp\" >\"\$config_file\"/cd \/usr\/share\/aria2 \&\& sh .\/tracker.sh\n    cat \/usr\/share\/aria2\/aria2.conf > \"\$config_file\"\n\    echo '' >> \"\$config_file\"\n    sed '\/^$\/d' \"\$config_file_tmp\" >> \"\$config_file\"/g" feeds/packages/net/aria2/files/aria2.init

echo '当前路径'
pwd


