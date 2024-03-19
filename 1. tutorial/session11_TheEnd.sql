-- 1. Variables
	-- Ex01:
		declare @code varchar(20)
		set @code = 'RKSK%'

		select *
		from OrderDetails where ItemCode like @code
	-- Ex02.1: Set chỉ cho chạy 1 dòng lệnh
		--declare @num1 int, @num2 int, @sum int
		--set @num1 = 10
		--set @num2 = 20
		--set @sum = @num1 + @num2

		--select @sum as Total

	-- Ex02.2: Select cho phép chạy nhiều dòng lệnh
		declare @num1 int, @num2 int, @sum int
		select @num1 = 100, @num2 = 200
		set @sum = @num1 + @num2

		select @sum as Total
-- 2. Function . phải truy xuất qua DMO
	create function checkMark(@mark int)
	returns varchar(20) as
		begin
			declare @result varchar(20)
			if (@mark >= 40)
				begin
					set @result = 'pass';
				end
			else
				begin
					set @result = 'fail'
				end
			return @result
		end
	go

	select N'Result of DMS examination: ' + dbo.checkMark(75) as result
-- 3. Construct
	declare @code int
	set @code = 65
	while(@code <= 90)
		begin
			print char(@code)
			set @code += 5
			continue
		end
-- 4. Advandced
	-- 4.1. SYNONYM
	create synonym Product
	for Item
	go

	select * 
	from Product
	-- 4.2. Store Procedure with Output
	create procedure spCountItem
	@price int, @count int output
	as
		begin
			set @count = (select Count(*) from Item where Rate <= @price)
			--@count = @@rowcount
		end
	go

	declare @cnt int
	exec spCountItem 500, @cnt output
	select @cnt as 'Total Item'
	go

	drop procedure spCountItem
	-- 4.3. Update Trigger => delete record
	create trigger tgUpDel
	on Item
	for update
	as
		begin
			-- khai báo biến price, code
				declare @price int, @code varchar(20)
			-- gán code = ICode form inserted
				set @code = (select ICode from inserted)
			-- gán price = Rate from inserted
				set @price = (select Rate from inserted)
			-- check @price = 0 ?
				if(@price = 0)
			-- delete record
					begin
						DELETE FROM Item WHERE ICode = @code;
					end

		end


	select *
	from Item

	insert into Item values ('Fpt', 'F P T', 100)
	go 

	select * from Item
	go 
	update Item
	set Rate = 0
	where ICode = 'Fpt'
	go 
	select * from Item