#!/bin/bash

#1. 默认ip
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# 修改密码
# sed -i 's/root::0:0:99999:7:::/root:$1$SOP5eWTA$fJV8ty3QohO0chErhlxCm1:18775:0:99999:7:::/g' package/base-files/files/etc/shadow

# 修改默认主题
sed -i 's/bootstrap/argon/' feeds/luci/collections/luci/Makefile

sed -i "s/hostname='ImmortalWrt'/hostname='Lenovo'/g" package/base-files/files/bin/config_generate

target=$(grep "^CONFIG_TARGET" .config --max-count=1 | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done

# 整理
#rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/themes/luci-theme-argon*
# rm -rf feeds/luci/applications/luci-app-serverchan
# rm -rf feeds/packages/net/adguardhome
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/packages/net/mosdns

# 修改网络
#sed -i 's/eth0/eth0 eth2 eth3/' package/base-files/files/etc/board.d/99-default_network
#sed -i '2i # network config' package/emortal/default-settings/files/99-default-settings
#sed -i "3i uci set network.wan.proto='pppoe'" package/emortal/default-settings/files/99-default-settings
#sed -i "4i uci set network.wan.username='CD0283366379757'" package/emortal/default-settings/files/99-default-settings
#sed -i "5i uci set network.wan.password='19701115'" package/emortal/default-settings/files/99-default-settings
#sed -i "6i uci set network.wan.ifname='eth1'" package/emortal/default-settings/files/99-default-settings
#sed -i "7i uci set network.wan6.ifname='eth1'" package/emortal/default-settings/files/99-default-settings
#sed -i '8i uci commit network' package/emortal/default-settings/files/99-default-settings
