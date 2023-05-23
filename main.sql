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

-- Query for each line item purchased with track name AND name of artist
SELECT 
    l. InvoiceLineId,
    t. Name AS TrackName,
    a. Name AS ArtistName
FROM InvoiceLine l 
INNER JOIN Track t ON l.TrackId = t.TrackId
INNER JOIN Album al ON t.AlbumId = al.AlbumId
INNER JOIN Artist a ON al.ArtistId = a.ArtistId
GROUP BY InvoiceLineId

-- Query for total # of invoices per country
SELECT BillingCountry, COUNT(*) AS TotalInvoices
FROM Invoice
GROUP BY BillingCountry

-- Query for total # of tracks in each playlist
SELECT p.Name AS PlaylistName, COUNT(pt.TrackId) AS TotalTracks
FROM Playlist p
INNER JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId, p.Name

-- Query to show all tracks but no IDs
SELECT DISTINCT
    a. Title AS AlbumName,
    m. Name AS MediaType,
    g. Name AS Genre
FROM Track t
INNER JOIN Album a ON t.AlbumId = a.AlbumId
INNER JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId
INNER JOIN Genre g ON t.GenreId = g.GenreId

-- Query for all invoices w InvoiceId and total line items on each invoice
-- SELECT DISTINCT 
--     i. InvoiceId AS AllInvoices, 
--     l. InvoiceId, COUNT(*) AS TotalLineItems
-- FROM Invoice i
-- GROUP BY l. InvoiceId
SELECT
  i.InvoiceId,
  COUNT(il.InvoiceLineId) AS TotalLineItems
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId

-- Query for total sales made by sales agent
SELECT
    e. FirstName,
    e. LastName, 
    SUM(i.total)
FROM Employee e 
JOIN Customer AS c on c.SupportRepId = e.EmployeeId
JOIN Invoice AS i on i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId

-- Query to show which sales agent made the most sales in 2009
-- use the MAX function on this subquery
-- first line selects what values we want shown in the SQL database
SELECT MAX(TotalSales) as TotalSales, EmployeeName
FROM
-- SELECTING the Employee's name by joining the First/Last columns
-- then we want to COUNT the number of InvoiceIds as the TotalSales
    (SELECT
        (e.FirstName || ' ' || e.LastName) AS EmployeeName,
        COUNT(i.InvoiceId) as TotalSales
    FROM Employee e
    -- we need to match the EmployeeId to the SupportRepId to narrow the title results
    JOIN Customer c ON e.EmployeeId = c.SupportRepId
    -- then we need to JOIN the Invoice customer foreign column with the root Customer column
    JOIN Invoice i ON i.CustomerId = c.CustomerId
    -- here we specify what values we need to specify, like the year property 2009
    WHERE (i.InvoiceDate LIKE '2009%')
    -- to group by employee and return the employee with the most sales that year, we group by Employee from that table
    GROUP BY EmployeeName)

-- Query to show top sales rep over all
SELECT 
    e. FirstName || ' ' || e. LastName AS EmployeeName, SUM(i.Total) as TotalSales
FROM Employee e 
JOIN Customer AS c ON c.SupportRepId = e.EmployeeId
JOIN Invoice AS i ON i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1

-- Query to show how many customers are assigned to each employee
SELECT
    e. FirstName || ' ' || e. LastName AS EmployeeName, COUNT(c.CustomerId) as TotalAssignedCustomers
FROM Employee e 
JOIN Customer AS c ON c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId
ORDER BY TotalAssignedCustomers DESC

-- Query to show total sales per country
SELECT BillingCountry, COUNT(InvoiceId) as TotalSalesPerCountry
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalSalesPerCountry

-- Query to show which country spent the most
SELECT MAX(TopCountrySales) as TopCountrySales, BillingCountry
FROM
(SELECT
    BillingCountry,
    COUNT(InvoiceId) AS TopCountrySales
    FROM Invoice
    GROUP BY BillingCountry)

-- Query to show most purchased tracks of 2013
SELECT t.Name AS TrackName, COUNT(il.InvoiceLineId) as PurchasedCount
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY t.Name
ORDER BY PurchasedCount DESC
LIMIT 1

-- Query to show top 5 tracks purchased overall
SELECT
    t.Name AS TrackName, SUM(i.Total) as TotalSales
FROM Track t 
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY t.Name
ORDER BY TotalSales DESC
LIMIT 1