use StrongHold
-- 1. Xem	
select CCode, CName, CAddress, CPhone
from Customer
go
-- 2. Thêm
insert into Customer
values ('F01', 'Fpt Apteach', '590 CMT8, Q3', '0333475252')
-- 3. Thêm
insert into Customer(CCode, CName)
values ('F03', 'Fpt Apteach 03')

-- 4. Thêm
insert into Customer(CCode, CName)
values ('F04', N'Trường Fpt Apteach 04')

--- 5. Sữa
update Customer
set CAddress = N'131 Nơ Trang Long, BT',
	CPhone = '0112347488'
where CCode = 'F03'

--- 6. Xoá
delete from Customer 
where CCode = 'F01'