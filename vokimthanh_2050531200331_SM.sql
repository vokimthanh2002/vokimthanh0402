
GO 
USE vokimthanh_2050531200331_SM
GO

----------------------------TUAN6- tao bang -----------------------------------------------

--table Khach hang gom cac thuoc tinh ma kh, ten kh, dia chi khach hang, sdt, email, so du tai khoan.
CREATE TABLE KhachHang
(
	maKH char(7) not null  PRIMARY KEY,
	tenKH nvarchar(50) not null,
	diaChiKH nvarchar(100) not null,-- tach thanh phuong, xa, quan, huyen, tinh , thanh pho.
	sdt varchar(11),
	email varchar(50),
	soDuTaiKhoan money not null
)

-- table Nhan Vien gom co cac thuoc tinh ma NV, tenNV, sdt, email, dob, luong
GO
CREATE TABLE NhanVien
(
	maNV char(7) NOT NULL  PRIMARY KEY,
	tenNV nvarchar(50) NOT NULL ,
	sdt varchar(11)  NOT NULL ,
	email varchar(50),
	dob date  NOT NULL ,
	salary money  NOT NULL 
)

-- table Don dat hang, hoa don gom co cac thuoc tinh ma DH, ngay tao don hang, dia chi giao hang, sdt giao hang, ma hoa đon dien tu, ngay thanh toan, ngay giao hang, trang thai don hang
GO
CREATE TABLE DonDatHang_HoaDon
(
	maDH char(7)  NOT NULL   PRIMARY KEY,
	ngayTaoDonHang date NOT NULL ,
	diaChiGiaoHang nvarchar(100)  NOT NULL ,
	sDTGiaoHang varchar(11)  NOT NULL ,
	maHoaDonDienTu varchar(7)  NOT NULL ,
	ngayThanhToan date  NOT NULL ,
	ngayGiaoHang date  NOT NULL ,
	trangThaiDonhang bit,
)

-- table San Pham gom co cac thuoc tinh ma SP, ten SP, don gia ban, so luong con,so luong can duoi
GO
CREATE TABLE SanPham
(
	maSP char(7) NOT NULL PRIMARY KEY,
	tenSP nvarchar(50) NOT NULL,
	donGiaBan money NOT NULL,
	soLuongHienCon bigint NOT NULL,
	soLuongCanDuoi smallint NOT NULL,
)

-- table Chi tiet don hang gom cac thuoc tinh ma DH, ma SP, so luong dat, don gia 
GO
CREATE TABLE ChiTietDonHang
(
	maDH char(7) NOT NULL ,
	maSP char(7) NOT NULL ,
	soLuongDat int NOT NULL,
	donGia money NOT NULL,
	constraint PK_ChiTietDonHang primary key (maSP,maDH)
)

-- table Phieu Nhap gom co cac thuoc tinh ma PN, ngay nhap hang
GO
CREATE TABLE PhieuNhap
(
	maPN char(7) NOT NULL PRIMARY KEY,
	ngayNhapHang date NOT NULL,
)

-- table Chi tiet phieu nhap gom co cac thuoc tinh ma PN, ma SP, so luong nhap, gia nhap
GO
CREATE TABLE ChiTietPhieuNhap
(
	maPN char(7) NOT NULL  ,
	maSP char(7) NOT NULL  ,
	soLuongNhap int NOT NULL,
	giaNhap money NOT NULL,
	constraint PK_ChiTietPhieuNhap primary key (maSP,maPN)
)

-- table Nha cung cap gom co cac thuoc tinh ma NCC, tenNCC, dia chi nha cung cap, sdt va nhan vien lien he
GO
CREATE TABLE NhaCungCap
(
	maNCC char(10) NOT NULL PRIMARY KEY,
	tenNCC nvarchar(50) NOT NULL,
	diaChiNCC nvarchar(100) NOT NULL,-- tách thanh phuong, xa, quan, huyen, tinh ,thanh pho.
	sdt varchar(11) NOT NULL ,
	nhanVienLienHe nvarchar(50),
)


------------------------------ TUAN7---------------------------------
-- Cau 1 bo sung cac table luu giu ve thong tin khuyen mai
-- khuyen mai
GO
create table KhuyenMai
(
	maKM char (7) NOT NULL primary key,
	chuongTrinhKM nvarchar(100) ,
	ngayBatDauKM date,
	ngayKetThucKM date
)

-- san pham khuyen mai
GO
CREATE TABLE SanPhamKM
(
	maKM char(7) NOT NULL,
	maSP char(7) NOT NULL,
	tile int NOT NULL,
	foreign key (maKM) references KhuyenMai (maKM),
	foreign key (maSP) references SanPham (maSP),
)


-- Cau2 bo sung cac table luu giu thong tin ve position 
--chuc vu 
GO 
CREATE TABLE ChucVu 
( 
	maCV char(7) not null primary key, 
	tenCV nvarchar(21) not null
 ) 

--chuc vu cua nhan vien 
GO 
CREATE TABLE ChucVu_NhanVien 
( 
	maNV char(7) not null foreign key references NhanVien(maNV),
	maCV char(7) not null foreign key references ChucVu(maCV),
	primary key (maNV, maCV) 
)


-- Cau 3 tach cot dia chi
GO 
CREATE TABLE Tinh_Thanh
(
	maTinh_Thanh char (7) NOT NULL primary key,
	tenTinh_Thanh nvarchar(100) NOT NULL ,
)
GO 
CREATE TABLE Quan_Huyen
(
	maQuan_Huyen char (7) NOT NULL primary key,
	tenQuan_Huyen nvarchar(100) NOT NULL ,
)
GO 
CREATE TABLE Phuong_Xa
(
	maPhuong_Xa char (7) NOT NULL primary key,
	tenPhuong_Xa nvarchar(100) NOT NULL ,
)

-- Cau 4 bo sung cot trang thai don hang chi nhan 1 trong cac gia tri 4. “Cho duyet”, “Da duyet- dang dong goi”, “Dang giao”, “Da giao”
GO
ALTER TABLE donDatHang_HoaDon
	alter column trangThaiDonhang nvarchar(60) NOT NULL
GO
ALTER TABLE donDatHang_HoaDon
	add constraint CK_donDatHang_HoaDon_trangThaiDonhang check (trangThaiDonhang like N'Chờ duyệt' 
																or trangThaiDonhang like N'Đã duyệt – Đang đóng gói'
																or trangThaiDonhang like N'Đang giao'
																or trangThaiDonhang like N'Đã giao')

-- Cau 5
-- a email thuoc 1 trong 3 dich vu mail: Gmail ho?c Yahoo Mail ho?c ute.udn.vn mail và phai la duy nh?t cho bang NhanVien và Khach hang
	GO
	ALTER TABLE NhanVien
		add constraint CK_NhanVien_email check (Email like '[A-Za-z]%@gmail.com' 
												or Email like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%@ute.udn.vn '
												or Email like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%@ute.udn.vn '
												or Email like '[A-Za-z]%@yahoo.com'),
			constraint UQ_NhanVien_email UNIQUE(email)
GO
ALTER TABLE KhachHang	
	add constraint CK_KhachHang_email check(Email like '[A-Za-z]%@gmail.com' 
											or Email like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@%ute.udn.vn '
											or Email like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%@ute.udn.vn '
											or Email like '[A-Za-z]%@yahoo.com'),
		constraint UQ_KhachHang_email UNIQUE(email)


-- b so dien thoai la day cac chu so gom 10 hoac 11 chu so va phai la duy nhat cho bang NhanVien và Khach hang
GO
ALTER TABLE KhachHang
	add constraint CK_KhachHang_sdt Check (sdt like  '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
										   or sdt like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),     
	    constraint UQ_KhachHang_sdt Unique (sdt)
