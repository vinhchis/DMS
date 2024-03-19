
-- R1
use master
go

if exists (select name from .sysdatabases where name = 'MusicDB')
drop database MusicDB
go

create database MusicDB
ON
(
	name = Music_dat,
	filename = 'D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\REVIEW\data\Music_dat.mdf',
	size = 20MB,
	maxsize = 200MB,
	filegrowth = 20MB
)
LOG ON 
(
	name = Music_log,
	filename = 'D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\REVIEW\data\Music_log.ldf',
	size = 50MB,
	maxsize = 250MB,
	filegrowth = 20MB
)
go

use MusicDB
go

alter database MusicDB
add filegroup SavedGroup
go

-- R2
create table Categories(
	CateID int not null,
	CateName varchar(15),
	Description varchar(100)
)
go

insert into Categories
values
	(1, 'Categories-01', 'this is first categories'),
	(2, 'Categories-02', 'this is second categories'),
	(3, 'Categories-03', 'this is thirst categories'),
	(4, 'Categories-04', 'this is fourth categories'),
	(5, 'Categories-05', 'this is firth categories')
go
-- R3
create table Albums(
	AlbumID int not null,
	Title varchar(20),
	CateID int,
	CoverImage varchar(250),
	ShortDescription varchar(100),
	Price int,
	Edition int
)
go

insert into Albums
values
	(1, 'Ablum A', 1, 'https://google/img/a1.png', 'this is  A ablum', 20000, 1),
	(2, 'Ablum B', 1, 'https://google/img/a2.png', 'this is  B ablum', 10000, 0),
	(3, 'Ablum C', 2, 'https://google/img/a3.png', 'this is  C ablum', 120000, 1),
	(4, 'Ablum D', 4, 'https://google/img/a4.png', 'this is  D ablum', 40000, 0),
	(5, 'Ablum E', 5, 'https://google/img/a5.png', 'this is  E ablum', 60000, 1)
go


-- R4
alter table Categories
add constraint PK_CateID primary key (CateID) 
go

-- R5
alter table Albums
add constraint PK_AlbumID primary key (AlbumID)
go

alter table Albums
add constraint FK_CateID foreign key (CateID) 
references Categories (CateID)
go

ALTER TABLE Albums
ADD CONSTRAINT CHK_PriceZero CHECK (Price > 0);
go

ALTER TABLE Albums 
ADD CONSTRAINT DF_Edition DEFAULT (1) FOR Edition;

-- R6
alter table Albums
drop constraint FK_CateID
go

alter table Categories
drop constraint PK_CateID
go

create clustered index IX_CateID
on Categories(CateID) 
WITH (ONLINE = ON)
go

--exec sp_helpindex 'Categories'

alter table Categories
add constraint PK_CateID primary key (CateID)
go

alter table Albums
add constraint FK_CateID foreign key (CateID) 
references Categories (CateID)
go

-- R7
CREATE VIEW vInfo AS
SELECT AlbumID, Title, CateName, CoverImage, Price, Edition
FROM Albums as A inner join Categories as C
on A.CateID = C.CateID
go

--select *
--from vInfo

-- R8
CREATE PROCEDURE sp_AlbumInfo
@AlbumID int
AS
begin
	select * 
	from Albums
	where AlbumID = @AlbumID
	
	update Albums
	set Price = Price*1.1
	where AlbumID = @AlbumID

	select * 
	from Albums
	where AlbumID = @AlbumID
end
go

 -- EXEC  sp_AlbumInfo 2
 
--R9
CREATE TRIGGER tg_nonDelte
ON Categories
for delete
as
	begin
		if exists (select * from deleted as C inner join Albums as A on C.CateID = A.CateID)
		begin
			print ('You can not delelte this category because some album that belong this category are...')
			rollback transaction
		end
	end
go

alter table Albums
drop constraint FK_CateID
go

--delete from Categories
--where CateID = 3
--go

alter table Albums
add constraint FK_CateID foreign key (CateID) 
references Categories (CateID)
go

