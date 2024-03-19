/*
	Merge Data
	- Commom Fields
	- Filter
	- Join
*/

-- Exercise 1 
	--- Question a : OrderNo, OrderDate, Customer Name, Item Name from the tables 
	select m.OrderNo, m.OrderDate, c.CName, ItemName
	from OrderDetails as d, OrderMaster as m, Item, Customer as c
	where d.OrderNo = m.OrderNo and
		c.CCode = m.CCode and
		Item.ICode = d.ItemCode
	--- Question b : Customer Code, Name and Address. Get more Item Name, Quantity and Amount 
	select c.CCode, c.CName, c.CAddress, Item.ItemName, d.Qty, (d.Qty*Item.Rate) AS Amount
	from OrderDetails as d, OrderMaster as m, Item, Customer as c
	where d.OrderNo = m.OrderNo and
		c.CCode = m.CCode and
		Item.ICode = d.ItemCode
	--- Question c : OrderNo, OrderDate, Item Name, Quantity and order by OrderDate
	select m.OrderNo, m.OrderDate, Item.ItemName, d.Qty
	from OrderDetails as d, OrderMaster as m, Item
	where d.OrderNo = m.OrderNo and
		Item.ICode = d.ItemCode
	order by m.OrderDate asc
	--- Question d : Item Code, Item Name and discount (20%) 
	select Item.ICode, ItemName, Rate*0.8 AS Rate
	from Item
-- Exercise 2 
	-- 1. Write an SQL to display the following information: OrderNo, OrderDate, Item Code and Item Rate 
	-- 2. Write an SQL to display: Customer Name, Item Code, OrderNo which Item Quantity is less than 50 Rucksacks 
	-- 3. Write an SQL to display: Customer ‘TLT’ OrderNo, OrderDate, Item Code, and Amount 