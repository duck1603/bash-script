#!/bin/bash
#Đây là file được tạo vào thời gian: Fri Apr 10 08:06:51 UTC 2026

# ==========================================================
# Script: Tự động cài đặt CyberPanel (OpenLiteSpeed)
# Hỗ trợ: Ubuntu 20.04+, AlmaLinux 8/9, CentOS 7
# ==========================================================

# 1. Kiểm tra quyền root
if [ "$(id -u)" != "0" ]; then
   echo "Lỗi: Bạn phải chạy script này bằng quyền root!"
   exit 1
fi

echo "-------------------------------------------------------"
echo "Đang kiểm tra môi trường hệ thống cho CyberPanel..."
echo "-------------------------------------------------------"

# 2. Cập nhật hệ thống trước khi cài đặt
echo "Đang cập nhật danh sách gói (update)..."
if [ -f /etc/debian_version ]; then
    apt-get update -y > /dev/null
elif [ -f /etc/redhat-release ]; then
    yum update -y > /dev/null
fi

# 3. Kiểm tra wget (cần thiết để tải bộ cài)
if ! command -v wget &> /dev/null; then
    echo "Đang cài đặt wget..."
    if [ -f /etc/debian_version ]; then
        apt-get install wget -y
    else
        yum install wget -y
    fi
fi

# 4. Gọi lệnh cài đặt chính thức của CyberPanel
# Sử dụng wget -qO- để lấy script và thực thi ngay lập tức
echo "-------------------------------------------------------"
echo "Bắt đầu tải và chạy trình cài đặt CyberPanel..."
echo "-------------------------------------------------------"

sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)

# 5. Kiểm tra trạng thái thoát ($?)
if [ $? -eq 0 ]; then
    echo "-------------------------------------------------------"
    echo "Trình cài đặt đã được khởi động thành công!"
    echo "Vui lòng làm theo hướng dẫn trên màn hình để hoàn tất."
else
    echo "Có lỗi xảy ra trong quá trình tải script cài đặt."
    exit 1
fi