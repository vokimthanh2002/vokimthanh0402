create database VoKimThanh_2050531200331_Ktr_Trigger
go
use VoKimThanh_2050531200331_Ktr_Trigger
go
create table tblXe
(
idXe char(6) not null primary key ,
LoaiXe nvarchar(20) not null,
BienSo char(10) not null,
TongSoCho int not null,
)
create table tblChuyenXe
(
idChuyenXe char(7) not null primary key,
idXe char(6) not null,
idDriver char(7) not null,
idTuyen char(2) not null,
ngayGioKhoiHanh datetime not null,
soKhachdaDatCho int not null,
soGheConTrong int
)
create table tblKhachDatCho
(
idDatCho int not null primary key ,
idChuyenXe char(7) not null,
CMNN char(9) not null,
Tel char(11) not null,
ngayThanhToan datetime not null
)


-- tao khoa ngoai 
go
alter table tblChuyenXe
	add constraint FK_idXe_014 foreign key (idxe) references tblxe (idXe)
		on delete 
			cascade 
		on update
			cascade 
go alter table tblKhachDatCho
     add constraint FK_idChuyenXe_014 foreign key (idChuyenXe) references tblChuyenXe (idChuyenXe)
	    on delete 
		 cascade
		on update
		 cascade

go
set dateformat dmy
insert into tblXe
values('Xe001','FS','BS06',20),
      ('Xe002','FB','BS03',20)

set dateformat dmy
insert into tblChuyenXe
values('CX001','Xe001','DR001','T1','10/2/2021',8,NULL),
      ('CX002','Xe002','DR004','T2','11/5/2021',8,NULL)

insert into tblKhachDatCho
values('1','CX001','CMND01','12345678914','10/2/2021')

go
---bai 1
go
create or alter trigger tg_soKhachDatCho
on tblKhachDatCho
for insert , delete
as
begin
    if not exists (select * from deleted)
        begin
            print N'Đã insert'
            update tblChuyenXe
            set soKhachDaDatCho = soKhachDaDatCho + (select COUNT(idDatCho)
													from inserted
													where inserted.idChuyenXe = tblChuyenXe.idChuyenXe)
            from inserted
            where inserted.idChuyenXe = tblChuyenXe.idChuyenXe

            if exists (select soKhachDaDatCho from tblChuyenXe as c, inserted as i where c.idChuyenXe = i.idChuyenXe  and (soKhachDaDatCho > soGheConTrong)) 
            begin
                print N'Số ghế còn trống không đủ'
                rollback tran
            end
        end
    else if not exists (select * from inserted)
        begin
            update tblChuyenXe
            set soKhachDaDatCho = soKhachDaDatCho - (select COUNT(idDatCho)
													from deleted
													where deleted.idChuyenXe = tblChuyenXe.idChuyenXe)
            from deleted
            where deleted.idChuyenXe = tblChuyenXe.idChuyenXe
        end
end
---test bai 1:
select *
from tblChuyenXe
insert into tblKhachDatCho
values('2','CX001','CMND02','12345672664','10/3/2021')
select *
from tblChuyenXe

select *
from tblChuyenXe
delete tblKhachDatCho
where idDatCho = '2'
select *
from tblChuyenXe


---bai 2:
go
create or alter trigger tg_soGheConTrong
on tblKhachDatCho
for insert , delete
as
begin
    if not exists (select * from deleted)
        begin
            update tblChuyenXe
            set soGheConTrong = tongSoCho - (select COUNT(inserted.idDatCho)
                                                 from inserted, tblKhachDatCho
												 where tblKhachDatCho.idChuyenXe = inserted.idChuyenXe)
            from tblKhachDatCho, inserted, tblXe
            where tblChuyenXe.idXe = tblXe.idXe and tblKhachDatCho.idChuyenXe = inserted.idChuyenXe
        end
    else if not exists (select * from inserted)
        begin
            update tblChuyenXe
            set soGheConTrong = tongSoCho + (select COUNT(deleted.idDatCho)
                                                 from deleted, tblKhachDatCho
												 where tblKhachDatCho.idChuyenXe = deleted.idChuyenXe)
            from tblKhachDatCho, deleted, tblXe
            where tblChuyenXe.idXe = tblXe.idXe and tblKhachDatCho.idChuyenXe = deleted.idChuyenXe
        end
end

---test  2:

select *
from tblChuyenXe

set dateformat dmy
insert into tblKhachDatCho
values('3','CX002','CMND04','12345338914','10/2/2021')

select *
from tblChuyenXe