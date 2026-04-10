#!/bin/bash
read -p "Nhập tên file bash cần tạo: " ten_file

touch "$ten_file"

echo "#!/bin/bash" > "$ten_file"
echo "#Đây là file được tạo vào thời gian: $(date) " >> "$ten_file"

echo "Đã tạo file $ten_file thành công!"

chmod +x "$ten_file"

echo "Đã cấp quyền file bash"

nano "$ten_file"
