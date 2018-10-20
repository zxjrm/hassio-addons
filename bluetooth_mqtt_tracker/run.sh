#!/bin/bash
#set -e
OPTIONS="/data/options.json"
SLEEP_NUM=$(jq --raw-output '.sleep_time' ${OPTIONS})
TRY_NUM=$(jq --raw-output '.try_number' ${OPTIONS})
MQTT_ADDR=$(jq --raw-output '.mqtt_address' ${OPTIONS})
MQTT_USER=$(jq --raw-output '.mqtt_user' ${OPTIONS})
MQTT_PWD=$(jq --raw-output '.mqtt_password' ${OPTIONS})
MQTT_PORT=$(jq --raw-output '.mqtt_port' ${OPTIONS})
MQTT_TOPIC=$(jq --raw-output '.mqtt_topic' ${OPTIONS})
BLUE_LISTS=$(jq --raw-output '.blue_list | length' ${OPTIONS})
declare -a DEV_STATUS
#chack
hcitool dev | grep hci
if [[ $? -ne 0 ]]; then
	echo "没有发现蓝牙适配器"
elif [[ ${MQTT_PORT} == "null" ]]; then
	MQTT_PORT=1883
elif [[ ${SLEEP_NUM} == "null" ]]; then
	SLEEP_NUM=5
elif [[ ${TRY_NUM} == "null" ]]; then
	TRY_NUM=1
elif [[ ${MQTT_ADDR} == "null" ]]; then
	echo "请设置MQTT服务器地址,更多请访问 https://github.com/zxjrm/hassio-addons/tree/master/bluetooth_mqtt_tracker"
	exit 1
elif [[ ${MQTT_TOPIC} == "null" ]]; then
	echo "请设置mqtt主题, 更多请访问 https://github.com/zxjrm/hassio-addons/tree/master/bluetooth_mqtt_tracker"
	exit 1
elif [[ ${BLUE_LISTS} == "null" ]]; then
	echo "请设置蓝牙列表, 更多请访问 https://github.com/zxjrm/hassio-addons/tree/master/bluetooth_mqtt_tracker"
	exit 1
fi

function BLUE_SCAN(){
	local BD_NAME
	BD_NAME=$(hcitool name $MAC)
	if [[ ${BD_NAME} == "" ]]; then
		for (( a = 0; a < ${TRY_NUM}; a++ )); do
			BD_NAME=$(hcitool name $MAC)
			if [[ ${BD_NAME} != "" ]]; then
				continue
			fi
		done
		return 1
	else
		return 0
	fi
}

#main
while true; do
	for (( i=0; i < "${BLUE_LISTS}"; i++ ));do
		MAC=$(jq --raw-output ".blue_list[${i}].mac" ${OPTIONS})
		NAME=$(jq --raw-output ".blue_list[${i}].name" ${OPTIONS})
		BLUE_SCAN
		if [[ $? == 1 ]]; then
			STATUS="not_home"
			if [[ "${STATUS}" != "${DEV_STATUS[${i}]}" ]]; then
				DEV_STATUS[${i}]=${STATUS}
				mosquitto_pub -h ${MQTT_ADDR} -u ${MQTT_USER} -P ${MQTT_PWD} -p ${MQTT_PORT} -t "${MQTT_TOPIC}/${NAME}" -m not_home
				echo "${NAME} ${DEV_STATUS[${i}]}"
			fi
		else
			STATUS="home"
			if [[ "${STATUS}" != "${DEV_STATUS[${i}]}" ]]; then
				DEV_STATUS[${i}]=${STATUS}
				mosquitto_pub -h ${MQTT_ADDR} -u ${MQTT_USER} -P ${MQTT_PWD} -p ${MQTT_PORT} -t "${MQTT_TOPIC}/${NAME}" -m home
				echo "${NAME} ${DEV_STATUS[${i}]}"
			fi
		fi
	done
	sleep ${SLEEP_NUM}
done
