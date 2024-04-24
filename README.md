# zax_autologin-openwrt
ZAXSOFT 石斧软件校园网OpenWrt自动登录脚本

# 使用方法

下载完整源码到/tmp下，运行install.sh


# 校园网多设备检测

[UA3F](https://github.com/SunBK201/UA3F/blob/master/README.md#ua3f)(需搭配ShellClash/OpenClash使用)

[UA2F](https://github.com/Zxilly/UA2F)

注：近日发现仲恺白云校区似乎加强了检测，所有的数据包都会被检测，因而性能不够的路由器可能会导致频繁掉线，请知悉。

这边推荐使用性能大于mt7981(wr30u)的路由器。

# TODO
 - [ ] 完善 Luci 的 Configuration
 - [ ] 简化安装


# 提点思路

 - [x] 可自定义User-Agent ~~需要和防检测软件一起修改~~直接获取ua2f的uci config实现

 - [x] 可实现一台路由器认证为手机   另一台路由器认证为电脑 实现原理同上

~~若还有多余的路由器就可以实现多拨~~ 请使用mwan3进行聚合

# 声明

本脚本并非破解软件，不提供破解功能，无任何入侵和破解行为。

本脚本免费发布并无任何盈利行为，请勿商用。

# 参考项目

[liuzhijie443/xywpojie-zaxsoft](https://github.com/liuzhijie443/xywpojie-zaxsoft) 

[Jin-Cheng-Ming/ZHKU-Connector](https://github.com/Jin-Cheng-Ming/ZHKU-Connector)

[LingMessy/zkNet](https://github.com/LingMessy/zkNet)

# 特别鸣谢
[SunBK201/UA3F](https://github.com/SunBK201/UA3F) -> Luci页面与install参考XD