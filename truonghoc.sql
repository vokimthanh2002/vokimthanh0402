--khởi tạo database TRUONGHOC1
go
CREATE DATABASE TRUONGHOC1
GO
-- Sử dụng database
USE TRUONGHOC1
GO 
-- Tạo bảng HOCSINH
CREATE TABLE HOCSINH
(
	MAHS CHAR(5) not null primary key ,
	TEN NVARCHAR(30),
	NAM BIT, -- Column giới tính Nam: 1 - đúng, 0 - sai
	NGAYSINH DATETIME,
	DIACHI VARCHAR(20),
	DIEMTB FLOAT,
)
GO
-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(5) not null primary key ,
	TEN NVARCHAR(30),
	Nam BIT, -- Column giới tính Nam: 1 - đúng, 0 - sai
	NGAYSINH DATETIME,
	DIACHI VARCHAR(20),
	LUONG MONEY,
	MaBM CHAR(10)
)
GO
-- Tạo bảng LOPHOC
CREATE TABLE LOPHOC
(
	MALOP CHAR(5),
	TENLOP NVARCHAR(30),
	SOLUONG INT
)
go
-- table bo mon
CREATE TABLE BoMon
 
(
	MaBM CHAR(10) PRIMARY KEY,
	ten  NVARCHAR(100) DEFAULT N'Tên bộ môn'
)
GO
-- table lop
CREATE TABLE Lop
(
	MaLop CHAR(10) NOT NULL,
	ten  NVARCHAR(100) DEFAULT N'Tên lớp'
	PRIMARY KEY(MaLop)
)
-- alter table
alter table BoMon 
add constraint PK_BoMOn_MaBM foreign key (maBM) references GIAOVIEN (maBM)
on delete 
			cascade 
		on update
			cascade
go
insert into GIAOVIEN
values('12345',N'Võ Kim Thành',1,'04-02-2002','121 Quang Trung',100000000),
      ('12346',N'Võ Kim Thu',0,'04-02-2002','121 Quang Trung',500000000),
      ('12347',N'Võ Kim Thà',0,'04-02-2002','121 Quang Trung',1000000000),
      ('12348',N'Võ Kim Thàn',1,'04-02-2002','121 Quang Trung',1300000000),
      ('12349',N'Võ Kim Hành',1,'04-02-2002','121 Quang Trung',3400000000);
	  go
insert into HOCSINH
values ('HS001',N'Võ Kim Thành','True','04-02-2002','111 Dinh Phung',9.6),
        ('HS002',N'Võ Kim Thành','True','04-02-2002','111 Dinh Phung',1.6),
		('HS003',N'Võ Kim Thành','True','04-02-2002','111 Dinh Phung',2.6),
		('HS004',N'Võ Kim Thành','True','04-02-2002','111 Dinh Phung',5.6),
		('HS005',N'Võ Kim Thành','True','04-02-2002','111 Dinh Phung',7.6);
		go
insert into LOPHOC
values  ('LH001',N'Cơ sở dữ liệu 1',60),
		('LH002',N'Cơ sở dữ liệu 2',70),
		('LH003',N'Cơ sở dữ liệu 3',80),
		('LH004',N'Cơ sở dữ liệu 4',90),
		('LH005',N'Cơ sở dữ liệu 5',100);
		select *
		from GIAOVIEN
delete GIAOVIEN 
where LUONG<500000000
delete GIAOVIEN 
where LUONG <1000000000 and MAGV='12346'
go
truncate table GIAOVIEN
-- update
go
update GIAOVIEN set LUONG = 300000 
where Nam=1
update GIAOVIEN set LUONG =100000
where Nam=0
