-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Write SQL commands under the prompts below, and run the file to get results.

-- In case there is already a televisions table, drop it


-- Create a televisions table
CREATE TABLE televisions ( id serial PRIMARY KEY );

--  The table should have id, model_name, screen_size, resolution,
--  price, release_date, photo_url
ALTER TABLE televisions ADD COLUMN    model_name    VARCHAR(32);
ALTER TABLE televisions ADD COLUMN    screen_size   VARCHAR(12);
ALTER TABLE televisions ADD COLUMN    resolution    VARCHAR(12);
ALTER TABLE televisions ADD COLUMN    price         DECIMAL;
ALTER TABLE televisions ADD COLUMN    release_date  TIMESTAMP;
ALTER TABLE televisions ADD COLUMN    photo_url     text;

SELECT * FROM televisions;
 id | model_name | screen_size | resolution | price | release_date | photo_url
----+------------+-------------+------------+-------+--------------+-----------
(0 rows)

-- Insert 4 televisions into the tv_models table
INSERT INTO televisions ( model_name, screen_size, resolution, price, release_date, photo_url )
VALUES ( 'BigView', '128"', '4k', 4499.99, '2025, 11, 25', 'images/05.jpg' );

INSERT INTO televisions ( model_name, screen_size, resolution, price, release_date, photo_url )
VALUES ( 'SmallView', '32"', '1080p', 399.99, '2023, 3, 26', 'images/06.jpg' );

INSERT INTO televisions ( model_name, screen_size, resolution, price, release_date, photo_url )
VALUES ( 'MediumView', '64"', '4k', 1499.99, '2025, 11, 11', 'images/07.jpg' );

INSERT INTO televisions ( model_name, screen_size, resolution, price, release_date, photo_url )
VALUES ( 'NoView', '-12"', '144p', 29.99, '2004, 02, 22', 'images/08.jpg' );

-- Select all entries from the tv_models table
SELECT * FROM televisions:
 id | model_name | screen_size | resolution | price |    release_date     |   photo_url
----+------------+-------------+------------+-------+---------------------+---------------
  1 | BigView    | 128"        | 4k         |  4500 | 2025-11-25 00:00:00 | images/05.jpg
  2 | SmallView  | 32"         | 1080p      |   400 | 2023-03-26 00:00:00 | images/06.jpg
  3 | MediumView | 64"         | 4k         |  1500 | 2025-11-11 00:00:00 | images/07.jpg
  4 | NoView     | -12"        | 144p       |    30 | 2004-02-22 00:00:00 | images/08.jpg
(4 rows)

-- HUNGRY FOR MORE? 
-- Look at this afternoon's instructor notes and read on altering tables before attempting below

-- Alter the tv_models, removing the resolution column
--  and add vertical_resolution and horizontal_resolution columns
