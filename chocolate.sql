#1. Show the tables in our database.
show tables;

#2. Describe the Sales table.
desc sales;
#It has 7 columns of different data types.

#3. Display all the columns of Sales Table.
select * 
from sales;

#4. Display SaleDate,Amount and Customers from Sales table.
select SaleDate,Amount,Customers
from sales;

#5. What is the amount per box of chocolates.
select SaleDate,Amount,Boxes,Amount/Boxes as 'Amount per Box'
from sales;

#6. Display the sales with amount greater than 10000.
select * 
from sales
where amount > 10000;

#7. Display sales with amount greater than 10000 in descending order.
select *
from sales
where amount > 10000
order by amount desc;

#8. Display sales of G1.Order by PID in ascending and amount in descending order.
select *
from sales 
where  GeoID = 'G1'
order by PID,Amount desc;

#9. Display Sales with amount greater than 10000 on and after 1st Jan 2022. 
select *
from sales
where amount > 10000
and SaleDate >= '2022-01-01';

#10. Display highest to lowest sales with amount greater than 10000 in year 2022.
select SaleDate,amount
from sales
where amount > 10000 
and year(SaleDate)=2022
order by amount desc;

#11. Display sales with boxes less than or equal to 50.
select *
from sales
where Boxes
between 0 and 50;

#12. Display Amount and Boxes sold on Friday.
#shipments on friday(0-monday,6-sunday)
select SaleDate,Amount,Boxes,weekday(SaleDate) as 'Weekday' 
from sales
where weekday(SaleDate) = 4;

select *
from people;

#13. Display records for Delish and Jucies.
select *
from people
where team = 'Delish'
or team = 'Jucies';

#Alternate way
select * 
from people
where team in ('Delish','Jucies');

#14. Display records of Salesperson whose names begin with 'B'.
select *
from people
where Salesperson like 'B%';

#15. Display records of Salespeople whose name contains 'b'.
select *
from people
where Salesperson like '%B%';

#16. Create Amount Category with amount less than 1000 as 'under 1k',less than 5000 as 'under 5k',
#less than 10000 as 'under 10k' and others as '10k or more'.
select SaleDate,Amount,
case  when amount < 1000 then 'Under 1k'
      when amount < 5000 then 'Under 5k'
      when amount < 10000 then 'Under 10k'
	else '10k or more'
end as 'Amount category'
from sales;

#17. Display Sales data with person name.
select p.Salesperson,s.SPID,s.SaleDate,s.Amount
from sales s
join people p
on s.SPID=p.SPID;

#18. Display sales data along product names.
select s.SaleDate,s.Amount,pr.Product
from sales s
left join products pr
on pr.pid=s.pid;

#19. Display sales with person and product names.
select p.Salesperson,s.SPID,s.SaleDate,s.Amount,pr.Product,p.team
from sales s
join people p
on s.SPID=p.SPID
left join products pr
on pr.pid=s.pid;

#20. Display sales with person and product names with amount under 500. 
select p.Salesperson,s.SPID,s.SaleDate,s.Amount,pr.Product,p.team
from sales s
join people p
on s.SPID=p.SPID
left join products pr
on pr.pid=s.pid
where s.Amount < 500;

#21. Display sales with person and product names with amount under 500 in team Delish.
select p.Salesperson,s.SPID,s.SaleDate,s.Amount,pr.Product,p.team
from sales s
join people p
on s.SPID=p.SPID
left join products pr
on pr.pid=s.pid
where s.Amount < 500
and p.Team='Delish';

#22. Display sales with person and product names with amount under 500 and team is null.
select p.Salesperson,s.SPID,s.SaleDate,s.Amount,pr.Product,p.team
from sales s
join people p
on s.SPID=p.SPID
left join products pr
on pr.pid=s.pid
where s.Amount < 500
and p.Team = '';