GO
ALTER TABLE NhanVien
	add constraint CK_NhanVien_sdt Check (sdt like  '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
										  or sdt like  '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),         
	    constraint UQ_NhanVien_sdt Unique (sdt)


-- c doB dam bao du 18 tuoi tro len
GO
ALTER TABLE NhanVien
		add constraint CK_NhanVien_dob_18old Check (dob <= concat (format (day (getdate()),'D2'),'/',
													format(month (getdate()),'D2'),'/',year(getdate())-18)) 


-- d Gender (‘F’ hoac ‘M’) – mac dinh ‘F’ Position chi nhan mot trong cac gia tri sau: ‘Nhân viên bán hàng’, 
--‘Nhân viên kho’, ‘Nhân viên giao hàng’, ‘Qu?n l? viên’. M?c đ?nh là ‘Nhân viên bán hàng’
GO
ALTER TABLE NhanVien
	add gioiTinh char(1) Default 'F'
alter table ChucVu
	add constraint DF_tenCV default N'Nhân viên bán hàng' for tenCV with values,
		constraint CK_tenCV check(tenCV = N'Nhân viên bán hàng'
							   or tenCV = N'Nhân viên kho'
							   or tenCV = N'Nhân viên giao hàng'
							   or tenCV = N'Quản lý viên')		


-- e ngay tao don hang nho hon ngay hien tai
GO
ALTER TABLE DonDatHang_HoaDon
	Add constraint CK_DonDatHang_HoaDon_ngayTaoDonHang check (ngayTaoDonHang < getdate())

-- f ngay thanh toan nho hon ngay hien tai va lon hon ngay dat hang 
GO
ALTER TABLE DonDatHang_HoaDon
	Add constraint CK_DonDatHang_HoaDon_ngayThanhToan check (ngayThanhToan < getdate()
															 And ngayThanhToan>ngayTaoDonHang)

-- g ngay giao hang nho hon ngay hien tai va lon hon ngay thanh toan
GO
Alter table donDatHang_HoaDon
	Add constraint CK_DonDatHang_HoaDon_ngayGiaoHang check (ngayGiaoHang < getdate()
															And ngayGiaoHang>ngayThanhToan)


-- h them cot trang don hang da giao nhan mot trong cac gia tri binh thuong, loi hang, khong lien lac duoc voi khach hang , mac dinh binh thuong
GO
ALTER TABLE donDatHang_HoaDon
		add trangThaiDonhangdagiao nvarchar(60) 
GO
ALTER TABLE donDatHang_HoaDon
		Add constraint CK_donDatHang_HoaDon_trangThaiDonhangdagiao Check(trangThaiDonhangdagiao like N'Bình Thường' 
																		or trangThaiDonhangdagiao like N'lỗi hàng'
																		or trangThaiDonhangdagiao like N' Không liên lạc được với khách hàng'),
		Constraint DF_donDatHang_HoaDon_trangThaiDonhangdagiao default ' Bình thường' for trangThaiDonhangdagiao


-- i Address (‘Da Nang’, ‘TP Ho Chi Minh’, ‘Quang Nam’) – mac dinh Da Nang
GO
ALTER TABLE KhachHang
	alter column diaChiKH nvarchar(100) null
GO
ALTER TABLE KhachHang
	add constraint CK_KhachHang_diaChiKH check (diaChiKH like N'Đà Nẵng' 
											or diaChiKH like N'TP Hồ Chí Minh' 
											or diaChiKH like N'Quảng Nam'),
		constraint DF_KhachHang_diaChiKH default N'Đà nẵng' for diaChiKH
GO
ALTER TABLE NhaCungCap
	alter column diaChiNCC nvarchar(100) null
GO
ALTER TABLE NhaCungCap
	add constraint CK_NhaCungCap_diaChiNCC check (diaChiNCC like N'Đà Nẵng' or 
			diaChiNCC like N'TP Hồ Chí Minh' or diaChiNCC like N'Quảng Nam'),
		constraint DF_KH_diaChiNCC default N'Đà nẵng' for diaChiNCC


-- j Cac column lien quan den gia tien hoac so luong phai lon hon hoac bang 0
GO
ALTER TABLE KhachHang
	Add constraint CK_KhachHang_soDuTaiKhoan check(soDuTaiKhoan>=0)
GO
ALTER TABLE NhanVien
	Add constraint CK_NhanVien_salary check(salary>=0)

--thêm cột tongTien vào table DonDatHang_HoaDon( lí do vì trong giáo trình không có sẵn cột này) và thêm ràng buộc check
GO
ALTER TABLE DonDatHang_HoaDon
	Add tongtienđathang money 
GO
ALTER TABLE DonDatHang_HoaDon
	add	Constraint  CK_DonDatHang_HoaDon_tongtienđathang check(tongtienđathang>=0)
GO
ALTER TABLE ChiTietDonHang
	Add constraint CK_ChiTietDonHang_soLuongDat Check(soLuongDat>=0),
	    constraint CK_ChiTietDonHang_donGia Check(donGia>=0)
GO
ALTER TABLE SanPham
	Add constraint CK_SanPham_soLuongHienCon Check(soLuongHienCon>=0),
	    Constraint CK_SanPham_soLuongCanDuoi check(soLuongCanDuoi>=0)


-- Cau 6 thiet lap khoa ngoai va rang buoc khi xoa/ cap nhat
GO
ALTER TABLE ChiTietDonHang
		Add constraint FK_ChiTietDonHang_maDH foreign key (maDH) references donDatHang_HoaDon (maDH)
				On update 
				Cascade
				On delete 
				Cascade,
		   constraint FK_ChiTietDonHang_maSP foreign key (maSP) references SanPham (maSP)
				On update 
				Cascade
				On delete 
				Cascade
GO
ALTER TABLE ChiTietPhieuNhap
	Add constraint FK_ChiTietPhieuNhap_maPN foreign key (maPN) references PhieuNhap (maPN)
			On update 
				Cascade
			On delete 
				Cascade,
		constraint FK_ChiTietPhieuNhap_maSP foreign key (maSP) references SanPham (maSP)
			On update 
				Cascade
			On delete 
				Cascade



---------------------------------TUAN8  insert and view-------------------------------

-- them khoa ngoai ma quan huyen cho bang Phuong xa
GO
alter table Phuong_Xa
	add maQuan_Huyen char(7) NOT NULL foreign key (maQuan_Huyen) references Quan_Huyen (maQuan_Huyen)
	on update
		cascade
	on delete
		cascade


-- them khoa ngoai ma tinh thanh cho bang QuanHuyen
GO
alter table Quan_Huyen
	add maTinh_Thanh char(7) NOT NULL foreign key (maTinh_Thanh) references Tinh_Thanh (maTinh_Thanh)
	on update
		cascade
	on delete
		cascade


-- them khoa ngoai maCV, maNv cho bang Chucvu_NhanVien
GO
alter table Chucvu_NhanVien
	add constraint FK_Chucvu_NhanVien_maCV foreign key (maCV) references ChucVu (maCV)
			on update
				cascade
			on delete
				cascade,
		constraint FK_Chucvu_NhanVien_maNV foreign key (maNV) references NhanVien (maNV)
			on update
				cascade
			on delete
				cascade


-- them maPhuong_Xa , maNV, maKH cho  bang don dat hang hoa don
GO
alter table DonDatHang_HoaDon
	add maPhuong_Xa char(7) NOT NUll foreign key (maPhuong_Xa) references Phuong_Xa (maPhuong_Xa),			
		maNV char(7) NOT NUll foreign key (maNV) references NhanVien (maNV),			
		maKH char(7) NOT NUll foreign key (maKH) references KhachHang(maKH)


-- them khoa ngoai maPhuongXa cho bang nha cung cap 
GO
alter table NhaCungCap
	add maPhuong_Xa char(7) NOT NUll foreign key (maPhuong_Xa) references Phuong_Xa (maPhuong_Xa)
		on update
			cascade
		on delete
			cascade


-- them khoa ngoai maPhuongXa cho bang Khach hang
GO
alter table KhachHang
	add maPhuong_Xa char(7) NOT NUll foreign key (maPhuong_Xa) references Phuong_Xa (maPhuong_Xa)
		on update
			cascade
		on delete
			cascade

-- them khoa ngoai maNCC cho bang PhieuNhap
GO
alter table PhieuNhap
	add maNCC char(10) NOT NUll foreign key (maNCC) references NhaCungCap (maNCC)
		on update
			cascade
		on delete
			cascade

-- chen du lieu dia chi
-- chen du lieu bang Tinh
GO 
insert into Tinh_Thanh
	values ('TT01', N'Bình Định'),
		   ('TT02', N'Đà Nẵng'),
		   ('TT03', N'Quảng Trị'),
		   ('TT04', N'Thừa Thiên Huế'),
		   ('TT05', N'Hà Giang'),
		   ('TT06', N'Cao Bằng'),
		   ('TT07', N'Lai Châu'),
		   ('TT08', N'Lào Cai'),
		   ('TT09', N'Quảng Nam'),
		   ('TT10', N'Nghệ An');


-- chen du lieu bang Quan_Huyen
GO 
insert into Quan_Huyen
	values ( 'Q01', N'A Lưới','TT04'),
		   ( 'Q02', N'Nam Đông','TT04'),
		   ( 'Q03', N'Phong Điền','TT04'),
		   ( 'Q04', N'Phú Lộc','TT04'),
		   ( 'Q05', N'Hải Châu','TT02'),
		   ( 'Q06', N'Ngũ Hành Sơn','TT02'),
		   ( 'Q07', N'Thanh Khê','TT02'),
		   ( 'Q08', N'Tiên Phước','TT09'),
		   ( 'Q09', N'Thăng Bình','TT09'),
		   ( 'Q10', N'Duy Xuyên','TT09');


-- chen du lieu bang Phuong_Xa
GO 
insert into Phuong_Xa
	values ( 'P10', N'Lộc Trì','Q04'),
		   ( 'P11', N'Phong Bình','Q03'),
		   ( 'P12', N'Bình An','Q09'),
		   ( 'P13', N'Thanh Bình','Q05'),
		   ( 'P14', N'Tiên Mỹ','Q08'),
		   ( 'P15', N'Thượng Long','Q02'),
		   ( 'P16', N'Hòa Hải','Q06'),
		   ( 'P17', N'Tiên Cảnh','Q08'),
		   ( 'P18', N'Hòa Quý','Q06'),
		   ( 'P19', N'Tiên An','Q10');


-- chen du lieu cho bang khuyen mai
GO
insert into KhuyenMai
	values('KM001',N'Ngày 20/11','11/20/2021','11/20/2021'),
		  ('KM002',N'Ngày 8/3','03/07/2021','03/08/2021'),
		  ('KM003',N'Ngày 20/10','10/19/2021','10/20/2021'),
		  ('KM004',N'Halloween','10/30/2021','10/31/2021'),
		  ('KM005',N'Black Friday','12/30/2021','12/31/2021'),
		  ('KM006',N'Lễ Tình Nhân','02/14/2021','02/14/2021'),
		  ('KM007',N'Ngày 11/11','11/11/2021','11/11/2021'),
		  ('KM008',N'Ngày 5/5','05/05/2021','05/05/2021'),
		  ('KM009',N'Quốc Tế Thiếu Nhi','06/01/2021','06/01/2021'),
		  ('KM010',N'Ngày Thầy Thuốc Việt Nam','02/27/2021','02/27/2021');


-- chen du lieu cho bang khach hang
GO
insert into KhachHang 
	values ('KH001', N'Trần Văn Hậu', N'Đà Nẵng', '0111111111', 'hau@gmail.com', '50000','P10'),
		   ('KH002', N'Huấn Hoa Hồng', N'Quảng Nam', '0222222222', 'hong@gmail.com', '9550000','P12'),
		   ('KH003', N'Khá Thị Bảnh', N'Đà Nẵng', '0333333333', 'banh42@gmail.com', '100000','P11'),
		   ('KH004', N'Chi Ca Phú', N'TP Hồ Chí Minh', '0444444444', 'phu@gmail.com', '9000000','P13'),
		   ('KH005', N'Năm Văn Cam', N'Quảng Nam', '0555555555', 'canm@gmail.com', '60000','P17'),
	       ('KH006', N'Thắng Cá Chép', N'Quảng Nam', '0666666666', 'chep0@gmail.com', '700000','P19'),
	       ('KH007', N'Dũng Trọc', N'TP Hồ Chí Minh', '0777777777', 'dung02@gmail.com', '8100000','P16'),
	       ('KH008', N'Đường Nhuệ', N'TP Hồ Chí Minh', '0888888888', 'nheu@gmail.com', '7500000','P16'),
	       ('KH009', N'Võ Kim Thành', N'Đà Nẵng', '0999999999', 'thanh@gmail.com', '9500000','P15'),
	       ('KH010', N'Sơn Tùng', N'Quảng Nam', '0000000000', 'mtp@gmail.com', '8900000','P19');


-- chen du lieu bang Nhan vien
GO 
insert into NhanVien
	values  ('NV001', N'Hoài Linh','0561234789', 'linh14toi@gmail.com', '01/02/1998','14000000000', 'F'),
			('NV002', N'hoàng Yên','0563412789', 'yenluadao@gmail.com','08/15/1996','6000000', 'M'),
			('NV003', N'Phương Hằng','0889945699', 'hanghotxoan@gmail.com', '10/12/1995','50000000000', 'F'),
			('NV004', N'Trấn Thành','0894568999', 'thanhtranlot@gmail.com', '5/02/2000','5500000', 'M'),
			('NV005', N'Thủy Tiên','0799458959', 'thuyte@gmail.com','02/26/1997','5500000', 'M'),
			('NV006', N'Công Vinh','0789599459', 'vinhsuthut@gmail.com','10/26/1997','5500000', 'M'),
			('NV007', N'Vy Oanh','0899456899', 'vyvy@gmail.com', '08/04/1999','6000000', 'F'),
			('NV008', N'Điền Quân','0996655449', 'quandautroc@gmail.com', '09/14/1995','3000000', 'M'),
			('NV009', N'Lê Mạnh','0999458689', 'manhcs@gmail.com', '02/14/1999','5000000', 'M'),
			('NV010', N'Thái Thị Ngầu','0878965312', 'ngau@gmail.com', '08/02/1994', '5500000','M');


-- chen du lieu bang chuc vu
GO 
insert into ChucVu
	values('CV001',N'Nhân viên bán hàng'),
		  ('CV002',N'Nhân viên kho'),
		  ('CV003',N'Nhân viên giao hàng'),
		  ('CV004',N'Quản lý viên');
		  
		   
-- chen du lieu bang chuc vu nhan vien
GO 
insert into ChucVu_NhanVien
	values ('NV001','CV001'),
		   ('NV002','CV002'),
		   ('NV003','CV003'),
		   ('NV004','CV001'),
		   ('NV005','CV004'),
		   ('NV006','CV003'),
		   ('NV007','CV002'),
		   ('NV008','CV001'),
		   ('NV009','CV001'),
		   ('NV010','CV003');


-- chen du lieu bang nha cung cap
GO
insert into NhaCungCap
	values('NCC001', N'Chăn Nuôi Kim Thành', N'TP Hồ Chí Minh', '0916333321', N'Võ Kim Thành','P13'),
		  ('NCC002', N'Phân Bón Quang Trọng', N'Đà Nẵng', '0916333322', N'Mai quang Trọng','P10'),
		  ('NCC003', N'Phân Bón Trần Tiến', N'TP Hồ Chí Minh', '0916333323', N' Trần Ngọc Tiến','P16'),
		  ('NCC004', N'Nông Sản Trần Thị Mến', N'Đà Nẵng', '0916333324', N'Võ Văn Thành','P11'),
		  ('NCC005', N'Suất Ăn Lương Gia Bình', N'Quảng Nam', '0916333325', N'Phan Văn Trung','P17'),
		  ('NCC006', N'Thực Phẩm Nam Duy', N'TP Hồ Chí Minh', '0916333326', N'Lê Thị Kiều Diễm','P18'),
		  ('NCC007', N'Thực Phẩm Trung Hiếu', N'Quảng Nam', '0916333327', N'Phan Văn Trung','P19'),
		  ('NCC008', N'Thực Phẩm Chân Thành', N'Đà Nẵng', '0916333328', N'Lê Nhật','P15'),
		  ('NCC009', N'Thực Phẩm Long Trọng Tiến', N'Đà Nẵng', '0916333329', N'Phan Trọng Tiến','P11'),
		  ('NCC010', N'Thực Phẩn Gia Định', N'TP Hồ Chí Minh', '0916333320', N'Gia Định','P16');

-- chen bang san pham
GO 
insert into SanPham
	values('SP001', N'Ngũ cốc', '10000', '52', '41'),
		  ('SP002', N'Sữa', '9000', '63', '53'),
		  ('SP003', N'Đậu Xanh', '6000', '85', '49'),
		  ('SP004', N'Dừa', '12000', '42', '32'),
		  ('SP005', N'Nho', '4000', '75', '35'),
		  ('SP006', N'Hạnh Nhân', '11000', '62', '36'),
		  ('SP007', N'Socola', '5000', '96', '41'),
		  ('SP008', N'Mít', '10000', '32', '21'),
		  ('SP009', N'Chanh', '18000', '25', '10'),
		  ('SP010', N'Cam', '8000', '57', '39');



-- chen du lieu bang phieu nhap
GO
insert into PhieuNhap
	values('PN001', '2021/8/19', 'NCC001'),
		  ('PN002', '2021/7/19', 'NCC001'),
		  ('PN003', '2021/8/5', 'NCC002'),
		  ('PN004', '2021/6/29', 'NCC005'),
		  ('PN005', '2021/11/15', 'NCC007'),
		  ('PN006', '2021/10/10', 'NCC006'),
		  ('PN007', '2021/8/3', 'NCC009'),
		  ('PN008', '2021/11/1', 'NCC010'),
		  ('PN009', '2021/10/9', 'NCC002'),
		  ('PN010', '2021/5/25', 'NCC003');


-- chen du lieu bang chi tiet phieu nhap
GO
insert into ChiTietPhieuNhap
	values('PN004','SP007','200','22500'),
		  ('PN005','SP006','150','34000'),
		  ('PN007','SP002','300','74000'),
		  ('PN006','SP005','100','54000'),
		  ('PN005','SP003','200','34500'),
		  ('PN008','SP003','150','35000'),
		  ('PN007','SP006','100','310000'),
		  ('PN004','SP009','200','216000'),
		  ('PN005','SP004','250','211000'),
		  ('PN003','SP008','150','38500');


-- chen du lieu cho bang san pham khuyen mai
GO
insert into SanPhamKM
	values('KM001','SP001','10' ),
		  ('KM002','SP002','15' ),
		  ('KM003','SP003','20' ),
		  ('KM004','SP004','30' ),
		  ('KM005','SP005','35' ),
		  ('KM006','SP006','50' ),
		  ('KM007','SP007','25' ),
		  ('KM008','SP008','10' ),
		  ('KM009','SP009','30' ),
		  ('KM010','SP010','40' );


-- chen du lieu vao bang don dat hang hoa don
GO
insert into DonDatHang_HoaDon
	values('DH001','2021/9/11',N'48 Cao Thắng','0111111111','HDDT111','2021/9/12','2021/9/13',N'Chờ duyệt',N'Bình Thường' ,'300000','P10','NV003','KH001'),
		  ('DH002','2021/9/12',N'78 Ông Ích Khiêm','0222222222','HDDT112','2021/9/14','2021/9/16',N'Đã duyệt – Đang đóng gói',N'lỗi hàng','400000','P12','NV006','KH002'),
		  ('DH003','2021/9/13',N'1337 Nguyễn Tất Thành','0333333333','HDDT113','2021/9/15','2021/9/17',N'Đang giao',N'Bình Thường' ,'500000','P11','NV010','KH003'),
		  ('DH004','2021/9/14',N'56 Trần Cao Vân','0444444444','HDDT114','2021/9/16','2021/9/18',N'Chờ duyệt',N'Bình Thường' ,'600000','P13','NV003','KH004'),
		  ('DH005','2021/9/15',N'56 Lê Duẩn','0555555555','HDDT115','2021/9/17','2021/9/19',N'Đã giao',N'lỗi hàng','700000','P17','NV003','KH005'),
		  ('DH006','2021/9/16',N'02 Ngô Gia Tự','0666666666','HDDT116','2021/9/18','2021/9/20',N'Đang giao',N'Bình Thường' ,'800000','P19','NV006','KH006'),
		  ('DH007','2021/9/17',N'16 Điện Biên Phủ','0777777777','HDDT117','2021/9/19','2021/9/21',N'Đã giao',N' Không liên lạc được với khách hàng','900000','P16','NV006','KH007'),
		  ('DH008','2021/9/18',N'89 Lý Tự Trọng','0888888888','HDDT118','2021/9/20','2021/9/22',N'Chờ duyệt',N'Bình Thường' ,'350000','P16','NV010','KH008'),
		  ('DH009','2021/9/19',N'06 Thuận Hóa','0999999999','HDDT119','2021/9/21','2021/9/23',N'Đã giao',N' Không liên lạc được với khách hàng','450000','P15','NV010','KH009'),
		  ('DH010','2021/9/20',N'106 Quang Trung','0000000000','HDDT120','2021/9/22','2021/9/24',N'Đang giao',N'Bình Thường' ,'550000','P19','NV003','KH010');


-- chen du lieu bang chi tiet don hang
GO 
insert into ChiTietDonHang
	values('DH001','SP001','15','132000'),
		  ('DH002','SP001','44','132000'),
		  ('DH003','SP001','44','131500'),
		  ('DH004','SP002','15','152000'),
		  ('DH004','SP003','44','512000'),
		  ('DH004','SP004','54','142000'),
		  ('DH005','SP006','34','142000'),
		  ('DH006','SP007','24','12000'),
		  ('DH007','SP008','43','142000'),
		  ('DH008','SP009','39','142000');
-- Tao VIEW
create view SanPham_ConBan as
	select maSP, tenSP, donGiaBan
	from SanPham
	where soLuongHienCon >0

	---------------------------------TUAN9  select, Bổ sung and view-------------------------------
	--thêm dữ liệu cho bảng sản phẩm
	insert into SanPham
	values('SP011', N'Thịt heo', '1000000', '52', '41'),
		  ('SP012', N'Thịt gà', '900000', '63', '53'),
		  ('SP013', N'Thịt vịt', '6000000', '85', '49');
		  --thêm dữ liệu cho bản phiếu nhập
		  insert into PhieuNhap
		  values('PN011', '2021/8/19', 'NCC001'),
		  ('PN012', '2021/7/19', 'NCC001'),
		  ('PN013', '2021/8/5', 'NCC001');
--Bài tập buổi trước: Hãy hiển thị thông tin các sản phẩm có giá bán ra nằm trong 
--3 mức giá cao nhất?
select maSP,tenSP,donGiaBan
from SanPham as sp
where donGiaBan =any  ( select distinct top 3 donGiaBan
                     from SanPham as sp	
					 order by donGiaBan desc)

--Hãy hiển thị thông tin sản phẩm có số lần nhập hàng về nhiều nhất
		select top 1  S.maSP, tenSP, count(C.maSP) as solanNhap
		from SanPham as S, ChiTietPhieuNhap as C
		where S.maSP = C.maSP
		group by s.maSP,tenSP
		order by solanNhap desc
--a. thống kê 3 sản phẩm bán chạy nhất
		select sp.maSP,tenSP, sum(soLuongDat) as tongsl
		from SanPham as sp
		join ChitietDonHang as ct
		on sp.maSP=ct.maSP
		group by sp.maSP,tenSP
		having sum(soLuongDat) in ( select distinct top 3 sum(soLuongDat) as tongsl
								from  ChiTietDonhang 
								group by maSP
								order by tongsl desc)
--b. thống kê những sản phẩm chưa bán được cái nào
		select maSP, tenSP
		from SanPham
		where maSP not in (select distinct maSP
							from ChiTietDonHang)
							--b
							select s.maSP,tenSP
							from SanPham as s
							join ChiTietDonHang as d
							on s.maSP=d.maSP 
							where s.maSP is null
							



--c. hiển thị những đơn hàng giao thành công và thông tin cụ thể của người giao hàng
		select N.*, trangThaiDonHang
		from NhanVien as N
		join DonDatHang_HoaDon as D
		on  N.maNV = D.maNV and trangThaiDonhang = N'Đã giao'
--d. hiển thị những đơn hàng của khách hàng ở Đà Nẵng hoặc Quảng Nam
		select maKH,tenKH,sdt,email,diaChiKH
		from KhachHang as kh
		where diaChiKH like (N'Đà Nẵng') or diaChiKH like (N'Quảng Nam')
		group by maKH, tenKH, sdt, email, diaChiKH
--e. hiển thị những sản phẩm có giá từ 500k – 2.000k
		select maSP, tenSP, donGiaBan
		from SanPham
		where donGiaBan >= 500000 and donGiaBan < 2000000
--f. những tháng có doanh thu trên 2000000 (có tham số là định mức tiền)
		select month(ngayThanhToan) as thang, year(ngayThanhToan) as nam,
			format( sum(soLuongDat * donGia), '##,#\VND','es-ES') as tongThu
		from DonDatHang_HoaDon as D, ChiTietDonHang as C
		group by month(ngayThanhToan), year(ngayThanhToan)
		having sum(soLuongDat * donGia) > 2000000
/*g. thống kê số lượng khách theo từng tỉnh/thành phố (sắp xếp giảm dần)
dựa trên việc bổ sung 3 thực thể: Phường_Xã, Quận_Huyện, Tỉnh_ThànhPhố*/
		select count(maKH) as soLuongKhach, diaChiKH
		from KhachHang
		group by diaChiKH
		order by soLuongKhach desc
--h. thống kê giá trung bình, giá max, giá min nhập hàng cho mỗi sản phẩm
select S.maSP, tenSP, Max(giaNhap) as lonNhat,
				Min(giaNhap) as nhoNhat,
				Avg(distinct giaNhap) as trungBinh
		from SanPham as S
		join ChiTietPhieuNhap as C
		on  S.maSP = C.maSP
		group by S.maSP, tenSP
--i. hiển thị giá trung bình, giá max, giá min bán ra cho mỗi sản phẩm
select S.maSP, tenSP, Max(distinct donGia) as lonNhat,
		Min(distinct donGia) as nhoNhat,
		Avg(distinct donGia) as trungBinh
	from SanPham as S
	join ChiTietDonHang as C
	on  S.maSP = C.maSP
	group by S.maSP, tenSP
--j. thống kê số lần khách hàng mua hàng của từng khách hàng (sắp xếp giảm dần)
	select K.tenKH, count (maDH) as soLan
	from KhachHang as K
	join DonDatHang_HoaDon as D
	on  K.maKH = D.maKH
	group by K.tenKH
	order by soLan desc 
--k. hiển thị thông tin chi tiết của các sản phẩm mà có số lần nhập hàng nhiều nhất
	select S.maSp, tenSP, count(C.maSP) as solanNhap
	from SanPham as S
	join ChiTietPhieuNhap as C
	on S.maSP = C.maSP
	group by S.maSP, tenSP
	having count(C.maSP) in (select top 1 count(maSP) as solanNhap
							from ChiTietPhieuNhap 
							group by maSP
							order by solanNhap desc)
--l. hiển thị thông tin chi tiết của các nhà cung cấp mà có số lần nhập hàng lớn hơn 3
	select N.maNCC, tenNCC, count(P.maNCC) as solanNhap
	from NhaCungCap as N
    right  join PhieuNhap as P
	on N.maNCC = P.maNCC
	group by N.maNCC, tenNCC
	having count(P.maNCC) > 3



--2 Bổ sung câu truy vấn

--a. Hiển thị những đơn hàng không cần được xuất hóa đơn
select *
from DonDatHang_HoaDon
where trangThaiDonhangdagiao like(N'lỗi hàng') 
or trangThaiDonhangdagiao like(N' Không liên lạc được với khách hàng')

--3. Tạo VIEW

--a. Tách thành phần họ và tên thành 2 cột riêng/ Hoặc gộp 2 thành phần này thành một	
	
	create view tachten as
	SELECT tenKH, SUBSTRING(KhachHang.tenKH, 1, LEN(KhachHang.tenKH)
	-CHARINDEX(' ', REVERSE(KhachHang.tenKH))) AS ho, LTRIM(RIGHT
	( + KhachHang.tenKH, CHARINDEX(' ', REVERSE( + KhachHang.tenKH)))) AS ten FROM KhachHang

--b. Chỉ chứa tất cả thông tin những đơn hàng chưa được giao
--(không quan tâm đến những đơn hàng đã được giao – vì sẽ không có 
--bất cứ thay đổi dữ liệu nào với những đơn hàng đã giao)
---->lưu ý những dữ liệu này không được xóa khỏi table
	--i. tblOrderInvoice
				--ko có dữ liệu 
	--ii. tblOrderInvoiceDetail
create view don_chua_giao as
select *
from DonDatHang_HoaDon
where trangThaiDonhang not like(N'Đã giao')

--c. Tương tự cho các phiếu nhập
create view  chi_tiet_phieu_nhap_chua_giao as
select ctpn.*
from DonDatHang_HoaDon as ddh,ChiTietPhieuNhap as ctpn,ChiTietDonHang as ctdh
where ddh.maDH=ctdh.maDH and ctdh.maSP=ctpn.maSP and trangThaiDonhang not like(N'Đã giao')

--d. Chỉ chứa những nhân viên còn đang làm việc (bỏ qua những nhân viên đã nghỉ việc – nhưng không được xóa)

create view nhan_vien_con_lam_viec as
select nv.*
from NhanVien as nv,ChucVu_NhanVien as cvnv,ChucVu as cv
where cv.maCV=cvnv.maCV and nv.maNV=cvnv.maNV 
SELECT *
FROM SanPham
WHERE donGiaBan IN
(
select distinct top 3 donGiaBan from SanPham
)
order by donGiaBan desc
select tenNV, parsename(replace(dbo.NhanVien.tenNV,' ','.'),1) as ten
from NhanVien
select tenKH, reverse(parsename(reverse(replace(tenKH, ' ', '.')),1)) as Ho,
SUBSTRING(tenKH,len(reverse(parsename(reverse(replace(tenKH, ' ', '.')),1))) + 2,
len(tenKH) - len(parsename(replace(tenKH,' ','.'),1)) - 1- len(reverse(parsename(reverse(replace(tenKH, ' ', '.')),1)))) as lot
from KhachHang

select month(ngayTaoDonHang) as thang, sum(soLuongDat * donGia) as doanhThu
from DonDatHang_HoaDon as D, ChiTietDonHang as C
where D.maDH = C.maDH
group by month(ngayTaoDonHang),year(ngayTaoDonHang)
order by doanhThu desc
--hãy hiển thị danh sách những sản phẩm cần phải nhâp hàng
select tenSP 
from SanPham
where soLuongHienCon<=soLuongCanDuoi

--hiển thị những nhà cung cấp sản phẩm đã từng cung cấp theo từng loại sản phẩm sắp xếp giảm dần,chỉ hiển thị những nhà cung cấp nằm trong top 3
select top 3 with ties count(distinct PhieuNhap.maNCC) as SoNhaCungCap,ChiTietPhieuNhap.maSP,SanPham.tenSP
from ChiTietPhieuNhap
join PhieuNhap
on ChiTietPhieuNhap.maPN = PhieuNhap.maPN
join SanPham
on SanPham.maSP = ChiTietPhieuNhap.maSP
group by ChiTietPhieuNhap.maSP,SanPham.tenSP
order by soNhaCungCap desc;


--hiển thị những nhà cung cấp sản phẩm đã từng cung cấp theo từng loại sản phẩm sắp xếp giảm dần,chỉ hiển thị những nhà cung cấp nằm trong top 3
select  maSP, count(distinct N.maNCC) as soLuongNCC
from PhieuNhap as N, ChiTietPhieuNhap as C
where N.maPN = C.maPN
group by maSP
having count( distinct N.maNCC) in (select distinct top 3 count(distinct N.maNCC) as soLuongNCC
							from PhieuNhap as N, ChiTietPhieuNhap as C
							where N.maPN = C.maPN
							group by C.maSP
							order by soLuongNCC desc)
order by soLuongNCC desc

----=====----
--a
select *
from DonDatHang_HoaDon
where trangThaiDonhangdagiao like N'lỗi hàng'
	or trangThaiDonhangdagiao like N' Không liên lạc được với khách hàng'

-----=====-----

select tenNV, parsename(replace(tenNV, ' ', '.'),1) as ten,
		left(tenNV,len(tenNV) - len(parsename(replace(tenNV, ' ', '.'),1))-1) as holot
from NhanVien

--like not like
select *
from NhanVien
where tenNV contains(Name,N'%u%')
--like not like
select *
from NhanVien
where tenNV like N'%n%'

	select tenNV
	from NhanVien
	union all
	select tenKH
	from  KhachHang

	


---------------------------------TUAN 11 THAY WHERE = JOIN-------------------------------
--Bài tập buổi trước: Hãy hiển thị thông tin các sản phẩm có giá bán ra nằm trong 
--3 mức giá cao nhất?
select maSP, tenSP, format (donGiaBan, '##,#\ VNĐ','es-ES') AS donGB
from SanPham 
where donGiaBan in (
	select distinct top 3 donGiaBan
	from SanPham
	order by donGiaBan desc
)
order by donGiaBan desc

--Hãy hiển thị thông tin sản phẩm có số lần nhập hàng về nhiều nhất
select top 1 with ties SP.maSP, SP.tenSP, COUNT (CTPN.maSP) AS SL
from SanPham AS SP 
	join ChiTietPhieuNhap AS CTPN
	on SP.maSP = CTPN.maSP
group by SP.maSP, SP.tenSP
order by SL desc

--a. thống kê 3 sản phẩm bán chạy nhất
select ct.maSP,tenSP,count(soLuongDat) as tong_SL
from ChiTietDonHang as ct
	join SanPham as sp
	on ct.maSP=sp.maSP
group by ct.maSP,tenSP
having count(soLuongDat) in ( 
		select distinct top 3 count(soLuongDat) as SL
		from ChiTietDonHang 		
		group by maSP
		order by SL desc
)
order by tong_SL desc

--b. thống kê những sản phẩm chưa bán được cái nào
select SP.maSP, tenSP
from SanPham AS SP
where SP.maSP NOT IN (
		select maSP
		from ChiTietDonHang
)

--c. hiển thị những đơn hàng giao thành công và thông tin cụ thể của người giao hàng
select maDH, ddh.maNV, nv.tenNV, nv.sdt,nv.gioiTinh,ddh.trangThaiDonhangdagiao,cv.tenCV
from DonDatHang_HoaDon AS ddh
	join NhanVien AS nv 
	on  ddh.maNV = nv.maNV
	join ChucVu_NhanVien as cv_nv
	on nv.maNV = cv_nv.maNV
	join ChucVu as cv
	on cv_nv.maCV = cv.maCV 
where ddh.trangThaiDonhangdagiao like  N'Bình thường'

--d. hiển thị những đơn hàng của khách hàng ở Đà Nẵng hoặc Quảng Nam
select maKH,tenKH,sdt,email,diaChiKH
from KhachHang as kh
where diaChiKH like (N'Đà Nẵng')  or diaChiKH like  (N'Quảng Nam')
group by maKH,tenKH,sdt,email,diaChiKH

--e. hiển thị những sản phẩm có giá từ 500k – 2.000k
select maSP, tenSP,format (donGiaBan, '##,#\ VNĐ','es-ES') AS donGB
from SanPham
where donGiaBan>500000 and donGiaBan<2000000

--f. những tháng có doanh thu trên 2000000 (có tham số là định mức tiền)

select month(ddh.ngayThanhToan) as tháng , year(ddh.ngayThanhToan) as năm,
format ( sum((soLuongDat*donGia)),'##,#\VND','es-ES') as N'Tổng thu'
from ChiTietDonHang as ct
	join DonDatHang_HoaDon as ddh
	on ct.maDH=ddh.maDH 
group by month(ddh.ngayThanhToan),year(ddh.ngayThanhToan)
	having sum((soLuongDat*donGia))>2000000

/*g. thống kê số lượng khách theo từng tỉnh/thành phố (sắp xếp giảm dần)
dựa trên việc bổ sung 3 thực thể: Phường_Xã, Quận_Huyện, Tỉnh_ThànhPhố*/

SELECT tt.tenTinh_Thanh, COUNT(tt.tenTinh_Thanh) AS soLuong
from  DonDatHang_HoaDon as ddh
	join Phuong_Xa as px
	on ddh.maPhuong_Xa = px.maPhuong_Xa
	join Quan_Huyen as qh
	on px.maQuan_Huyen = qh.maQuan_Huyen
	join Tinh_Thanh as tt
	on qh.maTinh_Thanh = tt.maTinh_Thanh
	join KhachHang as kh
    on ddh.maKH = kh.maKH 
group by tt.tenTinh_Thanh
ORDER BY soLuong DESC

--h. thống kê giá trung bình, giá max, giá min nhập hàng cho mỗi sản phẩm
SELECT cpn.maSP, tenSP, format  (MIN(DISTINCT giaNhap), '##,#\ VNĐ','es-ES') AS tienMin, format (MAX(DISTINCT giaNhap), '##,#\ VNĐ','es-ES') AS tienMax, format (AVG(DISTINCT giaNhap), '##,#\ VNĐ','es-ES') AS tienTB
FROM ChiTietPhieuNhap AS cpn
	join SanPham AS sp
    on cpn.maSP = sp.maSP 
GROUP BY cpn.maSP, tenSP
GO

--i. hiển thị giá trung bình, giá max, giá min bán ra cho mỗi sản phẩm
SELECT  cdh.maSP, tenSP, format (MIN(DISTINCT donGia), '##,#\ VNĐ','es-ES') AS minTienBan, format (MAX(DISTINCT donGia), '##,#\ VNĐ','es-ES') AS maxTienBan, format (AVG(DISTINCT donGia), '##,#\ VNĐ','es-ES') AS tbTienBan
FROM ChiTietDonHang AS cdh 
	join SanPham AS sp
	on cdh.maSP = sp.maSP 
GROUP BY cdh.maSP, tenSP
GO

--j. thống kê số lần khách hàng mua hàng của từng khách hàng (sắp xếp giảm dần)
select tenKH, COUNT (ddh.maKH) as so_lan_mua
from DonDatHang_HoaDon as ddh
	join KhachHang as kh
	on ddh.maKH=kh.maKH
group by ddh.maKH, kh.tenKH
order by so_lan_mua desc

--k. hiển thị thông tin chi tiết của các sản phẩm mà có số lần nhập hàng nhiều nhất
select top 1 with ties tenSP, sp.maSP, format (donGiaBan, '##,#\ VNĐ','es-ES') AS N'donGB' ,COUNT(ct.maSP) as So_lan_nhap
from ChiTietPhieuNhap as ct
	join SanPham as sp
	on sp.maSP=ct.maSP
group by tenSP,sp.maSP,sp.donGiaBan
order by So_lan_nhap desc

-- cách 2 truy van long
select s.maSP, s.tenSP, count(s.maSP) as SoLanNhap
from SanPham as s
	join ChiTietPhieuNhap as c
	on s.maSP = c.maSP
group by s.maSP, s.tenSP
having count(s.masp) in (
				select top 1 count(maSP) as SoLanNhap
				from chiTietPhieuNhap
				group by maSP
				order by SoLanNhap desc
)
--l. hiển thị thông tin chi tiết của các nhà cung cấp mà có số lần nhập hàng lớn hơn 3
select ncc.tenNCC,ncc.diaChiNCC,ncc.sdt,COUNT(pn.maNCC) as so_lan_nhap
from PhieuNhap as pn
	join NhaCungCap as ncc
	on pn.maNCC=ncc.maNCC 
group by  ncc.tenNCC,ncc.diaChiNCC,ncc.sdt
having COUNT(pn.maNCC)>3
--2 Bổ sung câu truy vấn

--a. Hiển thị những đơn hàng không cần được xuất hóa đơn
--- maHoaDonDienTu bằng null
---Không có đơn hàng nào maHoaDonDienTu = NULL
select *
from DonDatHang_HoaDon
where maHoaDonDienTu is NULL

--3. Tạo VIEW

--a. Tách thành phần họ và tên thành 2 cột riêng/ Hoặc gộp 2 thành phần này thành một	
-- table Nhan Vien
create view Tach_ten_NV2
AS
SELECT tenNV, parsename(replace(NhanVien.tenNV,' ','.'),1) AS TEN , LEFT(tenNV,len(tenNV) - len(parsename(replace(NhanVien.tenNV,' ','.'),1)) -1) AS HOLOT
FROM NhanVien
WITH CHECK OPTION
GO
-- table Khach Hang
create view Tach_ten_KH2
as
SELECT tenKH, parsename(replace(KhachHang.tenKH,' ','.'),1) AS TEN , LEFT(tenKH,len(tenKH) - len(parsename(replace(KhachHang.tenKH,' ','.'),1)) -1) AS HOLOT
FROM KhachHang
WITH CHECK OPTION
GO
--b. Chỉ chứa tất cả thông tin những đơn hàng chưa được giao
--(không quan tâm đến những đơn hàng đã được giao – vì sẽ không có 
--bất cứ thay đổi dữ liệu nào với những đơn hàng đã giao)
---->lưu ý những dữ liệu này không được xóa khỏi table
	--i. tblOrderInvoice
				--ko có dữ liệu 
	--ii. tblOrderInvoiceDetail
CREATE VIEW DHChuaGiao2
	AS
	SELECT cdh.maDH,maSP, maKH, maNV, ngayTaoDonHang,SDTGiaoHang, maHoaDonDienTu, ngayThanhToan, ngayGiaoHang, trangThaiDonhang, trangThaiDonhangdagiao
	FROM DonDatHang_HoaDon AS dhhd
		join ChiTietDonHang AS cdh
		on dhhd.maDH = cdh.maDH
	WHERE trangThaiDonhang  NOT LIKE  N'Đã giao' AND ngayGiaoHang is NULL 

--c. Tương tự cho các phiếu nhập ( những sản phẩm không nhập hàng )
create view SPChuaNhap2 as
			select maPN, maNCC
			from PhieuNhap
			where ngayNhapHang is NULL
--d : Chỉ chứa những nhân viên còn đang làm việc (bỏ qua những nhân viên đã nghỉ việc – nhưng không được xóa)
CREATE VIEW NV_con_lam2
AS
SELECT maNV, tenNV
FROM NhanVien
WHERE ngayNghiViec IS NULL

// ca se
select *
from SanPham
select *,
case
when soLuongHiencon>20 then N'số lượng lớn hơn 20'
when soLuongHienCon=20 then N'sôs lượng hiện còn bsnwgf 20'
else N'số lượng nhỏ hơn 20'
end as result 
from SanPham

--Hãy viết đoạn lệnh để kiểm tra: nếu tồn tại một sản phẩm có số lượng hiện còn nhở hơn 0 -> 
--'Không đủ sản phẩm để bán - hãy chọn lại đơn hàng'; ngược lại 'Bạn đã đặt hàng thành công'

--viết đoạn lệnh để lấy giá trị lớn nhất của id trong bảng khách hàng
begin
if exists( select * from DonDatHang_HoaDon where tongtienđathang>10000000)
print N'được giảm 10%'
if exists( select * from DonDatHang_HoaDon where tongtienđathang>400000)
print N'free ship'
else
print N'ship tùy theo trọng lượng và khoảng cách'
end

select *
from DonDatHang_HoaDon

begin
select *
from DonDatHang_HoaDon
select *,
case 
when tongtienđathang>10000000 then N'giảm 10%'
when tongtienđathang>400000 then N'free ship'
else N'theo kho luong'
end as result
end
--thủ tục 

--viết hàm tính thành tiền của sản phẩm khi biết soLuongDatMua và khi biêt GiaBan
go
  create function fn_tinhTien
 (
	@soluongdat int,
	@giaban money	
 )
 returns money
 begin
	return @soluongdat *@giaban
 end
 select dbo.fn_tinhTien(4,400000)
 
--hay hien thi thanh tien cua tat ca casc dong trong chi tiet don hang
select *,dbo.fn_tinhTien(soLuongDat,donGia)
from ChiTietDonHang


-- 
--câu 1
--a)Hãy viết hàm hoặc thủ tục để tính id tiếp theo trong bảng KhachHang, NhanVien, SanPham (lưu ý chọn bảng có id gồm chữ cái và số)
--thủ tục
create PROCEDURE pr_idSP_next
    @maSpNext as char(7) output 
