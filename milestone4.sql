/*CREATE DATABASE ht21_2_project_group_43;
USE ht21_2_project_group_43;*/

CREATE DATABASE project_group43;
USE project_group43;

CREATE TABLE USER_(
PNR char (12) NOT NULL, 
user_name varchar (20) NOT NULL,
e_mail varchar (20)NOT NULL,
phone_number int NOT NULL,
receive_newsletter boolean NOT NULL,
user_password varchar(20) NOT NULL,
billing_address varchar (20) NOT NULL,
shipping_address varchar (20),
PRIMARY KEY (PNR)
);

CREATE TABLE ORDER_(
order_id char (5), 
payment_reference varchar (20),
tracking_number char (10), 
status_order varchar (20) NOT NULL, 
modified_date Date, 
initial_date Date NOT NULL, 
PNR char (12) NOT NULL,
PRIMARY KEY (order_id),
FOREIGN KEY (PNR) REFERENCES USER_ (PNR)
	ON UPDATE CASCADE
);

CREATE TABLE TAX_(
product_group varchar (20),
VAT float,
PRIMARY KEY (product_group)
);

CREATE TABLE DEPARTMENT_(
department_id char (2),
parent_department char(2),
title varchar (20),
description_department varchar (20),
PRIMARY KEY (department_id),
FOREIGN KEY (parent_department) REFERENCES DEPARTMENT_ (department_id)
);

CREATE TABLE PRODUCT_(
product_id char (5),
stock_qty int, 
retail_price float, 
title varchar (20),
description_table varchar (20), 
featured_product boolean, 
department_id char(2),
product_group varchar (20),
product_discount int,
PRIMARY KEY (product_id),
FOREIGN KEY (department_id) REFERENCES DEPARTMENT_(department_id),
FOREIGN KEY (product_group) REFERENCES TAX_(product_group)
);

CREATE TABLE REVIEW_(
review_id char (5),
rating int CHECK (rating >= 0 AND rating <= 5), 
text_review varchar(100),
product_id char (5),
PNR char (12) NOT NULL,
PRIMARY KEY (review_id),
FOREIGN KEY (product_id) REFERENCES PRODUCT_(product_id),
FOREIGN KEY (PNR) REFERENCES USER_(PNR)
);

CREATE TABLE ACCOUNTING_(
order_detail_id char (5),
price float,
quantity int, 
discount float,
product_id char (5),
order_id char (5), 
PRIMARY KEY (order_detail_id),
FOREIGN KEY (product_id) REFERENCES PRODUCT_ (product_id),
FOREIGN KEY (order_id) REFERENCES ORDER_ (order_id)
);

CREATE TABLE KEYWORD_(
keyword_id int AUTO_INCREMENT, 
keyword varchar(150),
PRIMARY KEY (keyword_id)
);

CREATE TABLE MATCHES_(
matches_id int auto_increment,
product_id char (5), 
keyword_id int,
PRIMARY KEY (matches_id),
FOREIGN KEY (product_id) REFERENCES PRODUCT_ (product_id),
FOREIGN KEY (keyword_id) REFERENCES KEYWORD_ (keyword_id)
);

INSERT INTO USER_ VALUES ('199801192681', 'Sergi', 'sergi@gmail.com', 07354630, TRUE,'potatotortilla','uppsala', 'uppsala');
INSERT INTO USER_ VALUES ('199501992681', 'leyla', 'leyla@gmail.com', 07123430, FALSE,'enzodobby13','eriksberg', NULL);
INSERT INTO USER_ VALUES ('199638271631', 'Basak', 'Basak@gmail.com', 09898260, TRUE,'frozenfood','flogsta', NULL);

INSERT INTO DEPARTMENT_ VALUES ('00', NULL, 'Homepage', NULL);
INSERT INTO DEPARTMENT_ VALUES ('01', '00', 'Department1', NULL);
INSERT INTO DEPARTMENT_ VALUES ('02', '00', 'Department2', NULL);
INSERT INTO DEPARTMENT_ VALUES ('03', '01', 'Department3', NULL);
INSERT INTO DEPARTMENT_ VALUES ('04', '01', 'Department4', NULL);
INSERT INTO DEPARTMENT_ VALUES ('05', '01', 'Department5', NULL);
INSERT INTO DEPARTMENT_ VALUES ('06', '02', 'Department6', NULL);
INSERT INTO DEPARTMENT_ VALUES ('07', '02', 'Department7', NULL);
INSERT INTO DEPARTMENT_ VALUES ('08', '02', 'Department8', NULL);

INSERT INTO TAX_ VALUES ('Group1', 23.4);
INSERT INTO TAX_ VALUES ('Group2', 10);
INSERT INTO TAX_ VALUES ('Group3', 4.8);
INSERT INTO TAX_ VALUES ('Group4', 33.3);   

