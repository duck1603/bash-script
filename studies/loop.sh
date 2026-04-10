#!/bin/bash
#Đây là file được tạo vào thời gian: Wed Apr  1 09:48:21 UTC 2026 
read -p "Nhập tên môn học: " mon_hoc
read -p "Nhập số lượng bài tập: " so_luong

mkdir -p "$mon_hoc"

for i in $(seq 1 $so_luong); do
	thu_muc_con="$mon_hoc/Lab_$i"
	mkdir -p "$thu_muc_con"

	echo "#Bài tập thực hành số $i" > "$thu_muc_con/README.md"

	echo "--- Đã tạo xong $thu_muc_con và file README.md"
done

