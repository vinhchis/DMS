Use StrongHold
go

-- 1. Ràng buộc Default
alter table Item
add constraint DF_Rate Default (0) for Rate
go

insert into Item(ICode, ItemName)
values ('ACCP', 'Aptech Profession')
go

select *
from Item
go

alter table Item
drop constraint DF_Rate
go


-- 2. Ràng buộc Check
alter table Item
add constraint CK_Rate check(Rate >=0)
go

insert into Item
values ('ACDD-11', 'New ACDD ver. 11', -120)
go

alter table Item
drop constraint CK_Rate
go

-- 3. Identity and	Unique
	-- Indentity : tự động tăng bắt đầu từ 1
	-- Unique : duy nhất
create table Brand(
	BrandId int identity primary key,
	BrandName varchar(50) unique,
	[Des] varchar(50)
)
go

insert into Brand(BrandName)
values ('Fpt Course 01'),
	('Fpt Course 01')
go

--drop table Brand
--go

--select *
--from Brand

-- 5.1 Select không dùng FROM
declare @BirthDate varchar(12)
set @BirthDate = '2000/04/01'
go

select DATEDIFF(year, @BirthDate, GETDATE()) As Age;
go

-- 5.2 Thêm hằng chuỗi "có mã Sp là " và đổi tên kết quả thành Info
select ICode,  ItemName
from Item
go

select ItemName + N' có mã SP là: ' + ICode  as Info
from Item
go

-- 6. Tính giảm giá 10% trong kết quả trả về
select ItemName, Rate, Rate *0.1 as Discount
from Item

-- 7. Hiển thị giá trị không trùng
select ItemCode
from OrderDetails

select distinct ItemCode
from OrderDetails

--- 8. 6 dòng đầu tiên tỏng bảng OrderDetails (24 dòng) chiếm 25%
select top 6 OrderNo, ItemCode, Qty
from OrderDetails

select TOP 25 percent OrderNo, ItemCode, Qty
from OrderDetails

-- 8.* TOP with Order BY
select top 5 OrderNo, ItemCode, Qty
from OrderDetails
order by Qty DESC
go

-- 9. Sao chép bẳng với Select Into
select ICode As N'Sản Phẩm chờ'
into ItemPending
from Item
go

select * from ItemPending
go

-- 10. trích xuất chính xác các "Balo màu nâu :RKSK-B"
select OrderNo, ItemCode, Qty
from OrderDetails
where ItemCode = 'RKSK-B'
go

-- 11.