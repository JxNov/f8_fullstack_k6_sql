CREATE DATABASE database_03_nguyenmanhdung;

-- Tạo bảng khach_hang
CREATE SEQUENCE IF NOT EXISTS ma_khach_hang_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS khach_hang (
    ma_khach_hang CHARACTER VARYING(30) DEFAULT ('KH' || LPAD(nextval('ma_khach_hang_seq')::TEXT, 4, '0')) PRIMARY KEY,
    ten_khach_hang CHARACTER VARYING(30) NOT NULL,
    dia_chi CHARACTER VARYING(255) NOT NULL,
    so_dien_thoai NUMERIC(10) NOT NULL
);
DROP SEQUENCE IF EXISTS ma_khach_hang_seq;
DROP TABLE IF EXISTS khach_hang;

-- Tạo bảng phong
CREATE SEQUENCE IF NOT EXISTS ma_phong_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS phong (
    ma_phong CHARACTER VARYING(30) DEFAULT ('P' || LPAD(nextval('ma_phong_seq')::TEXT, 4, '0')) PRIMARY KEY,
    loai_phong CHARACTER VARYING(30) NOT NULL,
    so_khach_toi_da INT NOT NULL,
    gia_phong INT NOT NULL,
    mo_ta CHARACTER VARYING(255)
);
DROP SEQUENCE IF EXISTS ma_phong_seq;
DROP TABLE IF EXISTS phong;

-- Tạo bảng dat_phong
CREATE SEQUENCE IF NOT EXISTS ma_dat_phong_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS dat_phong (
    ma_dat_phong CHARACTER VARYING(30) DEFAULT ('DP' || LPAD(nextval('ma_dat_phong_seq')::TEXT, 4, '0')) PRIMARY KEY,
    ma_phong CHARACTER VARYING(30) NOT NULL,
    ma_khach_hang CHARACTER VARYING(30) NOT NULL,
    ngay_dat DATE NOT NULL,
    gio_bat_dau TIME NOT NULL,
    gio_ket_thuc TIME NOT NULL,
    tien_dat_coc INT NOT NULL,
    ghi_chu CHARACTER VARYING(255),
    trang_thai_dat CHARACTER VARYING(30) NOT NULL,
    FOREIGN KEY (ma_phong) REFERENCES phong(ma_phong) ON DELETE CASCADE,
    FOREIGN KEY (ma_khach_hang) REFERENCES khach_hang(ma_khach_hang) ON DELETE CASCADE
);
DROP SEQUENCE IF EXISTS ma_dat_phong_seq;
DROP TABLE IF EXISTS dat_phong;

-- Tạo bảng dich_vu_di_kem
CREATE SEQUENCE IF NOT EXISTS ma_dich_vu_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS dich_vu_di_kem (
    ma_dich_vu CHARACTER VARYING(30) DEFAULT ('DV' || LPAD(nextval('ma_dich_vu_seq')::TEXT, 4, '0')) PRIMARY KEY,
    ten_dich_vu CHARACTER VARYING(30) NOT NULL,
    don_vi_tinh CHARACTER VARYING(30) NOT NULL,
    don_gia INT NOT NULL
);
DROP SEQUENCE IF EXISTS ma_dich_vu_seq;
DROP TABLE IF EXISTS dich_vu_di_kem;

-- Tạo bảng chi_tiet_su_dung_dich_vu
CREATE TABLE IF NOT EXISTS chi_tiet_su_dung_dich_vu (
    ma_dat_phong CHARACTER VARYING(30) NOT NULL,
    ma_dich_vu CHARACTER VARYING(30) NOT NULL,
    so_luong INT NOT NULL,
    FOREIGN KEY (ma_dat_phong) REFERENCES dat_phong(ma_dat_phong) ON DELETE CASCADE,
    FOREIGN KEY (ma_dich_vu) REFERENCES dich_vu_di_kem(ma_dich_vu) ON DELETE CASCADE
);
DROP TABLE IF EXISTS chi_tiet_su_dung_dich_vu;

-- Thêm dữ liệu vào bảng khach_hang
INSERT INTO khach_hang (ten_khach_hang, dia_chi, so_dien_thoai) VALUES ('Nguyen Van A', 'Hoa xuan', 1111111111);
INSERT INTO khach_hang (ten_khach_hang, dia_chi, so_dien_thoai) VALUES ('Nguyen Van B', 'Hoa hai', 1111111112);
INSERT INTO khach_hang (ten_khach_hang, dia_chi, so_dien_thoai) VALUES ('Phan Van A', 'Cam le', 1111111113);
INSERT INTO khach_hang (ten_khach_hang, dia_chi, so_dien_thoai) VALUES ('Phan Van B', 'Hoa xuan', 1111111114);

-- Thêm dữ liệu vào bảng phong
INSERT INTO phong (loai_phong, so_khach_toi_da, gia_phong) VALUES ('Loai 1', 20, 60000);
INSERT INTO phong (loai_phong, so_khach_toi_da, gia_phong) VALUES ('Loai 1', 25, 80000);
INSERT INTO phong (loai_phong, so_khach_toi_da, gia_phong) VALUES ('Loai 2', 15, 50000);
INSERT INTO phong (loai_phong, so_khach_toi_da, gia_phong) VALUES ('Loai 3', 20, 50000);