AS
BEGIN
    declare @idMax int 
    set @idMax = (select max(right(maSP,5)) from SanPham)
    set @maSpNext = concat('SP', format(@idMax + 1, 'D3'))
END
go
declare @maSpNext char(7)   
execute pr_idSP_next @maSpNext output
print @maSpNext

--hàm
go
create function fn_idSP_next
(
)
returns char(7)
begin
declare @idSP_Max int
declare @idSP_Next char(7)
set @idSP_Max = (select max(right(maSP, 5)) from SanPham)
set @idSP_Next = concat('SP', format(@idSP_Max+1, 'D3'))
return @idSP_Next
end
go
select dbo.fn_idSP_next()

--b) thống kê những sản phẩm bán chạy nhất 
go
create PROCEDURE pr_topSp
    @top int
AS
BEGIN
    select S.maSP,tenSP,sum(soLuongDat) as N'Số Lượng Đặt'
	from ChiTietDonHang as C
        join SanPham as S
        on C.maSP = S.maSP
	group by S.maSP,tenSP
	having SUM(soLuongDat) in (select distinct top (@top) SUM(soLuongDat)
								from ChiTietDonHang
								group by maSP
								order by SUM(soLuongDat) desc)
    order by sum(soLuongDat) desc
END     
go 
execute pr_topSp 3
--c) những tháng có danh thu trên 200000(có tham số là định mức tiền)
go
create PROCEDURE pr_doanhThuThang
    @dinhMucTien money
