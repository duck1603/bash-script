#!/bin/bash
#Đây là file được tạo vào thời gian: Wed Apr  1 09:58:34 UTC 2026 
while true
do
	echo "===== MENU ====="
	echo "1. Nhập tên và in lời chào"
    	echo "2. Cộng 2 số"
    	echo "3. Kiểm tra chẵn/lẻ"
    	echo "4. Kiểm tra file tồn tại"
    	echo "5. Đếm số file trong thư mục"
    	echo "6. Thoát"

	read -p "Nhập số: " choice

if [ "$choice" -eq 1 ]; then
	read -p "Nhập tên: " name
	echo "Xin chào: $name"

elif [ "$choice" -eq 2 ]; then
	read -p "Nhập số thứ nhất: " a
	read -p "Nhập số thứ hai: " b
	sum=$((a + b))

	echo "Tổng của 2 số là: $sum"

elif [ "$choice" -eq 3 ]; then
	read -p "Nhập số: " num
	if (( num % 2 == 0 )); then
		echo "Số chẵn"
	else
		echo "Số lẻ"
	fi

elif [ "$choice" -eq 4 ]; then
	read -p "Nhập tên file: " file
	if [ ! -e "$file" ]; then
		echo "File không tồn tại"
	elif [ -d "$file" ]; then
		echo "Đây là thư mục"
	elif [ -f "$file" ]; then
		echo "Tìm thấy file $file"
	fi

elif [ "$choice" -eq 6 ]; then
	echo "Thoát khỏi chương trình"
	break

else
	echo "Lựa chọn không hợp lệ!"
fi

	echo ""
done
