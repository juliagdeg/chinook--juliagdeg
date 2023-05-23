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