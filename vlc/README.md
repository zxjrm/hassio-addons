# Hass.io 附加组件 VLC

在你的hass.io上运行的VLC播放器。

使用Web界面或新的[VLC Telnet组件](https://www.home-assistant.io/components/vlc-telnet/)对其进行控制，并通过HA Automations控制播放器！

将媒体文件放在hass.io的share文件夹中，或从网络位置（包括Internet）播放文件！例如在线广播！

## 安装
1. 请按照本教程中的步骤将此存储库（https://github.com/zxjrm/hassio-addons）添加到hassio安装中。
2. 使用页面右上方的白色箭头刷新加载项.
3. 在列表中搜索“VLC”，然后单击它.
4. 单击安装按钮，然后等待！可能要花几分钟。
5. 为您的vlc配置telnet和Web界面的密码
6. 配置您的音频输出设备。
7. 点击开始！

如果一切正常，您现在可以：
* 使用Web界面，单击“打开Web UI”按钮并使用具有您配置的密码的空白用户来控制播放器。
* 使用telnet界面控制播放器, 您可以使用[VLC Telnet组件](https://www.home-assistant.io/components/vlc-telnet/), 将127.0.0.1（localhost）配置为主机，将4212配置为端口，并配置密码。


## 故障排除
* 确保选择正确的音频输出。如果一开始音频不起作用，请更改配置并重新启动组件。