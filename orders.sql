-- The ORDER BY clause allows you to determine in what order the resultset is displayed.

-- Sort SalesOrders by subtotal (ascending - default):
-- To explicitly state ascending use ASC.
SELECT * FROM salesorderheader
ORDER BY SubTotal;

-- Same thing by descending:
SELECT * FROM salesorderheader
ORDER BY SubTotal DESC;

-- Order by multiple columns:
SELECT * FROM contact
WHERE Title = 'Ms.'
ORDER BY FirstName ASC, LastName ASC;
-- If you don't specify multiple columns and you have duplicate values, the order isn't necessarily always going to be the same.
