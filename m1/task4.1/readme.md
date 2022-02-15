```
● mariadb.service - MariaDB 10.3.31 database server
     Loaded: loaded (/lib/systemd/system/mariadb.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-11-30 14:14:26 UTC; 4h 37min ago
       Docs: man:mysqld(8)
             https://mariadb.com/kb/en/library/systemd/
   Main PID: 591 (mysqld)
     Status: "Taking your SQL requests now..."
      Tasks: 30 (limit: 1154)
     Memory: 78.3M
     CGroup: /system.slice/mariadb.service
             └─591 /usr/sbin/mysqld
```


```

MariaDB [(none)]> CREATE DATABASE mystore;
```

```
MariaDB [mystore]> CREATE TABLE customers(id INT NOT NULL AUTO_INCREMENT, first_name VARCHAR(255), last_name VARCHAR(255), email VARCHAR(255), password VARCHAR(255), city VARCHAR(255), PRIMARY KEY(id) );
Query OK, 0 rows affected (0.014 sec)
```

```
MariaDB [mystore]> CREATE TABLE products(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(255), price INT, PRIMARY KEY(id) );
```

```
MariaDB [mystore]> CREATE TABLE orders(id INT NOT NULL AUTO_INCREMENT, order_number INT, product_id INT, customer_id INT, order_date DATETIME default CURRENT_TIMESTAMP, PRIMARY KEY(id), FOREIGN KEY(customer_id) REFERENCES customers(id), FOREIGN KEY(product_id) REFERENCES products(id));
```

```
MariaDB [mystore]> SHOW TABLES;
+-------------------+
| Tables_in_mystore |
+-------------------+
| customers         |
| orders            |
| products          |
+-------------------+
```

```
MariaDB [mystore]> INSERT INTO customers(first_name, last_name, email, password, city) VALUES('Bob', 'Lenon', 'email1@gmail.com', 'qwerty123', 'Boston')
```

```
MariaDB [mystore]> SELECT * FROM customers;
+----+------------+-----------+------------------+--------------+-----------+
| id | first_name | last_name | email            | password     | city      |
+----+------------+-----------+------------------+--------------+-----------+
|  1 | Bob        | Lenon     | email1@gmail.com | qwerty123    | Boston    |
|  2 | Jhon       | Rudik     | email2@gmail.com | qwerty1234   | Brooklyn  |
|  3 | Kevin      | Smith     | email3@gmail.com | qwerty12345  | Brooklyn  |
|  4 | Janet      | Thompson  | email4@gmail.com | qwerty123456 | Salisbury |
+----+------------+-----------+------------------+--------------+-----------+
```
```
MariaDB [mystore]> INSERT INTO products (name, price) VALUES ('Product One', '10'), ('Product Two', '20'), ('Product Three', '25' ), ('Product Four', '30');
```
```

MariaDB [mystore]> select * from products
    -> ;
+----+---------------+-------+
| id | name          | price |
+----+---------------+-------+
|  1 | Product One   |    10 |
|  2 | Product Two   |    20 |
|  3 | Product Three |    25 |
|  4 | Product Four  |    30 |
+----+---------------+-------+
```
```
MariaDB [mystore]> INSERT INTO orders(order_number, customer_id, product_id) VALUES(1,1,1), (2,2,3), (3,3,4), (4,4,2);
```

