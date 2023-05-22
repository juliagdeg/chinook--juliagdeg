-- Create a SQL query that shows non-USA customers by CustomerId, First/LastName and Country

SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE Country <> "USA"

-- Run a SQL Query that returns customers only from Brazil

SELECT *
FROM Customer
WHERE Country = "Brazil"

-- Query for invoices of Brazil customers
SELECT
    c. FirstName,
    c. LastName,
    i. InvoiceDate,
    i. BillingCountry
FROM Invoice i 
    JOIN Customer c ON i.CustomerId = c.CustomerId
WHERE BillingCountry = "Brazil"

-- Query for Employees who hold title of Sales Support Agents
SELECT *
FROM Employee
WHERE Title = "Sales Support Agent"

-- Query for unique list of billing countries
SELECT DISTINCT BillingCountry
FROM Invoice

-- Query to show invoices associated with each sales agent
-- Customer has SalesRepId (connect employee table JOIN customer salesrepId)
-- Invoice table has CustomerId
SELECT
    c. SupportRepId,
    e. FirstName,
    e. LastName,
    i. InvoiceId
FROM Invoice i
INNER JOIN Customer c 
    ON c.CustomerId = i.CustomerId
INNER JOIN Employee e 
    ON e.EmployeeId = c.SupportRepId

-- Query that shows customers and employees associated with each invoice
SELECT
    i. Total,
    c. FirstName || ' ' || c.LastName AS CustomerName,
    c. Country,
    c. SupportRepId,
    e. FirstName || ' ' || e.LastName AS EmployeeName
FROM Invoice i
INNER JOIN Customer c 
    ON c.CustomerId = i.CustomerId
INNER JOIN Employee e 
    ON e.EmployeeId = c.SupportRepId

-- Query for number of invoices in 2009 and 2011 (HINT: use COUNT)
-- SELECT COUNT(InvoiceDate) AS Year
-- FROM Invoice
-- WHERE COUNT(InvoiceDate) IN (2009, 2011)
-- GROUP BY COUNT(InvoiceDate)
SELECT COUNT(*) AS InvoiceCount, strftime('%Y', InvoiceDate) AS Year
FROM Invoice
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY Year

-- Query for total sales for 2009 and 2011
SELECT COUNT(*) AS TotalCount, strftime('%Y', InvoiceDate) AS Year,
    SUM(Total) as TotalSales
FROM Invoice
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY Year

-- Query for # of line items from invoice 37
SELECT COUNT(*) AS InvoiceCount
FROM InvoiceLine
WHERE InvoiceId = '37'

-- Query for # of line items for each invoice
SELECT InvoiceId, COUNT(*) AS InvoiceCount
FROM InvoiceLine
GROUP BY InvoiceId

-- Query for each line item with track name that was purchased
SELECT 
    l. InvoiceLineId,
    t. Name AS TrackName
From InvoiceLine l
INNER JOIN Track t 
    ON t.TrackId = l.TrackId
GROUP BY InvoiceId