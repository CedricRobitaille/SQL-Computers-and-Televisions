-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Write SQL commands under the prompts below, and run the file to get results.

-- In case there is already a televisions table, drop it


-- Create a televisions table
CREATE TABLE televisions ( id serial PRIMARY KEY );

--  The table should have id, model_name, screen_size, resolution,
--  price, release_date, photo_url
ALTER TABLE televisions ADD COLUMN model_name VARCHAR(32);
ALTER TABLE televisions ADD COLUMN screen_size VARCHAR(12);
ALTER TABLE televisions ADD COLUMN resolution VARCHAR(12);
ALTER TABLE televisions ADD COLUMN price INT;
ALTER TABLE televisions ADD COLUMN release_date TIMESTAMP;
ALTER TABLE televisions ADD COLUMN photo_url text;

SELECT * FROM televisions;
 id | model_name | screen_size | resolution | price | release_date | photo_url
----+------------+-------------+------------+-------+--------------+-----------
(0 rows)

-- Insert 4 televisions into the tv_models table


-- Select all entries from the tv_models table


-- HUNGRY FOR MORE? 
-- Look at this afternoon's instructor notes and read on altering tables before attempting below

-- Alter the tv_models, removing the resolution column
--  and add vertical_resolution and horizontal_resolution columns
