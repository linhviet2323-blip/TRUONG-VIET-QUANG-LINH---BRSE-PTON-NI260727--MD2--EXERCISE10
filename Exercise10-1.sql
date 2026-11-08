CREATE DATABASE exercise10;
USE exercise10;
CREATE TABLE products(
productID INT PRIMARY KEY AUTO_INCREMENT,
productName VARCHAR(100) NOT NULL,
quantity INT NOT NULL
);
CREATE TABLE inventoryChanges(
changeID INT PRIMARY KEY AUTO_INCREMENT,
productID INT,
oldQuantity INT NOT NULL,
newQuantity INT NOT NULL,
changeDate DATE,
FOREIGN KEY (productID) REFERENCES products(productID)
);
DELIMITER $$
CREATE TRIGGER afterProductUpdate
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
	INSERT INTO inventoryChanges(
		productID,
        oldQuantity,
        newQuantity,
        changeDate
    )
    VALUES(
		OLD.productID,
        OLD.quantity,
        NEW.quantity,
        CURDATE()
    );
END$$
DELIMITER ;
INSERT INTO products(productName, quantity)
VALUES
('IPhone 15', 100),
('Samsung Galaxy S24', 50),
('Xiaomi 14', 80),
('MacBook Air M2', 30),
('AirPods Pro 2', 120);
SELECT * FROM products;
UPDATE products
SET quantity = 20
WHERE productID = 1;
UPDATE products
SET quantity = 50
WHERE productID = 5;
SELECT * FROM inventoryChanges;