INSERT INTO PRODUCT_ VALUES ('00000', 200, 23.4, 'product1', NULL, TRUE, '03', 'Group1', 10);
INSERT INTO PRODUCT_ VALUES ('00001', 200, 23.4, 'product2', NULL, FALSE, '03', 'Group1', 20);
INSERT INTO PRODUCT_ VALUES ('00002', 200, 23.4, 'product3', NULL, FALSE, '07', 'Group1', NULL);
INSERT INTO PRODUCT_ VALUES ('00003', 200, 23.4, 'product4', NULL, FALSE, '04', 'Group2', 50);
INSERT INTO PRODUCT_ VALUES ('00004', 200, 23.4, 'product5', NULL, FALSE, '04', 'Group1', NULL);
INSERT INTO PRODUCT_ VALUES ('00005', 200, 23.4, 'product6', NULL, TRUE, '08', 'Group1', 10);
INSERT INTO PRODUCT_ VALUES ('00006', 200, 23.4, 'product7', NULL, FALSE, '05', 'Group1', NULL);
INSERT INTO PRODUCT_ VALUES ('00007', 200, 23.4, 'product8', NULL, TRUE, '05', 'Group4', NULL);
INSERT INTO PRODUCT_ VALUES ('00008', 200, 23.4, 'product9', NULL, FALSE, '05', 'Group1', 75);
INSERT INTO PRODUCT_ VALUES ('00009', 200, 23.4, 'product10', NULL, FALSE, '06', 'Group3', NULL);

INSERT INTO ORDER_ VALUES ('00001', NULL, NULL, 'ON DELIVERY', NULL, '2021-01-23', '199801192681');
INSERT INTO ORDER_ VALUES ('00002', NULL, NULL, 'ON DELIVERY', NULL, '2021-01-23', '199501992681');
INSERT INTO ORDER_ VALUES ('00003', NULL, NULL, 'ON DELIVERY', NULL, '2021-01-23', '199501992681');

INSERT INTO REVIEW_ VALUES ('1', 3.5, 'Very good', '00001', '199801192681');
INSERT INTO REVIEW_ VALUES ('2',1, 'Shity packaging', '00002', '199801192681');
INSERT INTO REVIEW_ VALUES ('3', 2.5, 'Shity packaging', '00002', '199801192681');
INSERT INTO REVIEW_ VALUES ('4', 2.5, 'Not too good, not too bad', '00003', '199801192681');
INSERT INTO REVIEW_ VALUES ('5',1.5, 'test', '00003', '199801192681');
INSERT INTO REVIEW_ VALUES ('6',5, 'Nays', '00002', '199801192681');

INSERT INTO ACCOUNTING_ VALUES ('00001', 22.2, 11, NULL, '00001', '00001');
INSERT INTO ACCOUNTING_ VALUES ('00002', 22.2, 11, NULL, '00002', '00002');
INSERT INTO ACCOUNTING_ VALUES ('00003', 22.2, 11, 5, '00003', '00003');

INSERT INTO KEYWORD_ VALUES (1,'fluffy');
INSERT INTO KEYWORD_ VALUES (2,'smooth');

INSERT INTO MATCHES_ VALUES (1,'00001','2');
INSERT INTO MATCHES_ VALUES (2,'00001','1');
INSERT INTO MATCHES_ VALUES (3,'00002','2');

UPDATE DEPARTMENT_ 
SET description_department = 'WELCOME PAGE HELLO '
WHERE department_id = '00';

-- SET FOREIGN_KEY_CHECKS=0;

-- Welcome text for the homepage
SELECT description_department 
FROM DEPARTMENT_
WHERE department_id = '00';

-- List of the top level departments with fields needed for the homepage
SELECT title, description_department
FROM DEPARTMENT_
WHERE parent_department = '00';

--  List of the featured products with fields needed for the homepage
SELECT title, description_table, retail_price
FROM PRODUCT_
WHERE featured_product = TRUE;

-- select * from PRODUCT_ p , MATCHES_ m  where p.product_id = '00002' and m.product_id = p.product_id;

--  Given a product, list all keyword-related products
SELECT p.title FROM PRODUCT_ p WHERE p.product_id IN (
SELECT m.product_id FROM MATCHES_ m WHERE m.keyword_id IN 
(SELECT m.keyword_id  FROM MATCHES_ m WHERE m.product_id = '00001'));

--  Given a department, list of all its products (title, short description, current retail price) with their average rating
SELECT title, description_table, (retail_price * ((100 - product_discount) / 100)) final, AVG(rating)   
FROM PRODUCT_ P INNER JOIN REVIEW_ R ON P.product_id = R.product_id
GROUP BY title, description_table, final;

SELECT product_id FROM PRODUCT_ WHERE department_id = '07';

/*List of all products on sale sorted by the discount percentage (starting with the biggest discount */
SELECT * FROM PRODUCT_ WHERE PRODUCT_ID IN ( SELECT product_id FROM ACCOUNTING_ where discount is not NULL ORDER BY DISCOUNT DESC);

-- CREATE INDEX review_orderid_index ON REVIEW_(order_id);
CREATE INDEX accounting_orderid_index ON ACCOUNTING_(order_id);
-- it makes more sense to add an index to the tables which have a possibility to grow by time like review and accounting tables.
-- as we have two queries using review and accounting tables on order_id we can create index for this columns.