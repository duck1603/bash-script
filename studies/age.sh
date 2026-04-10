#!/bin/bash

# 1. Yêu cầu nhập tên
read -p "Nhập tên của bạn: " name

# 2. Yêu cầu nhập tuổi
read -p "Nhập tuổi hiện tại của bạn: " age

# 3. Lấy năm hiện tại từ hệ thống
current_year=$(date +%Y)

# 4. Tính toán
# Số năm còn lại để đến 100 tuổi
years_to_100=$((100 - age))

# Năm sẽ tròn 100 tuổi
year_of_100=$((current_year + years_to_100))

# 5. Hiển thị kết quả
echo "------------------------------------------"
echo "Chào $name!"
if [ $years_to_100 -gt 0 ]; then
    echo "Bạn còn $years_to_100 năm nữa là tròn 100 tuổi."
    echo "Vào năm $year_of_100, bạn sẽ chính thức là một 'bách niên giai lão'!"
elif [ $years_to_100 -eq 0 ]; then
    echo "Chúc mừng! Năm nay bạn vừa tròn 100 tuổi rồi!"
else
    echo "Thật tuyệt vời! Bạn đã vượt qua cột mốc 100 tuổi được $((age - 100)) năm rồi đấy!"
fi
echo "------------------------------------------"