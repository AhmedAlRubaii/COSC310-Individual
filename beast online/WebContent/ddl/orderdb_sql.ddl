CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;

DROP TABLE users;
DROP TABLE keyCards;


CREATE TABLE keyCards (
 kuuid CHAR(36) NOT NULL,
 clearanceLevel INTEGER NOT NULL,
 isActive BIT NOT NULL DEFAULT 1,
 PRIMARY KEY (kuuid)
);

CREATE TABLE users (
 uuid CHAR(36) NOT NULL,
 firstName VARCHAR(64) NOT NULL,
 lastName VARCHAR(64) NOT NULL,			
 kuuid CHAR(36),
 loginKey VARCHAR(34),
 PRIMARY KEY (uuid),
 FOREIGN KEY (kuuid) REFERENCES keyCards(kuuid)
);

INSERT INTO keyCards VALUES ('38f5b748-0ca9-4873-ad07-014749cf8389', 5, 1);
INSERT INTO keyCards VALUES ('eba78f05-a0fe-43c1-be91-13adc826d495', 1, 0);
INSERT INTO keyCards VALUES ('6ebd1390-d91b-438e-9059-c1841f29ef71', 7, 1);
INSERT INTO keyCards VALUES ('9f17a7c1-ade9-49dd-baff-e152c3c9cb44', 4, 1);
INSERT INTO keyCards VALUES ('5f899d34-77b2-4cb6-aff1-15945766587e', 2, 1);

INSERT INTO users VALUES ('c88bb0d4-d6e6-48e8-a3ef-86e7550ea1b2','John', 'Doe', '38f5b748-0ca9-4873-ad07-014749cf8389', 'Johnpass');
INSERT INTO users VALUES ('b0915c8a-2a6d-4cbe-ad9d-3caa31c7e972','Jen', 'Doe', 'eba78f05-a0fe-43c1-be91-13adc826d495', NULL);
INSERT INTO users VALUES ('0dde60b8-b148-4d0a-bb3b-14fd9f4ab080','Satanshu', 'Mishra', '6ebd1390-d91b-438e-9059-c1841f29ef71', 'spass');
INSERT INTO users VALUES ('efcd102f-57f9-4c9b-a4f4-f92fd6c97b7f','Kate', 'Willams', '9f17a7c1-ade9-49dd-baff-e152c3c9cb44', 'kpass');
INSERT INTO users VALUES ('d20d7b15-3494-4116-977c-2664b464399f','Alice', 'Stone', '5f899d34-77b2-4cb6-aff1-15945766587e', NULL);

CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT IDENTITY,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Chairs');
INSERT INTO category(categoryName) VALUES ('Tables');
INSERT INTO category(categoryName) VALUES ('Lamps');
INSERT INTO category(categoryName) VALUES ('Sofas');
INSERT INTO category(categoryName) VALUES ('Beds');


INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Ingolf Chair', 1, '10 boxes x 20 bags',89.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Lerhamn Chair',1,'24 - 12 oz bottles',84.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Steffan Chair',1,'12 - 550 ml bottles',79.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Lisabo Table',2,'48 - 6 oz jars',139.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Ingatrop Table',2,'36 boxes',149.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Ingo Table',2,'12 - 8 oz jars',119.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Amazon Lamp',3,'12 - 1 lb pkgs.',15.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Astrid Lamp',3,'12 - 12 oz jars',29.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Snake Lamp',3,'18 - 500 g pkgs.',34.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Indivi Sofa',4,'12 - 200 ml jars',31.00);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Chaise Sofa',4,'1 kg pkg.',21.00);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Darcy Sofa',4,'10 - 500 g pkgs.',38.00);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Delta Racing Bed',5,'40 - 100 g pkgs.',199.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Awara Waterbed',5,'24 - 250 ml bottles',599.99);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Formula 1 Racing Bed',5,'32 - 500 g boxes',250.99);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO warehouse(warehouseName) VALUES ('Secondary Warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 2, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE ProductId = 15;


-- Loads image data for product 1
