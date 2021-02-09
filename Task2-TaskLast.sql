---Task-2----
create table Employee
(
ID int identity primary key ,
Name varchar(20),
Email varchar (20),
Age int,
City nvarchar(30),
DId int Foreign Key References Department(DId)
)
CREATE table Emp_Audit 
(
Id int identity primary key,
Detail nvarchar(100)
)
insert into Employee values('Erum',  'erum124@gmail.com' , 18, 'Karachi', 4 , 'Female' , 8888)
create table Department
(
DId int identity primary key ,
Name nvarchar(20),
FloorNum int
)
select * from Department
select * from Employee


---Task-3----Usage of Operators
select * FROM Employee where City = 'karachi' and Age between 19 and 22

select * FROM Employee where City = 'Lahore' or Age = 18  

select * FROM Employee where Email  like 'a%'  

select * from Employee  where Name like '%a'

select * from Employee  where Name like '%a%'

select * from Employee  where Name like '___m_'

select * from Employee  where Name like '___ma'

select * from Employee  where Name like '_l_'

select * from Employee  where Name like '[a-s]%'

 

select * FROM Department where Age <> 18 


-----Task-5-----------

select * from Employee Where Id 
in(select Id from Employee where Age > 18 )


select * from Employee 
where Id in
(select Id from Employee where City = 'Karachi')

update Employee set Salary = Salary + 30000
where Id in 
(select Id from Employee where City = 'karachi' )
 
 ---InnerJoins---
 Select A.Name , A.Age , B.Name , B.FloorNum from Employee as A
 inner join Department as B
 on A.FId = B.FId

 Select A.Name , A.Age , B.Name , B.FloorNum from Employee as A
 full join Department as B
 on A.FId = B.FId

 Select A.Name , A.Age , B.Name , B.FloorNum from Employee as A
 Right join Department as B
 on A.FId = B.FId

 Select A.Name , A.Age , B.Name , B.FloorNum from Employee as A
 left join Department as B
 on A.FId = B.FId

--update Employee set FId = 6666  Where Id = 6
-----Self Join------ 
create table EmpManager 
(
EmpId int identity primary key,
EmpName nvarchar(40), 
ManagerId int 
)
select * from EmpManager 
truncate table EmpManager
insert into EmpManager 
values( 'Osama' , 2) 
insert into EmpManager
values('Ali' , 4)  
insert into EmpManager
values('Wamiq' , 2) 
insert into EmpManager
values('Shariq' , 0) 
insert into EmpManager
values('Aliyan' , 4) 

select * from EmpManager

select A.EmpName as Employee  , B.EmpName as Manager from EmpManager as A 
inner join EmpManager as B 
on A.ManagerId = B.EmpId

--Task--6----

Alter Table Employee drop column FId   

Alter Table Employee add FId int 

Alter Table Department add FId int 

Alter Table Employee add Salary money 


----Drop--Alter--Truncate----
alter table Employee
add Gender nvarchar(6) ;
truncate table Employee
drop table Employee
drop table Department

---Evaluation--1--
---Task 7
---Stored Procedure---
alter proc spUpdate
@id int,
@email nvarchar(20)
as
update Employee set Email = @email where ID = @id
select * from Employee
Go
exec spUpdate 2 , 'osama55@gmail.com'
--Insert Data StoredProcedure
create proc spInsert
@name nvarchar(20),
@email nvarchar(20),
@age int , 
@City nvarchar(30),
@did int,
@Gender nvarchar(6),
@FId int
as
insert into Employee values (@name,@email,@age,@City,@did,@Gender,@FId)
select * from Employee
Go

exec spInsert @name = 'Huzaifah',
              @email = 'huzaifah1@gmail.com',
              @age = 19 ,
			  @City = 'karachi' ,
			  @did = 1 , 
			  @Gender= 'Male' ,
			  @FId = 7777

---DeleteData SProcedure ---

create proc spDelete
@id int
as
delete Employee where ID = @id
select * from Employee
Go

spDelete 7

---TruncateData SProcedure ---

create proc spTruncate
as
truncate table Employee 
select * from Employee
Go

---Task--8--
create view vWShowSome
as
Select A.Email , A.City , A.Gender , B.Name , B.FloorNum from Employee as A
inner join Department as B
on B.DId = A.DId

select * from vWShowSome 

create view vWShowmini
as
Select A.Email , A.City , A.Gender , B.Name , B.FloorNum from Employee as A
inner join Department as B
on B.DId = A.DId
where B.Name = 'IT'

select * from vWShowmini 

sp_helptext vWShowmini
----
create view vWmyemp
as
select * from Employee
----
select * from vWmyemp
insert into vWmyemp values('Ibrahim','ibrahim123@gmail.com',22,'Islamabad',4,'Male',7777) 
update vWmyemp set Email = 'ibrahim44@gmail.com' where ID = 8;
delete vWmyemp where ID = 8
---

----Task -10 Triggers-------

alter trigger InsertinEmployee
on Employee
after insert 
as
begin
declare @id int
select @id = ID from inserted

insert into Emp_Audit values('The Record has been inserted from this Id :  ' +  Cast(@id as varchar(50)) + 'On this Time' + Cast(GETDATE() as varchar(50)) )
select * from Employee
print('Your Record Has benn Inserted');
end
 