```
MariaDB [mystore]> SELECT * FROM orders;
+----+--------------+------------+-------------+---------------------+
| id | order_number | product_id | customer_id | order_date          |
+----+--------------+------------+-------------+---------------------+
|  1 |            1 |          1 |           1 | 2021-11-30 16:07:51 |
|  2 |            2 |          3 |           2 | 2021-11-30 16:07:51 |
|  3 |            3 |          4 |           3 | 2021-11-30 16:07:51 |
|  4 |            4 |          2 |           4 | 2021-11-30 16:07:51 |
+----+--------------+------------+-------------+---------------------+
```
```
MariaDB [mystore]> SELECT first_name, last_name FROM customers;

```
```
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Bob        | Lenon     |
| Jhon       | Rudik     |
| Kevin      | Smith     |
| Janet      | Thompson  |
+------------+-----------+
```
```
MariaDB [mystore]> SELECT first_name FROM customers GROUP BY first_name;

+------------+
| first_name |
+------------+
| Bob        |
| Janet      |
| Jhon       |
| Kevin      |
+------------+
```
```
MariaDB [mystore]> SELECT * FROM products ORDER BY price;
+----+---------------+-------+
| id | name          | price |
+----+---------------+-------+
|  1 | Product One   |    10 |
|  2 | Product Two   |    20 |
|  3 | Product Three |    25 |
|  4 | Product Four  |    30 |
+----+---------------+-------+
```
```

MariaDB [mystore]> SELECT * FROM customers WHERE id =2;
+----+------------+-----------+------------------+------------+----------+
| id | first_name | last_name | email            | password   | city     |
+----+------------+-----------+------------------+------------+----------+
|  2 | Jhon       | Rudik     | email2@gmail.com | qwerty1234 | Brooklyn |
+----+------------+-----------+------------------+------------+----------+
```
```
MariaDB [mystore]> SELECT * FROM customers WHERE id <2;
+----+------------+-----------+------------------+-----------+--------+
| id | first_name | last_name | email            | password  | city   |
+----+------------+-----------+------------------+-----------+--------+
|  1 | Bob        | Lenon     | email1@gmail.com | qwerty123 | Boston |
+----+------------+-----------+------------------+-----------+--------+
```
```
MariaDB [mystore]> SELECT id, email FROM customers WHERE id BETWEEN 2 AND 4;
+----+------------------+
| id | email            |
+----+------------------+
|  2 | email2@gmail.com |
|  3 | email3@gmail.com |
|  4 | email4@gmail.com |
+----+------------------+
```
```
MariaDB [mystore]> SELECT * FROM customers WHERE city LIKE 'sa%';
+----+------------+-----------+------------------+--------------+-----------+
| id | first_name | last_name | email            | password     | city      |
+----+------------+-----------+------------------+--------------+-----------+
|  4 | Janet      | Thompson  | email4@gmail.com | qwerty123456 | Salisbury |
+----+------------+-----------+------------------+--------------+-----------+
```
```
MariaDB [mystore]> SELECT customers.first_name, customers.last_name, orders.id, orders.order_number FROM customers INNER JOIN orders ON customers.id = orders.customer_id;
+------------+-----------+----+--------------+
| first_name | last_name | id | order_number |
+------------+-----------+----+--------------+
| Bob        | Lenon     |  1 |            1 |
| Jhon       | Rudik     |  2 |            2 |
| Kevin      | Smith     |  3 |            3 |
| Janet      | Thompson  |  4 |            4 |
+------------+-----------+----+--------------+
```
```
MariaDB [mystore]> SELECT customers.first_name, customers.last_name, orders.order_number, orders.order_date FROM customers LEFT JOIN orders ON customers.id = orders.customer_id ORDER BY customers.last_name;
+------------+-----------+--------------+---------------------+
| first_name | last_name | order_number | order_date          |
+------------+-----------+--------------+---------------------+
| Bob        | Lenon     |            1 | 2021-11-30 16:07:51 |
| Jhon       | Rudik     |            2 | 2021-11-30 16:07:51 |
| Kevin      | Smith     |            3 | 2021-11-30 16:07:51 |
| Janet      | Thompson  |            4 | 2021-11-30 16:07:51 |
+------------+-----------+--------------+---------------------+
```
```
MariaDB [mystore]> SELECT customers.first_name, customers.last_name, orders.order_number, orders.order_date, products.name FROM orders INNER JOIN products ON orders.product_id = products.id INNER JOIN customers ON orders.customer_id = customers.id ORDER BY orders.order_number;
+------------+-----------+--------------+---------------------+---------------+
| first_name | last_name | order_number | order_date          | name          |
+------------+-----------+--------------+---------------------+---------------+
| Bob        | Lenon     |            1 | 2021-11-30 16:07:51 | Product One   |
| Jhon       | Rudik     |            2 | 2021-11-30 16:07:51 | Product Three |
| Kevin      | Smith     |            3 | 2021-11-30 16:07:51 | Product Four  |
| Janet      | Thompson  |            4 | 2021-11-30 16:07:51 | Product Two   |
+------------+-----------+--------------+---------------------+---------------+
```
```
MariaDB [(none)]> CREATE USER 'ruslan'@'localhost' IDENTIFIED BY 'mypass'


~# mysql -uruslan -p mystore
Enter password: 
ERROR 1044 (42000): Access denied for user 'ruslan'@'localhost' to database 'mystore'
```

```
~# mysql -uruslan -p mystore
Enter password: 
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 44
Server version: 10.3.31-MariaDB-0ubuntu0.20.04.1 Ubuntu 20.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
```
```
MariaDB [mystore]> SELECT * FROM customers;
+----+------------+-----------+------------------+--------------+-----------+
| id | first_name | last_name | email            | password     | city      |
+----+------------+-----------+------------------+--------------+-----------+
|  1 | Bob        | Lenon     | email1@gmail.com | qwerty123    | Boston    |
|  2 | Jhon       | Rudik     | email2@gmail.com | qwerty1234   | Brooklyn  |
|  3 | Kevin      | Smith     | email3@gmail.com | qwerty12345  | Brooklyn  |
|  4 | Janet      | Thompson  | email4@gmail.com | qwerty123456 | Salisbury |
+----+------------+-----------+------------------+--------------+-----------+
```
```
~# mysql -uruslan -p mysql
Enter password: 
ERROR 1044 (42000): Access denied for user 'ruslan'@'localhost' to database 'mysql'
```
```
> SHOW GRANTS FOR 'ruslan'@'localhost';
+------------------------------------------------------------------------------------------------------------------------+
| Grants for ruslan@localhost                                                                                            |
+------------------------------------------------------------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO `ruslan`@`localhost` IDENTIFIED BY PASSWORD '*6C8989366EAF75BB670AD8EA7A7FC1176A95CEF4' |
| GRANT ALL PRIVILEGES ON `mystore`.* TO `ruslan`@`localhost`                                                            |
+------------------------------------------------------------------------------------------------------------------------+
```
```
~# mysql -uruslan -p mysql
Enter password: 
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 48
Server version: 10.3.31-MariaDB-0ubuntu0.20.04.1 Ubuntu 20.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [mysql]> 

MariaDB [(none)]> REVOKE SELECT ON mystore.* FROM 'ruslan'@'localhost';
Query OK, 0 rows affected (0.000 sec)

MariaDB [mystore]> Select * FROM customers;
ERROR 1142 (42000): SELECT command denied to user 'ruslan'@'localhost' for table 'customers'
```