AS    
BEGIN
    select month(ngayTaoDonHang) as N'Tháng', year(ngayTaoDonHang) as N'Năm',sum(soLuongDat*donGia) as N'Doanh thu'
    from donDatHang_HoaDon as d 
        join chiTietDonHang as c
        on d.maDH=c.maDH
    group by month(ngayTaoDonHang), year(ngayTaoDonHang)
    having sum(soLuongDat*donGia) >= @dinhMucTien
END    
go 
execute pr_doanhThuThang 2000000
--d) thống kê số lượng khách theo tỉnh
go
create procedure pr_luongKhach
AS
BEGIN
	select tenTinh_Thanh, count (kh.maPhuong_Xa) as soLuongKhach
	from KhachHang as kh
		join Phuong_Xa as P
			join Quan_Huyen as Q
				join Tinh_Thanh as T
				on Q.maTinh_Thanh = T.maTinh_Thanh
			on Q.maQuan_Huyen = P.maQuan_Huyen
		on P.maPhuong_Xa = kh.maPhuong_Xa
	group by tenTinh_Thanh
	order by soLuongKhach desc
END
GO
execute pr_luongKhach
--e) thống kê giá trị trung bình max, min ở các phiếu nhập hàng cho mỗi sản phẩm
go
create procedure pr_giaTri
    @sp char(7)
