--CREATE TABLES-----------------------------------------------------------------------------------------------------

CREATE TABLE Item(
ItemID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
ItemCategoryID INT FOREIGN KEY REFERENCES ItemCategory(ItemCategoryID),
Description VARCHAR(1000),
MaterialCostID INT FOREIGN KEY REFERENCES MaterialCost(MaterialCostID),
LaborCostID INT FOREIGN KEY REFERENCES LaborCost(LaborCostID),
DiscountID INT FOREIGN KEY REFERENCES Discount(DiscountID),
ProfitID INT FOREIGN KEY REFERENCES Profit(ProfitID),
TotalCost DECIMAL(19,4) NOT NULL,
Active BIT NOT NULL,
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

CREATE TABLE ItemCategory(
ItemCategoryID INT IDENTITY(1,1) PRIMARY KEY,
CategoryName VARCHAR(255) NOT NULL,
Description VARCHAR(255),
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

CREATE TABLE MaterialCost(
MaterialCostID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
Description VARCHAR(255) NOT NULL,
RawMaterialCost DECIMAL(19,4) NOT NULL,
ShippingCost DECIMAL(19,4) NOT NULL,
TotalCost DECIMAL(19,4) NOT NULL,
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

CREATE TABLE LaborCost(
LaborCostID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
Description VARCHAR(255) NOT NULL,
ManHours DECIMAL(19,4),
Rate DECIMAL(19,4) NOT NULL,
TotalCost DECIMAL(19,4) NOT NULL,
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

CREATE TABLE Discount(
DiscountID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
Description VARCHAR(255) NOT NULL,
Amount DECIMAL(19,4) NOT NULL,
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

CREATE TABLE Profit(
ProfitID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
Description VARCHAR(255) NOT NULL,
Amount DECIMAL(19,4) NOT NULL,
CreatedBy VARCHAR(50) NOT NULL,
CreatedDateTime DATETIME NOT NULL,
UpdatedBy VARCHAR(50),
UpdatedDateTime DATETIME
)

--SELECT FROM TABLES-----------------------------------------------------------------------------------------------------

SELECT *
FROM Item

SELECT *
FROM ItemCategory

SELECT *
FROM MaterialCost

SELECT *
FROM LaborCost

SELECT *
FROM Discount

SELECT *
FROM Profit

--CALL STORED PROCEDURE-----------------------------------------------------------------------------------------------------

--Updating cost of all items
EXEC sp_UpdateItemCost 
@UpdateAllItems = 1

--Updating cost of a single item
EXEC sp_UpdateItemCost 
@UpdateAllItems = 0,
@ItemToUpdate = 2

