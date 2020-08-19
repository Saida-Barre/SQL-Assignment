
-----------------------------------------------------------------------------
--review assignment
-----------------------------------------------------------------------------
-- Contact(Name is Carla J. Adams) -> Contact(ContactID)
-- Contact(ContactID) -> ContactCreditCard(ContactID)
-- ContactCraditCard(CreditCardID) -> CreditCard(CreditCardID)
-- CreditCard(CreditCardID) -> CreditCard(CardType)

-- Query #1 - Solution With Subqueries 
SELECT CardType FROM CreditCard WHERE CreditCardID IN (
    SELECT CreditCardID FROM ContactCreditCard WHERE ContactID IN (
        SELECT ContactID FROM Contact WHERE FirstName = 'Carla' AND MiddleName = 'J.' AND LastName = 'Adams'

    )
);
-------------------------------------------------------------------------------------------------------------

-- Query #2 - Solution With Subqueries 
-- Customer(AccountNumber is AW00000222) -> Customer(CustomerID)

-- 1. Ensure we're getting the record with the correct AccountNumber.
SELECT * FROM Customer WHERE AccountNumber = 'AW00000222';

-- 2. Filter the previous results down to only the primary key for use in a subquery.
SELECT CustomerID FROM Customer WHERE AccountNumber = 'AW00000222';

-- Customer(CustomerID) -> CustomerAddress(CustomerID)
-- 3. Select records from the child table matching the primary key.
SELECT * FROM CustomerAddress WHERE CustomerID IN (
    SELECT CustomerID FROM Customer WHERE AccountNumber = 'AW00000222'
);

-- CustomerAddress(CustomerID) -> CustomerAddress(AddressID)
--4. Select only the address primary keys from the above records.
SELECT AddressID FROM CustomerAddress WHERE CustomerID IN (
    SELECT CustomerID FROM Customer WHERE AccountNumber = 'AW00000222'
);

-- CustomerAddress(AddressID) -> Address(AddressID)
SELECT * FROM Address WHERE AddressID IN (
    SELECT AddressID FROM CustomerAddress WHERE CustomerID IN (
        SELECT CustomerID FROM Customer WHERE AccountNumber = 'AW00000222'
    )
);

-- Address(AddressID) -> Formatted Address
-- If we want to name the column something 'prettier', we can add it in quotes following our CONCAT operator.
SELECT CONCAT(AddressLine1, ', ', City, ' ', PostalCode) 'Full Address' FROM Address WHERE AddressID IN (
    SELECT AddressID FROM CustomerAddress WHERE CustomerID IN (
        SELECT CustomerID FROM Customer WHERE AccountNumber = 'AW00000222'
    )
);

-- Query #3 - Solution With Subqueries 
-- CustomerAddress(CustomerID) -> CustomerAddress(AddressID)
-- CustomerAddress(AddressID) -> Address(AddressID)
-- Address(AddressID) -> Address(City)

-- Main query associates AddressID from subquery with City
SELECT City FROM Address WHERE AddressID IN (
    -- Subquery associates AddressID with CustomerID
    SELECT AddressID FROM CustomerAddress WHERE CustomerID = 40
);
--------------------------------------------------------------------------------------------
---CHALLENGE QUESTION REVIEW

-- Insert a record into the Address table
-- Insert a record into the CustomerAddress table tying our customer to the new address, and ensure that the AddressType is correct

-- Determine what our StateProvinceID is:
SELECT * FROM StateProvince WHERE Name = 'Alberta';
-- Returned a record with StateProvinceID 1

INSERT INTO Address (AddressLine1, City, StateProvinceID, PostalCode)
VALUES ('1 Churchill Square', 'Edmonton', 1, 'A1A 1A1');

-- In case we didn't record the primary key on the insert:
SELECT * FROM Address WHERE AddressLine1 = '1 Churchill Square';
-- Returned the record with AddressID 32522

-- Determine our CustomerID:
SELECT * FROM Customer WHERE AccountNumber = 'AW00000222';
-- Returned the record with CustomerID 222

-- Determine out AddressTypeID based on the type of 'Home':
SELECT * FROM AddressType WHERE Name = 'Home';
-- Returned the record with AddressTypeID 2

-- Put it all together:
INSERT INTO CustomerAddress (AddressID, CustomerID, AddressTypeID)
VALUES (32522, 222, 2);