AS
BEGIN
	select maSP, avg(soLuongNhap*giaNhap) as N'giá trị TB',
				max(soLuongNhap*giaNhap) as N'giá trị MAX',
				min(soLuongNhap*giaNhap) as N'giá trị MIN'
	from ChiTietPhieuNhap 
	where maSP like @sp
	group by maSP
END
GO
execute pr_giaTri SP003
--f)thống kê số lần khách hàng mua hàng(sắp xếp giảm dần)
go
create procedure pr_soLanMua
AS
BEGIN
	select tenKH, COUNT (ddh.maKH) as N'số lần mua'
	from DonDatHang_HoaDon as ddh
		join KhachHang as kh
		on ddh.maKH=kh.maKH
	group by tenKH
	order by COUNT (ddh.maKH) desc
END
go
execute pr_soLanMua
--g) thống kê doanh thu lớn nhất(cả thông tin doanh thu về năm và về daonh thu)(có 2 giá trị đầu ra)
go 
create procedure pr_doanhThuMax
AS
BEGIN
	select year(ngayTaoDonHang) as N'Năm',sum(soLuongDat*donGia) as N'Doanh thu'
	from donDatHang_HoaDon as d
		join chiTietDonHang as c
		on c.maDH=d.maDH
	group by year(ngayTaoDonHang)
