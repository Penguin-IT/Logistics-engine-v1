-- 1. Tạo bảng Khách Hàng
CREATE TABLE KhachHang (
    MaKH char(10) PRIMARY KEY ,
    TenKH NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(100),
    DiaChi NVARCHAR(255)
)

-- 2. Tạo bảng Tài Xế
CREATE TABLE TaiXe (
    MaTX char(10) PRIMARY KEY,
    TenTX NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    BienSoXe VARCHAR(20)
)

-- 3. Tạo bảng Hóa Đơn (Bảng này giữ Khóa ngoại kết nối KH và TX)
CREATE TABLE HoaDon (
    MaHD char(10) PRIMARY KEY,
    NgayLap DATETIME DEFAULT GETDATE(),
    MaKH char(10),
    MaTX char(10), 
    TrangThai NVARCHAR(50),
    TongTien DECIMAL(18, 2),
    CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT FK_HoaDon_TaiXe FOREIGN KEY (MaTX) REFERENCES TaiXe(MaTX)
)

-- 4. Tạo bảng Chi Tiết Hóa Đơn
CREATE TABLE ChiTietHoaDon (
    MaHD char(10),
    MaHH char(10), 
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18, 2),
    Constraint PK_CTHD PRIMARY KEY (MaHD, MaHH), 
    CONSTRAINT FK_CTHD_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
)

-- Insert Khách Hàng (Sếp phải tự định nghĩa KH001, KH002...)
INSERT INTO KhachHang (MaKH, TenKH, SDT, Email, DiaChi)
VALUES 
('KH001', N'Nguyen Van A', '0901234567', 'nva@gmail.com', N'Quận 1, TP.HCM'),
('KH002', N'Nguyen Thi B', '0912345678', 'ntb@gmail.com', N'Quận Tân Bình, TP.HCM'),
('KH003', N'Nguyen Huu Nhat', '0988888888', 'nhat@huit.edu.vn', N'Quận Tân Phú, TP.HCM');

-- Insert Tài Xế
INSERT INTO TaiXe (MaTX, TenTX, SDT, BienSoXe)
VALUES 
('TX001', N'Trần Văn Tốc Độ', '0999111222', '59-A1 12345'),
('TX002', N'Lê Giao Nhanh', '0988333444', '59-B2 67890');

-- Insert Hóa Đơn
INSERT INTO HoaDon (MaHD, NgayLap, MaKH, MaTX, TrangThai, TongTien)
VALUES 
('HD001', '2026-04-13 10:00:00', 'KH001', 'TX001', N'hủy', 20000),       
('HD002', '2026-04-13 11:30:00', 'KH002', 'TX002', N'hủy', 100000),      
('HD003', '2026-04-14 08:00:00', 'KH003', 'TX001', N'đang giao', 2000000); 

-- Insert Chi Tiết Hóa Đơn
INSERT INTO ChiTietHoaDon (MaHD, MaHH, SoLuong, DonGia)
VALUES 
('HD001', 'SP101', 1, 20000),     
('HD002', 'SP102', 2, 50000),     
('HD003', 'SP103', 1, 2000000);

select *
from KhachHang kh join HoaDon hd on kh.MaKH=hd.MaKH
    join TaiXe tx on tx.MaTX = hd.MaTX

Select TenKH,sum(TongTien)As TongTienHuy
from KhachHang kh join HoaDon hd on kh.MaKH=hd.MaKH
where hd.TrangThai=N'hủy'
group by TenKH