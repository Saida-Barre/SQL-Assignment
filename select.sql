-- SELECT all card types with name Ms. Carla J. Adams
SELECT * FROM customer WHERE Name = 'Ms. Carla J. Adams';

-- Print all of the addresses for customer with account number AW00000222
Print(SELECT * FROM CustomerAddress WHERE  = 'account number AW00000222');

-- Print the city of the customer with customer ID number 40
Print(SELECT * FROM City WHERE CustomerID IN 40);
