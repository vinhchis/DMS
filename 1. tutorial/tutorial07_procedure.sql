-- system (built-in) Stire procedure
	-- List all databases
	exec sp_databases

	-- change owner rule
	use StrongHold
	exec sp_changedbowner 'sa'
-- user-defined Store procedure
create procedure spCusTLT
as
	print N'Thông tin khác hàng TLT'
	select * 
	from Customer
	where CCode ='TLT'
go
execute spCusTLT
go
drop procedure spCusTLT
go

-- Procedure with params
create procedure spCusByCode
@code varchar(15)
as
	print N'Thông tin khác hàng TLT'
	select * 
	from Customer
	where CCode = @code
go

execute spCusByCode 'BCL'


Create PROCEDURE spCusInfo 
@v_CCode varchar(10) 
AS 
 DECLARE @v_return int 
 SELECT @v_return = COUNT(*) 
 FROM Customer WHERE CCode = @v_CCode 
 IF @v_return > 0 
	SELECT * FROM Customer WHERE CCode = @v_CCode 
 ELSE 
	RETURN @v_return + 1 

 declare @cnt int
 execute @cnt = spCusInfo 'TLT'

 select @cnt

 -- Try-Catch
 begin try
	exec spCusByCode 
 end try
 begin catch
	print 'Erorr'
 end catch

 -- *) khai báo biến nếu null cho select *
  --SELECT ISNULL(NULL, 'W3Schools.com'); 
Create PROCEDURE spCusInfoN
@v_CCode varchar(10) = null
AS 
	begin try 
		if @v_CCode = ISNULL(@v_CCode, '')
			begin
				select * from Customer where CCode = @v_CCode
			end
		else
			begin
				select * from Customer
			end
	end try
	begin catch
		print 'Erorr'
	end catch

execute spCusInfoN

-- Trigger
create trigger CheckRate
on Item
for insert as
if (select Rate from inserted) > 1000
	begin
		print 'Rate cannot exceed 1000'
		rollback transaction
	end

insert into Item Values ('01', 'value01', 10000)
 

 create trigger NoUpdateOrderDetails
 on OrderDetails
 for update as
 if (select Qty from inserted) > 100
 begin 
	print 'Cannot assign Qty Greated than 100'
	rollback transaction
end

update OrderDetails
Set Qty =150
where ItemCode = 'RKSK-B' And OrderNo ='0084/99'

create trigger NoDeleteJLT
On Customer
for delete as
if (select CCode From deleted) = 'JLT'
begin
	print 'Cannot delete customer JLT'
	rollback transaction
end

delete from Customer
where CCode ='JLT'

---- Bẫy lỗi dây chuyền (Cascding Triggers)
create trigger DeleteOnItem
on Item
for delete as
begin 
	delete from OrderDetails
	from deleted inner join OrderDetails
	on OrderDetails.ItemCode = deleted.ICode
end

go 
	delete from Item Where Icode = 'RKSK-B'
go
-- khoá khoá ngoại để có thể chạy qua trigger
alter table orderDetails
drop constraint FK_Icode
go
delete from Item Where Icode = 'RKSK-B'


---	
create trigger testMasterDetails
on Customer
for delete 
as
	if exists (select 'true' from deleted
		where CCode In (select A.CCode from deleted A 
		Inner Join OrderMaster B On A.CCode = B.CCode)
		)
		begin
			print 'Cannot delete  this customer'
			rollback transaction
		end

Alter table OrderDetails
Drop Constraint FK_OrderNo
GO
Alter table OrderMaster
Drop constraint FK_CCode
GO
 
delete from customer
where CCode = 'TLT'