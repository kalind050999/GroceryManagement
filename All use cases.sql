-- use case 1
CREATE VIEW highest_sales AS
    SELECT 
        invoice.invoice_id,
        invoice.product_number,
        invoice.invoice_date,
        product.product_number AS productnumber,
        product.product_discount
    FROM
        invoice
            INNER JOIN
        product
    WHERE
        invoice.product_number = product.product_number;
    
SELECT DISTINCT
    invoice_id AS InvoiceID, product_discount AS Discount
FROM
    highest_sales
WHERE
    invoice_date BETWEEN '2015-09-01' AND '2020-09-01'
        AND product_number = '1808';

-- use case 2

CREATE VIEW employeeofthemonth AS
    SELECT 
        employeee.employee_id,
        invoice.invoice_id,
        invoice.invoice_date
    FROM
        employeee
            INNER JOIN
        invoice
    WHERE
        employeee.employee_id = invoice.employee_id;

SELECT 
    employee_id AS EmployeeID, COUNT(*) AS InvoiceGenerated
FROM
    employeeofmonth
WHERE
    invoice_date BETWEEN '2015-09-01' AND '2020-09-01'
GROUP BY employee_id;

-- use case 3

CREATE VIEW profitloss AS
    SELECT 
        product.product_name,
        product.product_mp,
        product.product_sp,
        product.product_number,
        product.product_id,
        invoice.invoice_date,
        invoice.invoice_id,
        product.product_sp - product.product_mp as profitlosss
    FROM
        product
            INNER JOIN
        invoice
    WHERE
        product.product_number = invoice.product_number
			AND invoice_date BETWEEN '2015-09-01' AND '2020-09-01' ;
            
SELECT 
	SUM(profitlosss) AS ProfitORLoss
FROM
    profitloss
WHERE
    product_number = '1808'
GROUP BY product_id , product_name;

-- use case 4

CREATE VIEW customerorders AS
    SELECT 
        customer.customer_id AS CustomerID,
        customer.customer_firstname AS Name,
        invoice.invoice_total AS TotalSales,
        invoice.invoice_date AS BillingDate
    FROM
        customer
            INNER JOIN
        invoice
    WHERE
        customer.customer_id = invoice.customer_id
        AND invoice_date BETWEEN '2015-09-01' AND '2020-09-01'
        order by invoice_total desc;

SELECT 
    *
FROM
    customerorders;

-- use case 5

CREATE VIEW employeejoining AS
    SELECT 
        employeee.employee_id,
        employeee.employee_first_name,
        employeee.employee_joining,
        invoice.invoice_id,
        invoice.invoice_date
    FROM
        employeee
            INNER JOIN
        invoice
    WHERE
        employeee.employee_id = invoice.employee_id;

SELECT 
    employee_id AS EmployeeID,
    employee_first_name AS Name,
    COUNT(*) AS InvoicesGenerated
FROM
    employeejoining
WHERE
    employee_joining BETWEEN '2015-01-01' AND '2020-12-31'
GROUP BY employee_id;

-- use case 6

CREATE VIEW productcategorysales AS
    SELECT 
        product.product_category,
        product.product_number,
        product.product_id,
        invoice.product_number as invoiceproductnumber,
        invoice.invoice_id,
        invoice.invoice_total,
        invoice.product_name
    FROM
        product
            INNER JOIN
        invoice
    WHERE
        product.product_number = invoice.product_number;

SELECT 
    invoiceproductnumber AS ProductNumber,
    invoice_id AS InvoiceID,
    product_name AS Name,
    invoice_total AS TotalSales
FROM
    productcategorysales
ORDER BY invoice_total DESC;

SELECT 
    SUM(invoice_total) AS InvoiceTotal,
    invoiceproductnumber AS ProductNumber,
    invoice_id AS InvoiceID,
    product_name AS Name,
    invoice_total AS TotalSales
FROM
    productcategorysales
WHERE
    invoice_id = '123'
ORDER BY invoice_total DESC;

-- use case 7

CREATE VIEW customeractive AS
    SELECT 
        customer.customer_id,
        customer.customer_firstname,
        customer.customer_joining,
        invoice.invoice_id,
        invoice.invoice_date,
        invoice.product_name
    FROM
        customer
            INNER JOIN
        invoice
    WHERE
        invoice.customer_id = customer.customer_id;
        
SELECT 
    customer_id AS CustomerID,
    invoice_id AS InvoiceID,
    customer_firstname AS Name,
    DATEDIFF(invoice_date, customer_joining) AS DateDifference
FROM
    customeractive
ORDER BY DateDifference DESC;

-- use case 8

CREATE VIEW productgrowth AS
    SELECT 
        product.product_number,
        product.product_name,
        invoice.invoice_id,
        invoice.invoice_date,
        invoice.invoice_total
    FROM
        product
            INNER JOIN
        invoice
    WHERE
        product.product_number = invoice.product_number;
        
SELECT 
    product_name AS Name,
    SUM(invoice_total) AS TotalSales,
    invoice_date AS InvoiceDate
FROM
    productgrowth
WHERE
    invoice_date BETWEEN '2015-01-01' AND '2020-12-31'
        AND product_name = 'tropical fruit'
GROUP BY invoice_date;

SELECT 
    product_name AS Name,
    SUM(invoice_total) AS TotalSales,
    invoice_date AS InvoiceDate
FROM
    productgrowth
WHERE
    invoice_date BETWEEN '2005-01-01' AND '2015-12-31'
        AND product_name = 'tropical fruit'
GROUP BY invoice_date;

-- use case 9

CREATE VIEW productdiscount AS
    SELECT 
        product.product_number,
        product.product_name,
        product.product_discount,
        invoice.invoice_id,
        invoice.invoice_date,
        invoice.invoice_total
    FROM
        product
            INNER JOIN
        invoice
    WHERE
        product.product_number = invoice.product_number;
        
SELECT 
    product_number AS Number,
    product_name AS Name,
    product_discount AS Discount,
    invoice_total AS TotalSales,
    invoice_date AS InvoiceDate
FROM
    productdiscount
WHERE
    invoice_date BETWEEN '2005-01-01' AND '2015-12-31'
        AND product_name = 'whole milk'
        AND product_discount = 0;
 
 SELECT 
    product_number AS Number,
    product_name AS Name,
    product_discount AS Discount,
    invoice_total AS TotalSales,
    invoice_date AS InvoiceDate
FROM
    productdiscount
WHERE
    invoice_date BETWEEN '2005-01-01' AND '2015-12-31'
        AND product_name = 'whole milk'
        AND product_discount > 0;
        
-- use case 10

CREATE VIEW employeesatisfaction AS
    SELECT 
        employeee.employee_id,
        employeee.employee_first_name,
        employeee.employee_satisfaction,
        invoice.invoice_id,
        invoice.invoice_total
    FROM
        employeee
            INNER JOIN
        invoice
    WHERE
        employeee.employee_id = invoice.employee_id;
 
 SELECT DISTINCT
    employee_id AS EmployeeID,
    invoice_id AS InvoiceID,
    employee_first_name AS Name,
    SUM(invoice_total) AS TotalSales,
    employee_satisfaction AS EmployeeRating
FROM
    employeesatisfaction
WHERE
    employee_satisfaction < 2
GROUP BY invoice_id; 

SELECT DISTINCT
    employee_id AS EmployeeID,
    invoice_id AS InvoiceID,
    employee_first_name AS Name,
    SUM(invoice_total) AS TotalSales,
    employee_satisfaction AS EmployeeRating
FROM
    employeesatisfaction
WHERE
    employee_satisfaction > 2
GROUP BY invoice_id; 



