-- Contact(Name is Carla J. Adams) -> Contact(ContactID)
-- Contact(ContactID) -> ContactCreditCard(ContactID)
-- ContactCraditCard(CreditCardID) -> CreditCard(CreditCardID)
-- CreditCard(CreditCardID) -> CreditCard(CardType)

-- Query #1 - Solution With Joins 

-- We have to specify what table from our joined set we are pulling data from.
SELECT creditcard.CardType FROM contact
-- Inner join will only show records where the parent-child relationship exists.
-- If there is no child record or vice versa, that record will not be shown.
INNER JOIN contactcreditcard 
-- Using the ON clause we specify the relationship between the tables (typically primary/foreign keys).
ON contact.ContactID = contactcreditcard.ContactID
-- You can join multiple tables in sequence to allow data association across a wide dataset.
INNER JOIN creditcard
ON contactcreditcard.CreditCardID = creditcard.CreditCardID
-- As in the SELECT, we need to specify the table to avoid ambiguity. It will work without in this case, but always better to specify than assume.
WHERE contact.FirstName = 'Carla' AND contact.MiddleName = 'J.' AND contact.LastName = 'Adams';


-- For this example we'll be using ContactID #16.

-- Because Lili does not have a credit card, this select (inner join) will return 0 results.
-- Not her information with an empty card type, just 0 results.
SELECT contact.FirstName, creditcard.CardType FROM contact
INNER JOIN contactcreditcard 
ON contact.ContactID = contactcreditcard.ContactID
INNER JOIN creditcard
ON contactcreditcard.CreditCardID = creditcard.CreditCardID
WHERE contact.ContactID = 16;

-- As contrasted to an outer join, where missing child records will be displayed as NULL, but the parent records will still be displayed. (Outer join won't hide parent records, inner join might.)
-- The "FROM contact" is considered the "LEFT" table and the "JOIN contactcreditcard" is considered the "RIGHT" table.
SELECT contact.FirstName, creditcard.CardType FROM contact
LEFT OUTER JOIN contactcreditcard 
ON contact.ContactID = contactcreditcard.ContactID
-- The previous joined tables are considered the "LEFT" table and the "JOIN creditcard" is considered the "RIGHT" table.
LEFT OUTER JOIN creditcard
ON contactcreditcard.CreditCardID = creditcard.CreditCardID
WHERE contact.ContactID = 16;

-- If we wanted to invert the order from above but maintain the same results:
SELECT contact.FirstName, creditcard.CardType FROM creditcard
RIGHT OUTER JOIN contactcreditcard
ON contactcreditcard.CreditCardID = creditcard.CreditCardID
RIGHT OUTER JOIN contact 
ON contact.ContactID = contactcreditcard.ContactID
WHERE contact.ContactID = 16;