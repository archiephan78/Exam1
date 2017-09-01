### Chuyển image type qcow2 sang raw, sử dụng QEMU disk image utility. Câu lệnh:
      - qemu-img convert -f qcow2 -O raw image.img image.raw
      
### Giảm dung lượng raw image:
- Ý tưởng: Raw là một bản image chứa chính xác từng sector của 1 phân vùng hay 1 disk nên có thể mount image ra rồi xóa đi những thành phần
không cần thiết rồi dùng dd command chuyển thành image
....
