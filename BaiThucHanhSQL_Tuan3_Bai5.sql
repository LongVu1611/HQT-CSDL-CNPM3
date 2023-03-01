--18. Cho biết số lượng đề án của công ty
SELECT COUNT(DEAN.MADA)
FROM DEAN

--19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án

select * from DEAN,PHONGBAN where DEAN.PHONG = PHONGBAN.MAPHG

--20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án

select count(*) as 'Số lượng các phòng ban tham gia chủ trì đề án' from DEAN,PHONGBAN where DEAN.PHONG = PHONGBAN.MAPHG

--21. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
SELECT COUNT(DEAN.MADA)
FROM DEAN, PHONGBAN
WHERE DEAN.PHONG = PHONGBAN.MAPHG AND
PHONGBAN.TENPHG = N'Nghiên cứu'

--22. Cho biết lương trung bình của các nữ nhân viên.
SELECT AVG(NHANVIEN.LUONG)
FROM NHANVIEN
WHERE NHANVIEN.PHAI = N'Nữ'

--23. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
SELECT COUNT(THANNHAN.MA_NVIEN)
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND NHANVIEN.HONV = N'Đinh' AND NHANVIEN.TENLOT = N'Bá' AND NHANVIEN.TENNV = N'Tiến'

--24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.

select TOP 3 HONV + ' ' + TENLOT + ' ' + TENNV + ' ' as 'Họ và tên',year(NGSINH) as 'Năm sinh' from NHANVIEN
ORDER BY year(NGSINH)

--25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.MADA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA

--26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.TENDA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA

--27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS 'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS 'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(PHANCONG.MA_NVIEN) AS'Số lượng đề án tham gia'
FROM NHANVIEN, DEAN, PHANCONG
WHERE NHANVIEN.MANV = PHANCONG.MA_NVIEN AND DEAN.MADA = PHANCONG.MADA
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)
