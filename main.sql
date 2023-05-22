-- Create a SQL query that shows non-USA customers by CustomerId, First/LastName and Country

SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE Country <> "USA"

-- Run a SQL Query that returns customers only from Brazil

SELECT *
FROM Customer
WHERE Country = "Brazil"