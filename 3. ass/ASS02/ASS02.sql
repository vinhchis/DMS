--Content
--Exercise 3
--1.Write an SQL to display total of Rucksacks
select SUM(Qty) as Total
from OrderDetails AS D
Inner JOIN Item  ON Item.ICode = D.ItemCode
where ItemName like 'Rucksack%'	

select d.ItemCode, SUM(Qty) as Total
from OrderDetails AS D
group by d.ItemCode
having ItemCode like 'RKSK%'

--2.Write an SQL to display OrderNo, ItemCode, Quantity that the Quanity in the Order is greater or equal than the orthers 

select d.OrderNo, d.ItemCode, d.Qty
from  OrderDetails as d 
where d.Qty = (select max(d.Qty) from OrderDetails as d)


--Exercise 4:
--1.Write an SQL to display Item Code, Item Name and Rate that the rate is greater than rate of STCS-18-M-I”


select Item.ICode, Item.ItemName, item.Rate
from Item
where item.Rate > (select item.Rate
from OrderDetails as d
inner join Item on d.ItemCode = Item.ICode 
where d.ItemCode = 'STCS-18-M-I')
--2.Write an SQL to display Customer Name, Phone, OrderDate, Item Code, Rate and order by Quantity descending 

select c.CName, c.CPhone, Item.ICode, Item.Rate
from Customer as c
inner join OrderMaster as m on c.CCode = m.CCode
inner join OrderDetails as d on m.OrderNo = d.OrderNo
inner join Item on d.ItemCode = Item.ICode
Order By d.Qty DESC