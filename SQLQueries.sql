select count(distinct invoice_id), product_id
from invoice
where product_id = '1808'
and invoice_date between '2007-01-23' and 2020-12-12;

select product_id, product_discount
from product
order by product_discount desc;

create view employeeofmonth as
select employeee.employee_id, employeee.employee_first_name, invoice.invoice_id, invoice.invoice_date
from employeee, invoice
where employeee.employee_id = invoice.employee_id;

select count(employee_id), employee_first_name, invoice_id
from employeeofmonth
where invoice_date between '2020-01-23' and 2020-12-12 group by employee_id;


create view pl as
select product.product_name, product.product_mp, product.product_sp, product.product_id, invoice.invoice_date,
product.product_sp - product.product_mp as pl
from product, invoice;

select sum(pl) from pl where product_id = '1808' group by product_id, product_name;
select sum(pl) from pl where product_id = '1187' group by product_id, product_name;


create view customerhighest1 as
select customer.customer_id, customer.customer_firstname, invoice.invoice_total, invoice.invoice_date
from customer, invoice
where customer.customer_id = invoice.invoice_id
and invoice.invoice_date between '2002-09-31' and '2020-10-31';

select * from customerhighest1;

create view discount as
select product.product_id, product.product_name, product.product_discount,
product_price - product_discount as productwithdiscount
from invoice, product
where invoice.invoice_date between '2002-09-31' and '2020-10-31';

select sum(productwithdiscount) from discount where product_id = '1808' group by product_id, product_name;