#23. Display sales with person,product and geography having amount under 500,team null and geography as New Zealand or India.
select p.Salesperson,s.SPID,s.SaleDate,s.Amount,pr.Product,p.team,g.Geo
from sales s
join people p
on s.SPID=p.SPID
left join products pr
on pr.pid=s.pid
join geo g 
on g.GeoID=s.GeoID
where s.Amount < 500
and p.Team = ''
and g.Geo in ('New Zealand','India');

#24. Display sum and average of amount and sum of boxes for each geoid.
select geoID,sum(amount) as 'Total Amount',avg(amount) as 'Average Amount',sum(boxes) as 'Total Boxes'
from sales
group by GeoID;

#25. Display sum and average of amount and sum of boxes in each Country.
select g.geo,sum(amount) as 'Total Amount',avg(amount) as 'Average Amount',sum(boxes) as 'Total Boxes'
from sales s
join geo g
on s.GeoID=g.GeoID
group by g.GeoID; 

#26. Display total amount and boxes from each category and team.
select pr.Category,p.Team,sum(boxes) as 'Total Boxes',sum(amount) as 'Total Amount'
from sales s
join people p
on p.spid=s.spid
join products pr
on pr.pid=s.pid
where p.team <> ''
group by pr.category,p.team
order by pr.Category,p.Team;

#27. Display total amount for top 10 products.
select pr.Product,sum(s.amount) as 'Total Amount'
from sales s
join products pr
on pr.pid=s.pid
group by pr.Product
order by 'Total Amount' desc
limit 10;

#28. Print details of shipments (sales) where amounts are > 2,000 and boxes are < 100?
select *
from sales
where Amount > 2000
and Boxes < 100;

#29. How many shipments (sales) each of the sales persons had in the month of January 2022?
select p.Salesperson,month(s.SaleDate) as 'Month',year(SaleDate) as 'Year',count(s.Customers) as 'Customers',sum(s.Amount) as 'Total Amount',sum(s.Boxes) as 'Total Boxes'
from sales s
join people p
on s.SPID=p.SPID
where month(s.SaleDate) = 1
and year(s.SaleDate) = 2022
group by p.Salesperson
order by count(s.Customers) desc;

#30. Which product sells more boxes? Milk Bars or Eclairs?
select pr.Product,sum(s.Boxes) as 'Total Boxes'
from sales s
join products pr
on s.pid=pr.pid
where pr.Product in ('Milk Bars','Eclairs')
group by pr.Product;
#Eclairs sells more boxes.

#31. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select pr.product,sum(s.boxes) as 'Total Boxes'
from sales s
join products pr
on s.pid=pr.pid
where pr.product in ('Milk Bars','Eclairs')
and date(s.SaleDate) 
between '2022-02-01' 
and '2022-02-07'
group by pr.product;
#Eclairs sold more boxes in 1st week of Feb 2022.

#32. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select *,
case when weekday(saledate)=2 then 'Yes'
     else 'No'
end as 'Wed Shipment'
from sales
where customers < 100 and boxes < 100;

#33. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select p.Salesperson,s.SaleDate,sum(s.Amount) as 'Total Amount'
from sales s
join people p
on s.spid=p.spid
where s.SaleDate 
between '2022-01-01' and '2022-01-07';

#34. Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.Salesperson
from people p
where p.spid not in
(select distinct s.spid from sales s where s.SaleDate between '2022-01-01' and '2022-01-07');

#35. How many times we shipped more than 1,000 boxes in each month?
select year(saledate) 'Year', month(saledate) 'Month', count(*) 'Times we shipped 1k boxes'
from sales
where boxes > 1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate); 

#36. India or Australia? Who buys more chocolate boxes on a monthly basis?
select year(s.saledate) 'Year', month(s.saledate) 'Month',
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) 'India Boxes',
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) 'Australia Boxes'
from sales s
join geo g 
on g.GeoID=s.GeoID
group by year(s.saledate), month(s.saledate)
order by year(s.saledate), month(s.saledate);
