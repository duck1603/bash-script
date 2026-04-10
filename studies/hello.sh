#!/bin/bash
#Đây là file được tạo vào thời gian: Wed Apr  1 09:26:31 UTC 2026 
gio=$(date +%-H)
echo "Bây giờ là $gio giờ"

if (( gio < 12 )); then 
	echo "Chào buổi sáng!"
elif (( gio >= 12 && gio < 18 )); then
	echo "Chào buổi chiều!"
else
	echo "Chào buổi tối!"
fi
