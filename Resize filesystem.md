  Để 1 filesystem có thể đuợc mở rộng đuợc về sau ( khi thêm HDD) thì nên dùng Logical Volume Manager. Phương pháp này cho phép ấn định không gian đĩa cứng thành những logical Volume khiến cho việc thay đổi kích thước trở nên dễ dàng hơn (so với partition).
### Ưu Điểm:
- Có thể gom nhiều đĩa cứng vật lý lại thành một đĩa ảo dung lượng lớn.
- Có thể tạo ra các vùng dung lượng lớn nhỏ tuỳ ý.
- Không để hệ thống bị gián đoạn hoạt động
- Không làm hỏng dịch vụ.
### Nhuợc Điểm:
- Càng gắn nhiều đĩa cứng và thiết lập càng nhiều LVM thì hệ thống khởi động càng lâu.
- Khả năng mất dữ liệu khi một trong số các đĩa cứng vật lý bị hỏng.
- Nếu một trong số các đĩa cứng vật lý trong Volume Group bị hỏng thì sẽ không thể truy cập vào các Logical Volume trong Volume Group đó.

#### có thể dùng kết hợp LVM và RAID để đảm bảo tính an toàn