END
go
execute pr_doanhThuMax
-- câu 2
--a) tính tiền khi biết đơn giá và số lượng đặt( đầu vào 2 tham số)
go
create function fn_tinhtien
(
    @donGiaBan int,
    @soLuongDat money
)
returns money
as
BEGIN
    return @soLuongDat*@donGiaBan
end 
go
select  dbo.fn_tinhtien (3,5000)
--b) tổng tiền cho mỗi đơn hàng khi cho biết mã đơn hàng
go
create function fn_tongTien
(
    @maDH char(7)
)
returns money
AS
BEGIN
    declare @tong money
    set @tong = (select sum(soLuongDat*donGia)
            from ChiTietDonHang
            WHERE maDH = @maDH
            group by maDH)
    return @tong 
END
go
select dbo.fn_tongTien('DH001') as N'Tổng tiền'
--c) tính thành tiền sau khi đã áp dụng khuyến mãi khi biết mã khuyến mãi, số lượng bán, đơn giá
go
create function fn_thanhTien
(
	@khuyenMai int,
	@soLuongBan int,
	@donGia money
)
returns money
as
begin
	return (@soLuongBan * @donGia) - (@khuyenMai * @soLuongBan * @donGia) / 100
end
go
select dbo.fn_thanhTien(10,15,150000)
--trigger  để tự động kích hoạt một hành dộng gì tiếp theo ngay sau khi ínert update delete dữ liệu 
--vd 1  hãy hiển thị câu tb sau khichèn thanh công1 dòng dữ liệu vào 
select *
from SanPham
create trigger tg_thongbao_SP
on SanPham 
for insert 
as 
begin 
print N'ban da chen thanh cong'
end
--de mo du lieu bang san pham 
insert into SanPham
values ('SP0174	1', N'Thịt vịt', '6000000', '85', '49');
--cap nhat update xoa bang san pham 
create trigger ud_thongbao_SP
on SanPham
for update 
as
begin
print 'cap nhat thanh cong'
end
update SanPham
set soLuongCanDuoi=10000
where maSP='SP001'
-- bai tap trigger 
--1. Tự động cập nhật số lượng hiện còn ở bảng SanPham mỗi khi insert/ update/ delete vào bảng ChiTietDonHang
--insert
create trigger tg_donHang_insert_slhc_sp
on ChiTietDonHang
after insert
as
begin
	save tran sp1
	update SanPham
	set soLuongHienCon = soLuongHienCon - i.soLuongDat
	from SanPham as s, inserted as i
	where s.maSP = i.maSP
	declare @sl int
	if(exists (select soLuongHienCon from SanPham where soLuongHienCon < 0))
		rollback tran sp1
