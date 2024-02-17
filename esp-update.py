import subprocess
import os
import serial
import serial.tools.list_ports

def find_ch340_ports():
    ports = serial.tools.list_ports.comports()
    ch340_ports = [port.device for port in ports if 'USB Serial' in port.description]
    print(ch340_ports)
    return ch340_ports


def call_upload_script(port):
    script_path = './esptool.sh'  # 替换为你的脚本实际路径
    subprocess.run([script_path, port], check=True)

ch340_ports = find_ch340_ports()
if ch340_ports:
    call_upload_script(ch340_ports[0])  # 传递第一个找到的串口
else:
    print("No CH340 port found.")

