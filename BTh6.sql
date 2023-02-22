create table SINHVIEN(
	MaSV varchar(2) ,
	TenSV nvarchar(20) not null,
	MaLop varchar(2) 
	primary key (MaSV),
)
create table LOP
(
	MaLop  varchar(2) ,
	TenLop nvarchar(4),
	Phong varchar(2) not null,
	primary key (MaLop),
)
INSERT INTO SINHVIEN
    (MaSV, TenSV, MaLop)
VALUES
    ('1', 'A', '1'),
	('2', 'B', '2'),
	('3', 'C', '1'),
	('4', 'D', '3');

INSERT INTO LOP
	(MaLop,TenLop,Phong)
values
('1','CD','1'),
('2','DH','2'),
('3','LT','2'),
('4','xy','4');

--1.
create function thongke(@malop nvarchar(5))
returns int
as
begin
declare @sl int
declare @tenlop int
select @tenlop=lop.tenlop,@sl=count(SINHVIEN.MaSV)
from SINHVIEN,LOP
where SINHVIEN.MaSV = LOP.MaLop and LOP.MaLop = @malop
group by LOP.TenLop
return @sl
end
--TEST
SELECT dbo.thongke('1')

--3
create function thongkesv(@tenlop nvarchar(10))
returns @thongke table (
malop nvarchar(5),
tenlop nvarchar(10),
soluong int
)
as
begin
if(not exists(select malop from lop where tenlop=@tenlop))
insert into @thongke
select lop.malop,lop.tenlop,count(sinhvien.masv)
from lop,sinhvien
where lop.malop=sinhvien.malop
group by lop.malop,lop.tenlop
else
insert into @thongke
select lop.malop,lop.tenlop,count(sinhvien.masv)
from lop,sinhvien
where lop.malop=sinhvien.malop and lop.tenlop=@tenlop
group by lop.malop,lop.tenlop
return
end
--TEST
SELECT * FROM DBO.THONGKESV(‘TIN1’)
