create database StudentDB
ON (
	name = StudentDB,
	filename = 'D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\LAB\LAB04\Student_Dat.MDF',
	size = 10MB,
	maxsize = 100MB,
	filegrowth = 1MB
)
go
LOG on (
	name = Student_Log,
	filename ='D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\LAB\LAB04\Student_Log.LDF',
	size = 5MB,
	maxsize = 25MB,
	filegrowth = 1MB
)
go
-- Remove Log File
--ALTER DATABASE studentDB  
--remove file studentDB_Log

--ALTER DATABASE studentDB   
--ADD LOG FILE  (
--	name = Student_Log,
--	filename ='D:\workspaces\src\projects\fpt-apteach\SEM-01\DMS\LAB\LAB04\Student_Log.LDF',
--	size = 5MB,
--	maxsize = 25MB,
--	filegrowth = 1MB
--)

-- Add File Group
use StudentDB
go

alter database StudentDB
add filegroup MyGroup
go

-- 4. Tạo bảng Student
create table Student(
	EnrollNo varchar(20),
	StudentName	varchar(50),
	Email varchar(50),
	Phone varchar(12)
)
go

-- 4. Đổi tên Database StudentDB thành SchoolDB
alter database StudentDB
modify name = SchoolDB
go

-- 5. Thêm trường FirstName và LastName vào bảng Student
alter table Student
add FirstName varchar(50),
	LastName varchar(50)
go

-- 6. Xoá trường StudentName trong bảng Student
alter table Student
drop column StudentName
go

-- 7. Thay đổi mô tả trường trong bảng
alter table Student
alter column EnrollNo varchar(20) not null
go

-- 8. Thêm ràng buộc khoá
alter table Student
add constraint PK_EnrollNo Primary Key (EnrollNo)
go

insert into Student (EnrollNo, FirstName)
values ('1', 'Chi')
go
insert into Student (EnrollNo, FirstName)
values ('1', 'Chi')
go

-- 9. Tạo ràng buộc khó chính, khoá ngọi ngay khi tạo bảng
create table Exam(
	ECode varchar(20) constraint PK_ECode primary key,
	EDate varchar(12),
	Student varchar(20) constraint FK_EnrollNo foreign key 
						references Student(EnrollNo)
)
go

insert into Exam
values ('E110220-1400', '11/03/2023', '102')
go
-- 10. Xoá ràng buộc FK_EnrollNo, PK_ECode
alter table Exam
drop constraint FK_EnrollNo
go

alter table Exam
add constraint FK_EnrollNo 
foreign key (Student)
references Student(EnrollNo)
go

alter table Exam
drop constraint PK_ECode
go

alter table Exam
add constraint PK_ECode
primary key (ECode)
go

select *
from Student
