-- Câu 2
	-- 2.1 Custommer
select Ccode, Cname
from Customer
	-- 2.2. OrderMaster
select * 
from OrderMaster
	-- 2.3. OrderDetail
select OrderNo, ItemCode, Qty
from OrderDetails
	-- 2.4. Item
select *
from Item
	