end
go
insert into ChiTietDonHang
values ('DH004', 'SP013', 9, NULL)
go
--delete
create trigger tg_donHang_delete_slhc_sp
on ChiTietDonHang
after delete
as
begin
	update SanPham
	set soLuongHienCon = soLuongHienCon + d.soLuongDat
	from SanPham as s, deleted as d
	where s.maSP = d.maSP
end
go
delete from ChiTietDonHang
where maDH = 'DH001'
go
--update
create trigger tg_donHang_update_slhc_sp
on ChiTietDonHang
after update
as
begin
	save tran sp1
	update SanPham
	set soLuongHienCon = soLuongHienCon - (i.soLuongDat - d.soLuongDat)
	from SanPham as s, deleted as d, inserted as i
	where s.maSP = d.maSP and i.maSP = s.maSP and d.maDH = i.maDH and d.maSP = i.maSP
	declare @sl int
	if(exists (select soLuongHienCon from SanPham where soLuongHienCon < 0))
		rollback tran sp1
end
go
update ChiTietDonHang
set soLuongDat = 15
where maDH = 'DH004' and maSP = 'SP004'
go
--2 Tự động cập nhật giá trị cột DonGia vào bảng ChiTietDonHang sau khi insert/ update/ delete vào bảng ChiTietDonHang;
--insert
create trigger tg_donHang_insert_donGia_sp
on ChiTietDonHang
after insert
as
begin
	update ChiTietDonHang
	set donGia = s.donGiaBan
	from SanPham as s, inserted as i, ChiTietDonHang as c
	where s.maSP = i.maSP and c.maDH = i.maDH and c.maSP = i.maSP