```
MariaDB [mysql]> select * from user;
+-----------+--------+-------------------------------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+---------------------+----------+------------+-------------+--------------+---------------+-------------+-----------------+----------------------+-------------+-----------------------+------------------+---------+--------------+--------------------+
| Host      | User   | Password                                  | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv | Reload_priv | Shutdown_priv | Process_priv | File_priv | Grant_priv | References_priv | Index_priv | Alter_priv | Show_db_priv | Super_priv | Create_tmp_table_priv | Lock_tables_priv | Execute_priv | Repl_slave_priv | Repl_client_priv | Create_view_priv | Show_view_priv | Create_routine_priv | Alter_routine_priv | Create_user_priv | Event_priv | Trigger_priv | Create_tablespace_priv | Delete_history_priv | ssl_type | ssl_cipher | x509_issuer | x509_subject | max_questions | max_updates | max_connections | max_user_connections | plugin      | authentication_string | password_expired | is_role | default_role | max_statement_time |

```

```
~# mysqldump -uruslan -p mystore > mystore.sql
```
```
~# tail mystore.sql 

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-30 17:43:25
```
```

MariaDB [mystore]> DROP TABLE orders;
Query OK, 0 rows affected (0.007 sec)

MariaDB [mystore]> show tables;
+-------------------+
| Tables_in_mystore |
+-------------------+
| customers         |
| products          |
+-------------------+
2 rows in set (0.000 sec)
```
```
~# mysql -uruslan -p mystore < mystore.sql

MariaDB [mystore]> show tables;
+-------------------+
| Tables_in_mystore |
+-------------------+
| customers         |
| orders            |
| products          |
+-------------------+
```

Import to RDS
```
~# mysql -umystorerds -p -h mystorerds.c3haxqgsp8ec.us-east-2.rds.amazonaws.com
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 25
Server version: 10.5.12-MariaDB-log managed by https://aws.amazon.com/rds/

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
```
```
~# mysql -umystorerds -p mystore -h mystorerds.c3haxqgsp8ec.us-east-2.rds.amazonaws.com < mystore.sql
```
```
MariaDB [mystore]> SHOW TABLES;
+-------------------+
| Tables_in_mystore |
+-------------------+
| customers         |
| orders            |
| products          |
+-------------------+


MariaDB [mystore]> SELECT customers.first_name, customers.last_name, orders.order_number, orders.order_date, products.name FROM orders INNER JOIN products ON orders.product_id = products.id INNER JOIN customers ON orders.customer_id = customers.id ORDER BY orders.order_number;
+------------+-----------+--------------+---------------------+---------------+
| first_name | last_name | order_number | order_date          | name          |
+------------+-----------+--------------+---------------------+---------------+
| Bob        | Lenon     |            1 | 2021-11-30 16:07:51 | Product One   |
| Jhon       | Rudik     |            2 | 2021-11-30 16:07:51 | Product Three |
| Kevin      | Smith     |            3 | 2021-11-30 16:07:51 | Product Four  |
| Janet      | Thompson  |            4 | 2021-11-30 16:07:51 | Product Two   |
+------------+-----------+--------------+---------------------+---------------+
4 rows in set (0.002 sec)

MariaDB [mystore]> SELECT id, email FROM customers WHERE id BETWEEN 2 AND 4;
+----+------------------+
| id | email            |
+----+------------------+
|  2 | email2@gmail.com |
|  3 | email3@gmail.com |
|  4 | email4@gmail.com |
+----+------------------+
3 rows in set (0.001 sec)

MariaDB [mystore]> SELECT first_name FROM customers GROUP BY first_name;
+------------+
| first_name |
+------------+
| Bob        |
| Janet      |
| Jhon       |
| Kevin      |
+------------+
4 rows in set (0.001 sec)
```
```
~# mysqldump -umystorerds -p mystore -h mystorerds.c3haxqgsp8ec.us-east-2.rds.amazonaws.com > mystorerds.sql

~# tail  mystorerds.sql

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-30 18:50:28
```

DynamoDB

https://gyazo.com/1836f90d04bf881276140628219f00b7

https://gyazo.com/3032c99392272268db272bbebf167984

https://gyazo.com/ef9f85ee775854c1dfb17c7a5acf4828
