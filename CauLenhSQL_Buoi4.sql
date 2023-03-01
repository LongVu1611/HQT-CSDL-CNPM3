--1. Liệt kê danh sách tất cả các nhân viên
select *
	from NHANVIEN
--2. Tìm các nhân viên làm việc ở phòng số 5
go
	select *
	from NHANVIEN
	where NHANVIEN.PHG=5
go
--3.Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng
go
	select  HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên', PHG
	from NHANVIEN
	where NHANVIEN.LUONG>6000000
go
--4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức lương trên 5.000.000 ở phòng 4
go
	select *
	from nhanvien
	where NHANVIEN.LUONG>6500000 and NHANVIEN.PHG=1 or NHANVIEN.LUONG>5000000 and NHANVIEN.PHG=4
go
--5.Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên'
	from NHANVIEN 
	where Nhanvien.DCHI like N'%HaiPhong'

	select *
	from NHANVIEN
go
--6.Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên'
	from NHANVIEN
	where NHANVIEN.HONV like N'N%'
go
--7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
go
	select NGSINH,DCHI
	from NHANVIEN
	where HONV = N'Cao' and TENLOT=N'Thanh' and TENNV=N'Huyền'
go
--8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975
go
	select *
	from NHANVIEN
	where Year(NGSINH) Between 1955 and 1975
go
--9. Cho biết các nhân viên và năm sinh của nhân viên
go
	select TENNV,Year(NGSINH) as 'Năm sinh'
	from NHANVIEN
go
--10. Cho biết họ tên và tuổi của tất cả các nhân viên
go	
	select TENNV,Year(getdate())-Year(NGSINH) as 'Tuổi'
	from NHANVIEN
go
--11. Tìm tên những người trưởng phòng của từng phòng ban
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên Trưởng Phòng'
	from PHONGBAN,NHANVIEN
	where PHONGBAN.TRPHG=NHANVIEN.MANV
go
--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Điều hành".
go
	select TENNV,DCHI
	from PHONGBAN,NHANVIEN
	where PHONGBAN.MAPHG = NHANVIEN.PHG and TENPHG like N'Điều hành'

	select*
	from phongban
	
go
--13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
go
	select TENDEAN,TENPHG,HONV,TENNV
	from NHANVIEN,PHONGBAN,DEAN
	where NHANVIEN.MANV = PHONGBAN.TRPHG and PHONGBAN.MAPHG = DEAN.PHONG and DEAN.DDIEM_DA like N'Quảng Ngãi'

	select*
	from phongban
	select*
	from DEAN
go
--14. Tìm tên những nữ nhân viên và tên người thân của họ
go
	select TENNV,TENTN
	from NHANVIEN,THANNHAN
	where NHANVIEN.MANV = THANNHAN.MA_NVIEN and NHANVIEN.PHAI like N'Nữ'
go
--15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.
go
	select nv.HONV+ ' ' +nv.TENLOT+ ' ' +nv.TENNV as 'Họ Và Tên nv', tp.HONV+ ' ' +tp.TENLOT+ ' ' +tp.TENNV as 'Họ Và Tên Trưởng Phòng'
	from NHANVIEN nv,NHANVIEN tp , PHONGBAN pb
	where tp.MANV= pb.TRPHG and pb.MAPHG=nv.PHG

go
--16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản".

--17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.
go
	select DEAN.TENDA
	from NHANVIEN,PHANCONG,DEAN
	where NHANVIEN.MANV = PHANCONG.MA_NVIEN and PHANCONG.MADA= DEAN.MADA and HONV = N'Trần' and TENLOT=N'Thanh' and TENNV=N'Tâm'
go
