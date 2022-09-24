# uci命令

```bash
# 开机自启
uci set ua2f.enabled.enabled=1
# 自动配置防火墙（默认开启）（建议开启）
uci set ua2f.firewall.handle_fw=1
# 处理 443 端口流量（默认关闭），443 端口出现 http 流量的概率较低
uci set ua2f.firewall.handle_tls=1
# 处理微信的 mmtls（默认开启）（建议关闭）
uci set ua2f.firewall.handle_mmtls=1
# 处理内网流量（默认开启），防止在访问内网服务时被检测到。（建议开启）
uci set ua2f.firewall.handle_intranet=1
# 应用uci修改
uci commit ua2f

service ua2f enable
service ua2f start
```

# 手动配置
## ipset命令

请确保添加此语句至开机自启
```bash
ipset create nohttp hash:ip,port hashsize 16384 timeout 300
```
`UA2F` 运行时依赖名称为 `nohttp`，类型为 `hash:ip,port` 的 ipset

## 防火墙iptables规则
```shell
iptables -t mangle -N ua2f
iptables -t mangle -A ua2f -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A ua2f -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A ua2f -d 192.168.0.0/16 -j RETURN # 不处理流向保留地址的包
iptables -t mangle -A ua2f -p tcp --dport 443 -j RETURN # 不处理 https
iptables -t mangle -A ua2f -p tcp --dport 22 -j RETURN # 不处理 SSH
iptables -t mangle -A ua2f -p tcp --dport 80 -j CONNMARK --set-mark 44
iptables -t mangle -A ua2f -m connmark --mark 43 -j RETURN # 不处理标记为非 http 的流 (实验性)
iptables -t mangle -A ua2f -m set --set nohttp dst,dst -j RETURN
iptables -t mangle -A ua2f -p tcp --dport 80 -m string --string "/mmtls/" --algo bm -j RETURN # 不处理微信的 mmtls
iptables -t mangle -A ua2f -j NFQUEUE --queue-num 10010
iptables -t mangle -A FORWARD -p tcp -m conntrack --ctdir ORIGINAL -j ua2f
```

<br><a href="http://trac.gateworks.com/wiki/OpenWrt/kernelconfig">参考文献</a><br>
<a href="https://sunbk201public.notion.site/sunbk201public/OpenWrt-f59ae1a76741486092c27bc24dbadc59">详细教程</a><br>
<a href="https://github.com/Zxilly/UA2F">Zxilly/UA2F</a><br>

