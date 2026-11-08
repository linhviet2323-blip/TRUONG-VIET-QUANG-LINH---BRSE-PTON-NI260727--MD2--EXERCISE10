CREATE DATABASE exercise10_2;
USE exercise10_2;
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
changeDate DATETIME,
	FOREIGN KEY (productID) REFERENCES products(productID)
);

DELIMITER $$

CREATE TRIGGER beforeProductDelete
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
	IF OLD.quantity > 10 THEN 
		SIGNAL SQLSTATE'45000'
        SET MESSAGE_TEXT ='Khong the xoa san pham co so luong lon hon 10';
	END IF;
END$$

DELIMITER ;
INSERT INTO products(productName, quantity)
VALUES
('IPhone 15', 100),
('Samsung Galaxy S24', 50),
('Xiaomi 14', 8),
('MacBook Air M2', 5),
('AirPods Pro 2', 8);
SELECT * FROM products;
DELETE FROM products
WHERE productID = 1;
DELETE FROM products
WHERE productID = 3;