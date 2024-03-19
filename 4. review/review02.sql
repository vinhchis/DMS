use master
go

if exists (select name from sys.databases where name = 'ABCCorp')
drop database ABCCorp
go

create database ABCCorp
go

use ABCCorp
go

create table Categories(
	CateCode nvarchar(10) primary key nonclustered,
	CateName nvarchar(50) unique,
	Decription nvarchar(100)
)

go

insert into Categories(CateCode, CateName)
values	('c-01', 'C01'),
		('c-02', 'C02'),
		('c-03', 'C03'),
		('c-04', 'C04'),
		('c-05', 'C05')
go

select *
from Categories

create table Suppliers(
	SupplierCode int primary key IDENTITY(1,1),
	SupplierName nvarchar(50) unique,
	Decription nvarchar(100)
)
go

insert into Suppliers(SupplierName)
values 
	('S01'),
	('S02'),
	('S03'),
	('S04'),
	('S05')
go

select *
from Suppliers

create table Products (
	ProductCode nvarchar(10) primary key,
	ProductName nvarchar(50) unique,
	CateCode nvarchar(10) foreign key references Categories(CateCode),
	SupplierCode int foreign key references Suppliers(SupplierCode),
	Decription nvarchar(100),
	isSelling bit default(1)
)


INSERT INTO Products (ProductCode, ProductName, CateCode, SupplierCode, isSelling)
values
	('P1', 'Product 1', 'c-01', 1, 1),
	('P2', 'Product 2', 'c-01', 1, 0),
	('P3', 'Product 3', 'c-03', 2, 0),
	('P4', 'Product 4', 'c-04', 3, 1),
	('P5', 'Product 5', 'c-04', 4, 1);
go

select *
from Products

-- 5.
EXECUTE sp_helpindex Categories

SELECT TABLE_NAME,
       CONSTRAINT_TYPE,CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Categories';


CREATE CLUSTERED INDEX ix_CateCode   
ON Categories (CateCode); 



-- 6.
create nonclustered index ix_ProductName
on Products (ProductName)

-- 7.
create view v_Product as
select *
from Products
where isSelling = 1

select * 
from v_Product

-- 8.
create procedure sp_ProductOfOrder
@nameOfSupplier varchar(50)
as
	begin
		print('Selling Products are provied:' )
		select P.ProductCode, P.ProductName
		from Products as P 
		inner join Suppliers 
		on  Suppliers.SupplierCode = P.SupplierCode 
		where Suppliers.SupplierName = @nameOfSupplier and isSelling = 1
	end
go
exec sp_ProductOfOrder 'S01'
go
-- 9

create trigger tg_delCate
on Categories 
for delete
as
	begin
		if exists(select * from deleted as C inner join Products as P on C.CateCode = P.CateCode)
			begin
				print('You can not delete this category because some products that belong this category are existed in the database')
				rollback transaction 
			end
	end
go

-- delete trigger
drop trigger tg_delCate

-- Find Constraint name
SELECT TABLE_NAME,
       CONSTRAINT_TYPE,CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Products';

-- xoá khoá ngoại CateCode trên bảng Products
alter table Products
drop constraint FK__Products__CateCo__4CA06362
-- add lại khoá
alter table Products
add foreign key (CateCode) references Categories(CateCode)

DELETE FROM Categories WHERE Categories.CateCode  = 'c-02';

select * from Categories as C inner join Products as P on C.CateCode = P.CateCode where C.CateCode = 'c-01'