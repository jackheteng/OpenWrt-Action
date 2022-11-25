# uci命令

```bash
# 开机自启
uci set ua2f.enabled.enabled=1
# 自动配置防火墙（默认开启）（建议开启）
uci set ua2f.firewall.handle_fw=1
# 处理 443 端口流量（默认关闭），443 端口出现 http 流量的概率较低
uci set ua2f.firewall.handle_tls=1
# 处理微信的 mmtls（默认开启）（建议开启）
uci set ua2f.firewall.handle_mmtls=1
# 处理内网流量（默认开启），防止在访问内网服务时被检测到。（建议开启）
uci set ua2f.firewall.handle_intranet=1
# 应用uci修改
uci commit ua2f
# 启动ua2f开机自启
service ua2f enable
# 启动ua2f
service ua2f start
```

# 防火墙配置

通过 iptables 修改 TTL 值
```
iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64
```

防时钟偏移检测
```
iptables -t nat -N ntp_force_local
iptables -t nat -I PREROUTING -p udp --dport 123 -j ntp_force_local
iptables -t nat -A ntp_force_local -d 0.0.0.0/8 -j RETURN
iptables -t nat -A ntp_force_local -d 127.0.0.0/8 -j RETURN
iptables -t nat -A ntp_force_local -d 192.168.0.0/16 -j RETURN
iptables -t nat -A ntp_force_local -s 192.168.0.0/16 -j DNAT --to-destination 192.168.1.1
```
# 参考文献
<a href="https://sunbk201public.notion.site/sunbk201public/OpenWrt-f59ae1a76741486092c27bc24dbadc59">详细教程</a><br>
<a href="https://github.com/Zxilly/UA2F">Zxilly/UA2F</a><br>
<a href="https://github.com/P3TERX/Actions-OpenWrt">P3TERX/Actions-OpenWrt</a><br>