-- Thêm dữ liệu vào bảng dat_phong
INSERT INTO dat_phong (ma_phong, ma_khach_hang, ngay_dat, gio_bat_dau, gio_ket_thuc, tien_dat_coc, trang_thai_dat)
VALUES ('P0001', 'KH0002', '2018-03-26', '11:00', '13:30', 100000, 'Da dat');
INSERT INTO dat_phong (ma_phong, ma_khach_hang, ngay_dat, gio_bat_dau, gio_ket_thuc, tien_dat_coc, trang_thai_dat)
VALUES ('P0001', 'KH0003', '2018-03-27', '17:15', '19:15', 50000, 'Da huy');
INSERT INTO dat_phong (ma_phong, ma_khach_hang, ngay_dat, gio_bat_dau, gio_ket_thuc, tien_dat_coc, trang_thai_dat)
VALUES ('P0002', 'KH0002', '2018-03-26', '20:30', '22:15', 100000, 'Da dat');
INSERT INTO dat_phong (ma_phong, ma_khach_hang, ngay_dat, gio_bat_dau, gio_ket_thuc, tien_dat_coc, trang_thai_dat)
VALUES ('P0003', 'KH0001', '2018-04-01', '19:30', '21:15', 200000, 'Da dat');

-- Thêm dữ liệu vào bảng dich_vu_di_kem
INSERT INTO dich_vu_di_kem (ten_dich_vu, don_vi_tinh, don_gia) VALUES ('Beer', 'lon', 10000);
INSERT INTO dich_vu_di_kem (ten_dich_vu, don_vi_tinh, don_gia) VALUES ('Nuoc ngot', 'lon', 8000);
INSERT INTO dich_vu_di_kem (ten_dich_vu, don_vi_tinh, don_gia) VALUES ('Trai cay', 'dia', 35000);
INSERT INTO dich_vu_di_kem (ten_dich_vu, don_vi_tinh, don_gia) VALUES ('Khan uot', 'cai', 2000);

-- Thêm dữ liệu vào bảng chi_tiet_su_dung_dich_vu
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0001', 'DV0001', 20);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0001', 'DV0003', 3);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0001', 'DV0002', 10);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0002', 'DV0002', 10);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0002', 'DV0003', 1);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0003', 'DV0003', 2);
INSERT INTO chi_tiet_su_dung_dich_vu (ma_dat_phong, ma_dich_vu, so_luong) VALUES ('DP0003', 'DV0004', 10);

-- Câu 1: Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH, NgayDat, TongTienHat, TongTienSuDungDichVu, TongTienThanhToan tương ứng với từng mã đặt phòng có trong bảng DAT_PHONG.
-- Những đơn đặt phòng nào không sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin của đơn đặt phòng đó ra
-- TongTienHat = GiaPhong * (GioKetThuc – GioBatDau)
-- TongTienSuDungDichVu = SoLuong * DonGia
-- TongTienThanhToan = TongTienHat + sum (TongTienSuDungDichVu)
SELECT dat_phong.ma_dat_phong, phong.ma_phong, phong.loai_phong, phong.gia_phong, khach_hang.ten_khach_hang, dat_phong.ngay_dat,
    phong.gia_phong * (EXTRACT(EPOCH FROM dat_phong.gio_ket_thuc - dat_phong.gio_bat_dau) / 3600) AS tong_tien_hat,
    COALESCE(SUM(chi_tiet_su_dung_dich_vu.so_luong * dich_vu_di_kem.don_gia), 0) AS tong_tien_su_dung_dich_vu,
    phong.gia_phong * (EXTRACT(EPOCH FROM dat_phong.gio_ket_thuc - dat_phong.gio_bat_dau) / 3600) + COALESCE(SUM(chi_tiet_su_dung_dich_vu.so_luong * dich_vu_di_kem.don_gia), 0) AS tong_tien_thanh_toan
FROM dat_phong
JOIN phong ON dat_phong.ma_phong = phong.ma_phong
JOIN khach_hang ON dat_phong.ma_khach_hang = khach_hang.ma_khach_hang
LEFT JOIN chi_tiet_su_dung_dich_vu ON dat_phong.ma_dat_phong = chi_tiet_su_dung_dich_vu.ma_dat_phong
LEFT JOIN dich_vu_di_kem ON chi_tiet_su_dung_dich_vu.ma_dich_vu = dich_vu_di_kem.ma_dich_vu
GROUP BY dat_phong.ma_dat_phong, phong.ma_phong, phong.loai_phong, phong.gia_phong, khach_hang.ten_khach_hang, dat_phong.ngay_dat, dat_phong.tien_dat_coc
ORDER BY dat_phong.ma_dat_phong;
-- Giải thích:
-- Để tính tổng tiền hát, ta sử dụng công thức: GiaPhong * (GioKetThuc – GioBatDau) (đơn vị giờ) và chia cho 3600 để đổi ra giờ (vì EXTRACT(EPOCH FROM ...) trả về số giây)
-- Để tính tổng tiền sử dụng dịch vụ, ta sử dụng công thức: SoLuong * DonGia và sử dụng COALESCE để tránh trường hợp không có dữ liệu trả về NULL (nếu không có dữ liệu thì trả về 0)
-- Để tính tổng tiền thanh toán, ta cộng tổng tiền hát và tổng tiền sử dụng dịch vụ lại với nhau

