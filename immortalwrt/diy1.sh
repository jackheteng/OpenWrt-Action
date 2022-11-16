#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
git clone https://github.com/CHN-beta/rkp-ipid package/rkp-ipid
git clone https://github.com/Zxilly/UA2F package/UA2F

# 修改内核
#sed -i 's/PATCHVER:=5.4/PATCHVER:=5.10/g' target/linux/x86/Makefile

# 软件中心istore
#svn co https://github.com/linkease/istore/trunk/luci/luci-app-store package/luci-app-store
# svn co https://github.com/linkease/istore/trunk/luci package/istore
# svn co https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
# rm -rf package/istore/.svn
# sed -i 's/luci-lib-ipkg/luci-base/g' package/istore/luci-app-store/Makefile
# sed -i 's/("iStore"), 31/("应用商店"), 61/g' package/istore/luci-app-store/luasrc/controller/store.lua

# luci-theme-argon改版主题
git clone -b master https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf package/luci-theme-argon/README* package/luci-theme-argon/Screenshots/
sed -i 's/luci-theme-argon-18.06/luci-theme-argon/g' package/luci-theme-argon/Makefile

# luci-theme-opentopd主题
# git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd
# rm -rf package/luci-theme-opentopd/README* package/luci-theme-opentopd/doc/

#新luci-app-passwall
#git clone https://github.com/xiaorouji/openwrt-passwall package/passwall

# ikoolproxy去广告插件
#git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
#rm -rf package/luci-app-ikoolproxy/README*
