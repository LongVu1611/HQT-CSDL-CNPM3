SE Master

CREATE DATABASE Sales
 ON
 PRIMARY
 (
 	NAME = tuan1_data,
 	FILENAME ='D:\ThucHanhSQL\tuan1_data.mdf',
 	SIZE = 10MB,
 	MAXSIZE = 20MB,
 	FILEGROWTH = 20%
 )
 LOG ON
 (
 	NAME = tuan1_log,
 	FILENAME = 'D:\ThucHanhSQL\tuan1_log.ldf',
 	SIZE = 10MB,
 	MAXSIZE = 20MB,
 	FILEGROWTH = 20%
 )

USE Sales
-- 1. Kiểu dữ liệu tự định nghĩa
EXEC sp_addtype 'Mota', 'NVARCHAR(40)'
EXEC sp_addtype 'IDKH', 'CHAR(10)', 'NOT NULL'
EXEC sp_addtype 'DT', 'CHAR(12)'

-- 2. Tạo table
CREATE TABLE SanPham (
    MaSP CHAR(6) NOT NULL,
    TenSP VARCHAR(20),
    NgayNhap Date,
    DVT CHAR(10),
    SoLuongTon INT,
    DonGiaNhap money,
)

CREATE TABLE HoaDon (
    MaHD CHAR(10) NOT NULL,
    NgayLap Date,
    NgayGiao Date,
    MaKH IDKH,
    DienGiai Mota,
)

CREATE TABLE KhachHang (
    MaKH IDKH,
    TenKH NVARCHAR(30),
    DiaCHi NVARCHAR(40),
    DienThoai DT,
)

CREATE TABLE ChiTietHD (
    MaHD CHAR(10) NOT NULL,
    MaSP CHAR(6) NOT NULL,
    SoLuong INT
)

-- 3. Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
    ALTER COLUMN DienGiai NVARCHAR(100)

-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
    ADD TyLeHoaHong float

-- 5. Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
    DROP COLUMN NgayNhap
-- 6. Tạo các ràng buộc khóa chính và khóa ngoại cho các bảng trên
ALTER TABLE SanPham
ADD
CONSTRAINT pk_sp primary key(MASP)

ALTER TABLE HoaDon
ADD
CONSTRAINT pk_hd primary key(MaHD)

ALTER TABLE KhachHang
ADD
CONSTRAINT pk_khanghang primary key(MaKH)

ALTER TABLE HoaDon
ADD
CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_hoadon_chitiethd FOREIGN KEY(MaHD) REFERENCES HoaDon(MaHD)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_sanpham_chitiethd FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)
-- 7.Thêm vào bảng HoaDon các ràng buộc
ALTER TABLE HoaDon
ADD CHECK (NgayGiao > NgayLap)

ALTER TABLE HoaDon
ADD CHECK (MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]')

ALTER TABLE HoaDon
ADD CONSTRAINT df_ngaylap DEFAULT GETDATE() FOR NgayLap
-- 8.Thêm vào bảng Sản phẩm các ràng buộc
ALTER TABLE SanPham
ADD CHECK (SoLuongTon > 0 and SoLuongTon < 50)

ALTER TABLE SanPham
ADD CHECK (DonGiaNhap > 0)

ALTER TABLE SanPham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR NgayNhap

ALTER TABLE SanPham
ADD CONSTRAINT df_DVT CHECK (DVT = N'KG' or DVT = N'Thùng' or DVT = N'Hộp' or DVT = N'Cái')

--12.Đổi tên CSDL Sales thành BanHang
ALTER DATABASE Sale MODIFY NAME = BanHang;

--14.Tạo bản BackUp cho CSDL BanHang
Backup database BanHang to disk = 'D:\Backup'