end
go
insert into ChiTietDonHang
values ('DH004', 'SP011', 9, NULL)
go
--update
create trigger tg_donHang_update_donGia_sp
on ChiTietDonHang
after update
as
begin
	update ChiTietDonHang
	set donGia = s.donGiaBan
	from SanPham as s, inserted as i, ChiTietDonHang as c
	where s.maSP = i.maSP and c.maSP = i.maSP and c.maDH = i.maDH
end
go
update ChiTietDonHang
set maSP = 'SP002'
where maDH = 'DH002'
go
--3. Tự động cập nhật số lượng DonGiaBan ở bảng SanPham mỗi khi insert vào bảng ChiTietPhieuNhap (công thức Đơn giá nhập * 30% - 30% chính là tiền lời)
create trigger tg_phieuNhap_insert_donGia_sp
on ChiTietPhieuNhap
after insert
as
begin
	update SanPham
	set donGiaBan = i.giaNhap + (i.giaNhap * 0.3)
	from SanPham as s, inserted as i
	where s.maSP = i.maSP
end
go
insert into ChiTietPhieuNhap
	values ('PN005', 'SP003', 100, 6000)
go
--4. Tự động cập nhật số lượng hiện còn ở bảng SanPham mỗi khi insert/ update/ delete vào bảng ChiTietPhieuNhap
create trigger tg_phieuNhap_insert_slhc_sp
on ChiTietPhieuNhap
after insert
as
begin
	update SanPham
	set soLuongHienCon = soLuongHienCon + i.soLuongNhap
	from SanPham as s, inserted as i
	where s.maSP = i.maSP
end
go
insert into ChiTietPhieuNhap
values ('PN002', 'SP002', 300, 50000)
go
--delete
create trigger tg_phieuNhap_delete_slhc_sp
on ChiTietPhieuNhap
after delete
as
begin
	update SanPham
	set soLuongHienCon = soLuongHienCon - d.soLuongNhap
	from SanPham as s, deleted as d
	where s.maSP = d.maSP
end
go
delete from ChiTietPhieuNhap
where maPN = 'PN002' and maSP = 'SP002'
go
--update
create trigger tg_phieuNhap_update_slhc_sp
on ChiTietPhieuNhap
after update
as
begin
	update SanPham
	set soLuongHienCon = soLuongHienCon - (d.soLuongNhap - i.soLuongNhap)
	from SanPham as s, deleted as d, inserted as i
	where s.maSP = d.maSP and d.maSP = s.maSP and i.maSP = d.maSP and i.maPN = d.maPN
end
go
update ChiTietPhieuNhap
set soLuongNhap = 300
where maPN = 'PN003' and maSP = 'SP007'