-- Câu 2: Hiển thị MaKH, TenKH, DiaChi, SoDT của những khách hàng đã từng đặt phòng karaoke có địa chỉ ở “Hoa xuan”
SELECT DISTINCT khach_hang.ma_khach_hang, khach_hang.ten_khach_hang, khach_hang.dia_chi, khach_hang.so_dien_thoai
FROM khach_hang
JOIN dat_phong ON khach_hang.ma_khach_hang = dat_phong.ma_khach_hang
WHERE khach_hang.dia_chi = 'Hoa xuan';

-- Câu 3: Hiển thị MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, SoLanDat của những phòng được khách hàng đặt có số lần đặt lớn hơn 2 lần và trạng thái đặt là “Da dat”
SELECT phong.ma_phong, phong.loai_phong, phong.so_khach_toi_da, phong.gia_phong, COUNT(dat_phong.ma_dat_phong) AS so_lan_dat
FROM phong
JOIN dat_phong ON phong.ma_phong = dat_phong.ma_phong
WHERE dat_phong.trang_thai_dat = 'Da dat'
GROUP BY phong.ma_phong, phong.loai_phong, phong.so_khach_toi_da, phong.gia_phong
HAVING COUNT(dat_phong.ma_dat_phong) > 2;

-- Câu 4: Hiển thị TenKH của những khách hàng có tên bắt đầu là một trong các ký tự “H”, “N”, “M” và có độ dài tối đa là 20 ký tự
SELECT ten_khach_hang
FROM khach_hang
WHERE ten_khach_hang ~ '^[HNM].{0,19}$';
-- Dấu ~ là toán tử so sánh chuỗi với biểu thức chính quy
-- ^[HNM].{0,19}$: ^ là bắt đầu chuỗi, [HNM] là ký tự bắt đầu là H, N hoặc M, .{0,19} là bất kỳ ký tự nào từ 0 đến 19 ký tự, $ là kết thúc chuỗi

-- Câu 5: Hiển thị TenKH của tất cả các khách hàng có trong hệ thống, TenKH nào trùng nhau thì chỉ hiển thị một lần
SELECT DISTINCT ten_khach_hang
FROM khach_hang;

-- Câu 6: Hiển thị MaDV, TenDV, DonViTinh, DonGia của những dịch vụ đi kèm có DonViTinh là “lon” và có DonGia lớn hơn 10,000 VNĐ hoặc những dịch vụ đi kèm có DonViTinh là “Cai” và có DonGia nhỏ hơn 5,000 VNĐ
SELECT ma_dich_vu, ten_dich_vu, don_vi_tinh, don_gia
FROM dich_vu_di_kem
WHERE (don_vi_tinh = 'lon' AND don_gia > 10000) OR (don_vi_tinh = 'cai' AND don_gia < 5000);

-- Câu 7: Hiển thị MaDatPhong, MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, MaKH, TenKH, SoDT, NgayDat, GioBatDau, GioKetThuc, MaDichVu, SoLuong, DonGia của những đơn đặt phòng có năm đặt phòng là “2016”, “2017” và đặt những phòng có giá phòng > 50,000 VNĐ/ 1 giờ
SELECT dat_phong.ma_dat_phong, phong.ma_phong, phong.loai_phong, phong.so_khach_toi_da, phong.gia_phong, khach_hang.ma_khach_hang, khach_hang.ten_khach_hang, khach_hang.so_dien_thoai, dat_phong.ngay_dat, dat_phong.gio_bat_dau, dat_phong.gio_ket_thuc, dich_vu_di_kem.ma_dich_vu, chi_tiet_su_dung_dich_vu.so_luong, dich_vu_di_kem.don_gia
FROM dat_phong
JOIN phong ON dat_phong.ma_phong = phong.ma_phong
JOIN khach_hang ON dat_phong.ma_khach_hang = khach_hang.ma_khach_hang
JOIN chi_tiet_su_dung_dich_vu ON dat_phong.ma_dat_phong = chi_tiet_su_dung_dich_vu.ma_dat_phong
JOIN dich_vu_di_kem ON chi_tiet_su_dung_dich_vu.ma_dich_vu = dich_vu_di_kem.ma_dich_vu
WHERE EXTRACT(YEAR FROM dat_phong.ngay_dat) IN (2016, 2017) AND phong.gia_phong > 50000;
-- EXTRACT(YEAR FROM dat_phong.ngay_dat) trả về năm từ ngày đặt phòng (ví dụ: 2018-03-26 trả về 2018)

