#!/bin/bash

isEnabled=$(uci get zax.enabled.anabled)


mac=`ifconfig | grep wan | awk '{ print tolower($5) }'`

status=0
logger -p zax.sh.resatrt "net start:$(date +%F-%T)"

if [isEnabled = 1];then
	# will remove this function next time
	loginaddr=$(uci get zax.main.loginaddr)
	userId=$(uci get zax.main.username)
	passwd=$(uci get zax.main.password)
	zaxbras=$(uci get zax.main.zaxbras)
	retrysec=$(uci get zax.main.retrysec)
	custom_ua=$(uci get ua2f.main.custom_ua)
	while true; do
		ping -c2 -A 119.29.29.29 >/dev/null
		ret=$?
		ping -c2 -A 223.6.6.6 >/dev/null
		ret2=$?
		if [[ ${ret} -eq 0 || ${ret2} -eq 0 ]]; then
			if [ $status -eq 0 ];then
				status=1
				logger -p zax.sh.running "Now running: state 1"
			fi
			continue
		else
			if [ $status -eq 1 ]; then
				status=0
				logger -p zax.sh.running "Now running: state 0"
			fi
			wlanacip=`ifconfig | grep -A1 "wan" | grep 'inet addr' |awk -F ':' '{print $2}'|awk '{print $1}'`
			url="http://${loginaddr}/webauth.do?wlanacip=172.168.1.5&wlanacname=${zaxbras}&wlanuserip=${wlanacip}&mac=${mac}&url=http://1.1.1.1"
			
			curl -fs "${url}" \
				-H 'Content-Type: application/x-www-form-urlencoded' \
				-H 'Origin: ${loginaddr}' \
				-H "Referer: ${url}" \
				-H 'Upgrade-Insecure-Requests: 1' \
				-H 'User-Agent: ${custom_ua}' \
				--data-raw "hostIp=http%3A%2F%2F127.0.0.1%3A8080%2F&loginType=&auth_type=0&isBindMac1=0&pageid=-1&templatetype=1&listbindmac=0&recordmac=1&isRemind=0&loginTimes=&groupId=&distoken=&echostr=&url=http%3A%2F%2F1.1.1.1&isautoauth=&notice_pic_loop1=%2Fportal%2Fuploads%2Fpc%2Fdemo3%2Fimages%2Flogo.jpg&notice_pic_loop2=%2Fportal%2Fuploads%2Fpc%2Fdemo3%2Fimages%2Frrs_bg.jpg&userId=${userId}&passwd=${passwd}&isBindMac=bindmac" \
				--insecure > /dev/null
			logger -p zax.sh.resatrt "net restart:$(date +%F-%T)"
			sleep ${retrysec}
			continue
		fi
		sleep ${retrysec}
		continue
	done
else
	logger -p zax.sh.init "Please enable the zax first!"
fi
