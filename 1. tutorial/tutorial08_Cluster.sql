create clustered index ix_Cname
on Customer(CName)

create nonclustered index ix_Cname
on Customer(CName)
------------------------
exec sp_helpindex 'Customer'

---------------------
-- 1, Xoá FK_CCode trong OrderMaster
	alter table OrderMaster
	drop constraint FK_CCode 
	go
-- 2. Xoá PK_CCode trong Customer
	alter table Customer
	drop constraint PK_CCode
	go
-- 3. Tạo Cluster Index
	create clustered index ix_CCode
	on Customer(CCode)
	go
-- 4. Tái lập PK_CCode trong Customer
	alter table OrderMaster
	add constraint FK_CCode primary key (CCode)
	go
-- 5. Tái FK_Code trong OrderMaster
	alter table OrderMaster
	add constraint FK_CCode foreign key (CCode) references Customer(CCode)
	go

exec sp_helpindex 'Customer'
------------

create table testCluster(
	col1 int primary key nonclustered,
	col2 int,
	col3 int,
	col4 int
)
go

-- trường col1 phải notclustered mới tạo được cluster
create clustered index ix_col1
on testCluster(col1)

drop index testCluster.ix_col1

-- thay đổi thuộc tính online (cơ chế khoá lại cho 1 user dùng index) của cluster 
alter index ix_col1
on testCluster rebuild with (online = on)

-- cơ chế include trong index: sử dụng index của 1 cột để quản lí những cột lại
create nonclustered index ĩ_col2
on testCluster (col2) include(col1, col4)

exec sp_helpindex 'testCluster'