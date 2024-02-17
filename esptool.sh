#!/bin/bash

PORT_NAME=$1
echo "Uploading..."


APP_PATH="$(dirname $(realpath $0))"
TOOL_PATH="$APP_PATH/tool-esptool"
ESPTOOL_PATH="/home/pi/.local/bin/esptool.py"

BOOT_APP0="$TOOL_PATH/boot_app0.bin"
BOOTLOADER="$TOOL_PATH/bootloader_qio_80m.bin"
DEFAULT_BIN="$TOOL_PATH/default.bin"
FILE_PATH="$TOOL_PATH/magx-eslm-1.0.5-20240117.bin"



ARGUMENTS=(
    "--chip" "esp32" "--baud" "921600" "--port" "$PORT_NAME"
    "--before" "default_reset" "--after" "hard_reset"
    "write_flash" "-z" "--flash_mode" "dio" "--flash_freq" "80m" "--flash_size" "detect"
    "0xe000" "$BOOT_APP0"
    "0x1000" "$BOOTLOADER"
    "0x10000" "$FILE_PATH"
    "0x8000" "$DEFAULT_BIN"
)

"$ESPTOOL_PATH" "${ARGUMENTS[@]}"


if [ $? -eq 0 ]; then
    echo "Upload completed successfully."
else
    echo "Upload failed."
fi
