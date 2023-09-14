/* prompt
write postgres code to generate a table called orders. The table should have 5 columns. The first two columns are: order_id, order_date. The order_date column uses the "date" data type. Create the table with 3 partitions. Partition the data by order_date, where each year uses a different partition

Comments: 
First build the table. Then add partitions. Then the PK
*/
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
   order_id SERIAL,
   order_date DATE NOT NULL,
   customer_name VARCHAR(255),
   product_name VARCHAR(255),
   quantity INT
) PARTITION BY RANGE(EXTRACT(YEAR FROM order_date));

CREATE TABLE orders_2019 PARTITION OF orders FOR VALUES FROM (2019) TO (2020);
CREATE TABLE orders_2020 PARTITION OF orders FOR VALUES FROM (2020) TO (2021);
CREATE TABLE orders_2021 PARTITION OF orders FOR VALUES FROM (2021) TO (2022);

--Error: unsupported primary key constraint with partition key definition
--ALTER TABLE orders ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);

--Inserting 5 rows for 2019
INSERT INTO orders (order_date, customer_name, product_name, quantity)
VALUES ('2019-01-01', 'John Smith', 'Product A', 10),
       ('2019-02-15', 'Jane Doe', 'Product B', 5),
       ('2019-04-20', 'Bob Johnson', 'Product C', 2),
       ('2019-07-10', 'Alice Brown', 'Product A', 7),
       ('2019-12-30', 'Mike Wilson', 'Product B', 8);

--Inserting 5 rows for 2020
INSERT INTO orders (order_date, customer_name, product_name, quantity)
VALUES ('2020-02-14', 'John Smith', 'Product A', 15),
       ('2020-03-20', 'Jane Doe', 'Product B', 3),
       ('2020-06-05', 'Bob Johnson', 'Product C', 10),
       ('2020-08-15', 'Alice Brown', 'Product A', 5),
       ('2020-11-25', 'Mike Wilson', 'Product B', 2);

--Inserting 5 rows for 2021
INSERT INTO orders (order_date, customer_name, product_name, quantity)
VALUES ('2021-01-07', 'John Smith', 'Product A', 4),
       ('2021-03-15', 'Jane Doe', 'Product B', 12),
       ('2021-05-20', 'Bob Johnson', 'Product C', 6),
       ('2021-09-01', 'Alice Brown', 'Product A', 3),
       ('2021-11-30', 'Mike Wilson', 'Product B', 9);

-- Uses 3 partitions
explain (analyze, verbose, format json)
select * 
from orders
where order_date between '2020-01-01' and '2020-06-30'


-- Uses only 1 partition
explain (analyze, verbose, format json)
select * 
from orders
where order_date between '2020-01-01' and '2020-06-30'
and EXTRACT(YEAR FROM order_date) = 2020





