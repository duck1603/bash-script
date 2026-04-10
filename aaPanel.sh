#!/bin/bash
#Đây là file được tạo vào thời gian: Fri Apr 10 06:54:36 UTC 2026 

# ==========================================================
# Script: Tự động cài đặt aaPanel
# Hệ điều hành hỗ trợ: CentOS, Ubuntu, Debian
# ==========================================================

#Kiểm tra quyền root
if [ "$(id -u)" != "0" ]; then
   echo "Lỗi: Bạn phải chạy script này với quyền root (sudo)." 1>&2
   exit 1
fi

echo "-------------------------------------------------------"
echo "Bắt đầu quá trình kiểm tra và cài đặt aaPanel..."
echo "-------------------------------------------------------"

# Xác định hệ điều hành
if [ -f /etc/redhat-release ]; then
    # Hệ điều hành dòng CentOS/RHEL
    echo "Phát hiện: CentOS/RHEL"
    yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    # Hệ điều hành dòng Ubuntu/Debian
    echo "Phát hiện: Ubuntu/Debian"
    apt-get update
    apt-get install -y wget
    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
else
    echo "Lỗi: Hệ điều hành không được hỗ trợ bởi script này."
    exit 1
fi

echo "-------------------------------------------------------"
echo "Quá trình cài đặt đã hoàn tất hoặc đang chờ xác nhận!"
echo "Lưu ý: Hãy lưu lại thông tin đăng nhập (URL, Username, Password)"
echo "hiển thị trên màn hình sau khi script kết thúc."
echo "-------------------------------------------------------"
