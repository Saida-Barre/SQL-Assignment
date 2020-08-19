-- Selects the count of addresses in each city.
SELECT City, Count(*) 
FROM Address
GROUP BY City;

-- Aggregates collapse large result sets into single values. Examples are count, average, max/min, etc.
-- Aggregates are used in the SELECT portion of the query, as well as the HAVING portion (mentioned later).
-- In order to use an aggregate, the GROUP BY portion must be included, which tells the aggregate how to sort through the data (on which columns).
-- You should not select columns that are not either (a) an aggregate or (b) in the GROUP BY clause when using aggregates. In some implementations of SQL it will error out, in MySQL it will show the first instance of that column which may lead to inaccurate results.
SELECT AccountNumber, COUNT(*) 'Number of Addresses' FROM customer c
INNER JOIN CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN Address a
ON ca.AddressID = a.AddressID
INNER JOIN StateProvince sp
ON a.StateProvinceID = sp.StateProvinceID
GROUP BY AccountNumber;


-- The HAVING clause is very similar to the WHERE clause, except it can operate on aggregates. The WHERE clause runs before the GROUP BY clause, meaning it filters the inputs of the aggregate, while the HAVING clause runs after, meaning it can filter based on the outputs.
SELECT Customer.CustomerID, AVG(Freight) FROM Customer
INNER JOIN salesorderheader 
ON Customer.CustomerID = salesorderheader.CustomerID
WHERE Customer.CustomerID BETWEEN 10 AND 20
GROUP BY Customer.CustomerID
HAVING AVG(Freight) > 100;
-- Displays the average freight paid by customers whose customer ID is between 10 and 20, but only if their average freight is above $100.