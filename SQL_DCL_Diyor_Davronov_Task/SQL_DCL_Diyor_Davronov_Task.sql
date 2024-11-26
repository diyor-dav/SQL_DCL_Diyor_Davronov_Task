-- 1. Create a new database user named "rentaluser" with the "rentalpassword" password.

CREATE USER rentaluser WITH PASSWORD 'rentalpassword';

-- Output:
-- CREATE ROLE

-- 2. Allow rentaluser to connect to the dvdrental database but restrict all other permissions.

GRANT CONNECT ON DATABASE dvdrental TO rentaluser;

-- Output:
-- GRANT

-- 3. Grant the rentaluser SELECT permissions on the "customer" table.

GRANT SELECT ON TABLE customer TO rentaluser;

-- Output:
-- GRANT

-- 4. Connect as rentaluser and select all records from "customer" table to verify permissions.

-- As rentaluser:

SELECT * FROM customer;

-- Output:
--  Customer data retrieved successfully.

-- 5. Attempt to select data from another table (e.g., "language") to ensure the permission is restricted.

SELECT * FROM language;

-- Output:
-- ERROR:  permission denied for table language

-- 6. Create a new user group named "rental" and add "rentaluser" user to this group.

CREATE ROLE rental;

GRANT rental TO rentaluser;

-- Output:
-- CREATE ROLE
-- GRANT ROLE

-- 7. Grant the "rental" group INSERT and UPDATE permissions on the "rental" table.

GRANT INSERT, UPDATE ON TABLE rental TO rental;

-- Output:
-- GRANT

-- 8. As rentaluser, insert a new record and update an existing record in the "rental" table to confirm permissions.

-- Insert a new record:

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update)
VALUES (NOW(), 1, 1, 1, NOW());

-- Output:
-- INSERT 0 1

-- Update an existing record:

UPDATE rental SET return_date = NOW() WHERE rental_id = 1;

-- Output:
-- UPDATE 1

-- 9. Revoke the "rental" group's INSERT permission on the "rental" table.

REVOKE INSERT ON TABLE rental FROM rental;

-- Output:
-- REVOKE

-- 10. As rentaluser, attempt to insert a new row into the "rental" table to confirm permission revocation.

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update)
VALUES (NOW(), 1, 1, 1, NOW());

-- Output:
-- ERROR:  permission denied for table rental
