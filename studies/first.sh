#!/bin/bash
echo "--- THÔNG TIN HỆ THỐNG ---"
echo "Người dùng hiện tại: $USER"
echo "Thư mục đang đứng: $(pwd)"
echo "Ngày giờ hôm nay: $(date)"

#Nối biến với nhau
echo "--- Nối biến ---"
ho="Nguyễn"
ten="Văn A"
echo "Xin chào anh $ho $ten"

#Tính tổng
echo "--- Tính tổng 2 số ---"
read -p "Nhập số thứ nhất: " a
read -p "Nhập số thứ hai: " b

tong=$((a + b))

echo "Tổng 2 số là: $tong"
