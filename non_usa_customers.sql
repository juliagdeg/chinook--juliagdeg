-- Create a SQL query that shows non-USA customers by CustomerId, First/LastName and Country

SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE Country <> "USA"