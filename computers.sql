-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Write SQL commands under the prompts below, and run the file to get results.

-- In case there is already a computers table, drop it

-- Create a computers table
CREATE TABLE computers (id serial PRIMARY KEY);

-- The table should have id, make, model, cpu_speed, memory_size,
--  price, release_date, photo_url, storage_amount, number_usb_ports,
--  number_firewire_ports, number_thunderbolt_ports
ALTER TABLE computers ADD COLUMN make VARCHAR(32);
ALTER TABLE computers ADD COLUMN model VARCHAR(32);
ALTER TABLE computers ADD COLUMN cpu_speed VARCHAR(12); -- Went VARCHAR instead of INT since the CPU speed might include the unit type (ie: GHz)
ALTER TABLE computers ADD COLUMN memory_size VARCHAR(12); -- Same reasoning as above.
ALTER TABLE computers ADD COLUMN price DECIMAL; -- Let's assume this is a store, so currency is converted before being placed into the DB. Do no currency type added to value
ALTER TABLE computers ADD COLUMN release_date TIMESTAMP;
ALTER TABLE computers ADD COLUMN photo_url text; 
ALTER TABLE computers ADD COLUMN storage_amount VARCHAR(12);
ALTER TABLE computers ADD COLUMN number_usb_ports INT;
ALTER TABLE computers ADD COLUMN number_firewire_ports INT;
ALTER TABLE computers ADD COLUMN number_thunderbolt_ports INT;

-- Insert 4 computers into the computers table
INSERT INTO computers ( make, model, cpu_speed, memory_size, price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports)
VALUES ('Apple', 'Mac Book Pro Max Mini', '200GHz', '32gb', 1999.99, '2023-09-21', 'images/01.png', '1TB', 3, 0, 1);

INSERT INTO computers ( make, model, cpu_speed, memory_size, price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports)
VALUES ('Apple', 'Mac Book Pro Max', '1500GHz', '64gb', 2749.99, '2024-09-21', 'images/02.png', '1TB', 4, 0, 0);

INSERT INTO computers ( make, model, cpu_speed, memory_size, price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports)
VALUES ('Apple', 'Mac Book Air', '100GHz', '16gb', 999.99, '2023-09-21', 'images/03.png', '268gb', 2, 1, 1);

INSERT INTO computers ( make, model, cpu_speed, memory_size, price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports)
VALUES ('Apple', 'Mac Book', '500GHz', '32gb', 149.99, '2021-09-21', 'images/04.png', '128gb', 2, 1, 1);

-- Select all entries from the computers table
SELECT * FROM computers;

 id | make  |         model         | cpu_speed | memory_size |  price  |    release_date     |   photo_url   | storage_amount | number_usb_ports | number_firewire_ports | number_thunderbolt_ports
----+-------+-----------------------+-----------+-------------+---------+---------------------+---------------+----------------+------------------+-----------------------+--------------------------
  1 | Apple | Mac Book Pro Max Mini | 200GHz    | 32gb        | 1999.99 | 2023-09-21 00:00:00 | images/01.png | 1TB            |                3 |                     0 |                        1
  2 | Apple | Mac Book Pro Max      | 1500GHz   | 64gb        | 2749.99 | 2024-09-21 00:00:00 | images/02.png | 1TB            |                4 |                     0 |                        0
  3 | Apple | Mac Book Air          | 100GHz    | 16gb        |  999.99 | 2023-09-21 00:00:00 | images/03.png | 268gb          |                2 |                     1 |                        1
  4 | Apple | Mac Book              | 500GHz    | 32gb        |  149.99 | 2021-09-21 00:00:00 | images/04.png | 128gb          |                2 |                     1 |                        1
(4 rows)

-- HUNGRY FOR MORE? 
-- Look at this afternoon's instructor notes and read on altering tables before attempting below

-- Alter the computers_models, removing the storage_amount column
-- and add storage_type and storage_size columns

ALTER TABLE computers ADD COLUMN storage_type VARCHAR(2);
ALTER TABLE computers ADD COLUMN storage_size INT;

SELECT * FROM computers;
 id | make  |         model         | ... | storage_amount | ... | storage_type | storage_size
----+-------+-----------------------+-----+----------------+-----+--------------+--------------
  1 | Apple | Mac Book Pro Max Mini | ... | 1TB            | ... |              |
  2 | Apple | Mac Book Pro Max      | ... | 1TB            | ... |              |
  3 | Apple | Mac Book Air          | ... | 268gb          | ... |              |
  4 | Apple | Mac Book              | ... | 128gb          | ... |              |
(4 rows)

-- Using the Regular Expressions (REGEXP), we can preserve the data saved in the `storage_amount` column, by parsing it into the new cols.
-- I learned about this here: https://www.geeksforgeeks.org/postgresql/working-with-regular-expressions-in-postgresql/
-- REGEX uses the following documentation: `regexp_replace(source, pattern, replacement, flats)
-- For pattern, to keep NUMS, we do [0-9], to keep everything BUT nums, we can do [^0-9]
-- Finally, to convert the number string into an actual INTEGER, we cast it with the ::INT at the end.
UPDATE computers SET storage_size = REGEXP_REPLACE(storage_amount, '[^0-9]', '', 'g')::INT;
UPDATE computers SET storage_type = REGEXP_REPLACE(storage_amount, '[0-9]', '', 'g');

ALTER TABLE computers DROP COLUMN storage_amount;

SELECT * FROM computers;
 id | make  |         model         | cpu_speed | memory_size |  price  |    release_date     |   photo_url   | number_usb_ports | number_firewire_ports | number_thunderbolt_ports | storage_type | storage_size
----+-------+-----------------------+-----------+-------------+---------+---------------------+---------------+------------------+-----------------------+--------------------------+--------------+--------------
  1 | Apple | Mac Book Pro Max Mini | 200GHz    | 32gb        | 1999.99 | 2023-09-21 00:00:00 | images/01.png |                3 |                     0 |                        1 | TB           |            1
  2 | Apple | Mac Book Pro Max      | 1500GHz   | 64gb        | 2749.99 | 2024-09-21 00:00:00 | images/02.png |                4 |                     0 |                        0 | TB           |            1
  3 | Apple | Mac Book Air          | 100GHz    | 16gb        |  999.99 | 2023-09-21 00:00:00 | images/03.png |                2 |                     1 |                        1 | gb           |          268
  4 | Apple | Mac Book              | 500GHz    | 32gb        |  149.99 | 2021-09-21 00:00:00 | images/04.png |                2 |                     1 |                        1 | gb           |          128
(4 rows)