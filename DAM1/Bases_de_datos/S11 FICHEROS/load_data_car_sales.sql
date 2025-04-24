CREATE TABLE Car_Sales (
    Car_id VARCHAR(50),
    Date DATE,
    Customer_Name VARCHAR(100),
    Gender VARCHAR(10),
    Annual_Income INT,
    Dealer_Name VARCHAR(255),
    Company VARCHAR(50),
    Model VARCHAR(50),
    Engine VARCHAR(100),
    Transmission VARCHAR(50),
    Color VARCHAR(20),
    Price DECIMAL(10,2),
    Dealer_No VARCHAR(20),
    Body_Style VARCHAR(50),
    Phone VARCHAR(20),
    Dealer_Region VARCHAR(50),
    Description TEXT
);

-- No parseja be la data! 
-- No emplenta totes les columnes
LOAD DATA INFILE 'C:/Users/guill/Downloads/car_sales.csv'
INTO TABLE Car_Sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS

-- LOAD Correcte
LOAD DATA INFILE 'C:/Users/guill/Downloads/car_sales.csv'
INTO TABLE Car_Sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Car_id, @Date, Customer_Name, Gender, Annual_Income, Dealer_Name, Company, Model, Engine, Transmission, Color, Price, Dealer_No, Body_Style, Phone, Dealer_Region)
SET Date = STR_TO_DATE(@Date, '%m/%d/%Y');