------Task-11-- Builtin Functions 

select City, Count(ID) as [TotalRecord] from Employee 
group by City

select Min(Age) as [MinimumAge] from Employee 

select Max(Age) as [MaximumAge] from Employee 

select Avg(Age) as [AverageAge] from Employee 

---Task 11-- User define Scalar Functions it can accept multiple parameters but return scalar single value

create function FindPercent
(
@PercentFig int ,
@YourAmount int
)
returns dec(10,2)
as 
begin
return ( @YourAmount * @PercentFig / 100)
end 

select dbo.FindPercent(620 ,85)

select   reverse (ID) from Employee

select   reverse (Name) from Employee 

select   upper (Name) from Employee 

select * from dbo.Emp_Audit


 --Task 13 -- Temp Table
use [InternshipTaskDb]
select * from Department select * from Employee

---Local TempTable
create table #EmpTempTable (Name nvarchar(20), Gender nvarchar(6))
select * from #EmpTempTable
insert into #EmpTempTable (Name,Gender)
select Name , Gender from Employee   
drop table #EmpTempTable

---Global TempTable--- it works on new Connection
create table ##MyTempTable (DepartmentId int ,Name nvarchar(30))
select * from ##MyTempTable
insert into ##MyTempTable (DepartmentId , Name) 
select DId , Name from Department
drop table ##MyTempTable


alter proc spTemptableEmp
as
insert into #EmpTempTable (Name, Gender)
select Name,Gender from Employee
select * from #EmpTempTable 
go
truncate table #EmpTempTable
exec spTemptableEmp

-----------------------------------------------
--While Loop
declare @count int
set @count  = 1 
while(@count <= 9)
begin
print @count
set @count = @count + 1  
end

declare @count int
set @count = 1
declare @pagesize int = 2
while(@count < 10)
begin 
select * from Employee 
order by ID
offset @count rows
fetch next @pagesize row only
set @count = @count + 2
end
select * from Employee

create table EmpforCursor
(
Id int identity ,
Name nvarchar(50)
)

------Cursor-----
Declare @Name nvarchar(20)
Declare @Age int  
Declare EmployeeCursor Cursor for   
select Name , Age from Employee

open EmployeeCursor

fetch next from EmployeeCursor into @Name , @Age
while(@@FETCH_STATUS = 0)
begin 
print 'Name = ' + @Name + ' Age = ' +  Cast(@Age as nvarchar)   
fetch next from EmployeeCursor into @Name , @Age
end
close EmployeeCursor 
deallocate  EmployeeCursor

---insert -into another table using cursor
declare @Name nvarchar(50)
declare EmpDptCursor Cursor local for    
(
select Name from Employee  
)
open EmpDptCursor 

fetch next from EmpDptCursor into @Name 
while(@@FETCH_STATUS = 0)
begin 
insert into EmpforCursor (Name) values(@Name)

fetch next from EmpDptCursor into @Name 
end
close EmpDptCursor
deallocate  EmpDptCursor 

select * from EmpforCursor

 
----CTE-----
With EmpCte (Name,Gender)
as
(
select Name ,Gender from Employee 
)

WITH EmplyeeCTE ( Name ,DeptId , CountDept)
as 
(
select B.Name , B.DId , Count(A.ID) as TotalEmployee from Employee as A 
join Department as B 
on A.DId = B.DId
group by B.Name, B.DId
)
select  Name , DeptId , CountDept from EmplyeeCTE

select * from Employee
--Table Variable---
declare @EmpTableVariable table ( Name nvarchar(20) , Age int)

insert into @EmpTableVariable (Name,Age)
select Name , Age from Employee
select * from @EmpTableVariable

--Pivot---We use this when we rotate the table column level into row level
create table Sales 
(
Id int identity primary key,
Name nvarchar(50),
Sales money ,
SalesYear int 
)
drop table Sales
select * from Sales
insert into Sales values('Amir' , 75500 , 2020)
insert into Sales values('Shimq' , 85500 ,2019 )
insert into Sales values('Osama' , 65500, 2020)
insert into Sales values('Amir' , 50500, 2018)
insert into Sales values('Shimiq' , 45000,2018)
insert into Sales values('Osama' , 35000, 2019)
insert into Sales values('Shamiq' , 55000, 2020)
insert into Sales values('Osama' , 80000, 2018)
insert into Sales values('Amir' , 55000, 2018)

----Using Derived Table
Select SalesYear,Osama,Amir,Shamiq 
from 
(
select Name, Sales, SalesYear from Sales
)as MySalesTbl
Pivot
(
SUM(Sales) 
for Name 
in (Osama,Amir,Shamiq)
   
)as Tab
order by SalesYear


create table  Fees 
(
Id int identity primary key,
ReceiptNo bigint,
Ammount money ,
Subdate date 
)
select * from Fees

insert into Fees values(0011, 5000,'06/11/2020')

insert into Fees values(0012, 6000,'2020/12/22')

insert into Fees values(0013, 5500,'2020/11/23')
insert into Fees values(0014, 6000,'2020/11/24')
insert into Fees values(0015, 6000,'2020/10/25')
insert into Fees values(0016, 5000,'2020/12/26')
insert into Fees values(0017, 6500,'2020/12/27')
insert into Fees values(0018, 6500,'2020/12/28')
 






