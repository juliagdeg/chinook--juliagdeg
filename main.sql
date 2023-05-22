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