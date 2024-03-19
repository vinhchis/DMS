use master
go
if EXISTS  (select name from .sysdatabases where name = 'AirCraft')
drop database AirCraft
go

create database AirCraft
on (
	name = AirCraft.dat,
	filename = 'D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\ass\3',
	size = 10MB,
	maxsize = 100MB,
	filegrowth = 5MB
)
go
use AirCraft
go

alter database AirCraft
add filegroup MyGroup

create table Customer (
	First_Name varchar(10) NOT NULL,
	Last_Name varchar(20),
	Address varchar(50) default('Unknown'),
	City varchar(50) default('Mumbai'),
	Country varchar(12),
	Birthdate datetime
)

go
insert into Customer(First_Name, Last_Name, Birthdate)
values 
('1A', '1B', '2010/1/1'),
('2A', '2B', '2010/2/2'),
('3A', '3B', '2020/3/3')
go
select * 
from Customer