# bluetooth_mqtt_tracker

利用 Linux 蓝牙工具 `hcitool name $MAC` 方法来鉴别设备是否在蓝牙覆盖范围内

## 使用方法

### 1.修改 options

{
  "sleep_time":"2",
  "try_number":"1",
  "mqtt_address":"192.168.100.100",
  "mqtt_user":"username",
  "mqtt_password":"password",
  "mqtt_port":"1883",
  "mqtt_topic":"/bt/tracker",
  "blue_list":[
      {
        "name":"a",
        "mac": "01:23:45:67:89:AB"
      },
      {
        "name":"b",
        "mac": "01:23:45:67:89:AB"
      }
    ]
}
```
**配置列表**

| 选项 | 必须 | 说明 | 例子 |
|---|---|---|---|
| sleep_time | × | 扫描间隔，默认 5 秒 | 2 |
| try_number | × | 未检测到设备循环次数 | 1 |
| mqtt_address | √ | MQTT 地址 | 192.168.1.1 |
| mqtt_user | √ | MQTT 用户名 | username |
| mqtt_password | √ | MQTT 密码 | password |
| mqtt_port | × | MQTT 服务监听端口默认:1883 | 1883 |
| mqtt_topic | √ | MQTT 主题，与 Home Assistant 配置配合使用 | /ble/tracker |
| blue_list | √ | 设备蓝牙mac列表 | 见下方 |
| name | √ | 设备在 Home Assistant 配置使用的名字 | tom |
| mac | √ | 设备的蓝牙 MAC 地址 | 01:23:45:67:89:AB |

### 2.编写 Home Assistant 传感器配置

```
device_tracker:
  - platform: mqtt
    devices:
      a: '/bt/tracker/a'
      b: '/bt/tracker/b'
    qos: 0

group:
  family_member:
    view: yes
    name: "家庭成员"
    entities:
      - device_tracker.a
      - device_tracker.b
```
注意事项：
devices下面填写的是 hass实体名字:'mqtt主题/blue_list里面的name'

**Enjoy**
