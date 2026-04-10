#!/bin/bash
#Đây là file được tạo vào thời gian: Wed Apr  1 08:59:39 UTC 2026 

read -p "Nhập tên file cần xóa: " file

if [ ! -e "$file" ]; then
	echo "Lỗi! File $file không tồn tại!"
elif [ -d "$file" ]; then
	echo "Đây là một thư mục. Tôi sẽ không xóa nó đâu!"
elif [ -f "$file" ]; then
	echo "$file là một tệp tin. Đang tiến hành xóa..."
	rm "$file"
	echo "Đã xóa xong!"
fi
