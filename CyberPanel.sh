#!/bin/bash
#Đây là file được tạo vào thời gian: Fri Apr 10 08:06:51 UTC 2026

# ==========================================================
# Script: Tự động cài đặt CyberPanel (OpenLiteSpeed)
# Hỗ trợ: Ubuntu 20.04+, AlmaLinux 8/9, CentOS 7
# ==========================================================
set -e

# 1. Kiểm tra quyền root
if [ "$(id -u)" != "0" ]; then
   echo "Lỗi: Bạn phải chạy script này bằng quyền root!"
   exit 1
fi

echo "-------------------------------------------------------"
echo "Đang kiểm tra môi trường hệ thống cho CyberPanel..."
echo "-------------------------------------------------------"

# 2. Cập nhật hệ thống trước khi cài đặt
if [ -f /etc/debian_version ]; then
    apt-get update -y > /dev/null
elif [ -f /etc/redhat-release ]; then
    if command -v dnf &> /dev/null; then
        dnf update -y > /dev/null
    else
        yum update -y > /dev/null
    fi
fi

# 3. Kiểm tra wget (cần thiết để tải bộ cài)
if ! command -v wget &> /dev/null; then
    echo "Đang cài đặt wget..."
    if [ -f /etc/debian_version ]; then
        apt-get install wget -y
    else
        if command -v dnf &> /dev/null; then
            dnf install wget -y
        else
            yum install wget -y
        fi
    fi
fi

# 4. Tải script
if command -v curl &> /dev/null; then
    curl -o install.sh https://cyberpanel.net/install.sh
elif command -v wget &> /dev/null; then
    wget -O install.sh https://cyberpanel.net/install.sh
else
    echo "Cần curl hoặc wget để tải script"
    exit 1
fi

chmod +x install.sh

# 5. Chạy script
echo "-------------------------------------------------------"
echo "Đang chạy trình cài đặt CyberPanel..."
echo "-------------------------------------------------------"

sh install.sh
