
CREATE DATABASE  SoilCropDB;
USE SoilCropDB;

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Role ENUM('Admin', 'Engineer')
);

CREATE TABLE SoilTest (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    PH FLOAT,
    Nitrogen FLOAT,
    Phosphorus FLOAT,
    Potassium FLOAT,
    SoilType VARCHAR(50),
    TestDate DATE,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Crop (
    CropID INT PRIMARY KEY AUTO_INCREMENT,
    CropName VARCHAR(100),
    SuitableSoilType VARCHAR(50)
);

CREATE TABLE Recommendation (
    RecID INT PRIMARY KEY AUTO_INCREMENT,
    TestID INT,
    CropID INT,
    DateRecommended DATE,
    FOREIGN KEY (TestID) REFERENCES SoilTest(TestID),
    FOREIGN KEY (CropID) REFERENCES Crop(CropID)
);

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpass';
CREATE USER 'engineer'@'localhost' IDENTIFIED BY 'engpass';

GRANT ALL PRIVILEGES ON SoilCropDB.* TO 'admin'@'localhost';
GRANT SELECT, INSERT ON SoilCropDB.SoilTest TO 'engineer'@'localhost';
GRANT SELECT ON SoilCropDB.Recommendation TO 'engineer'@'localhost';

INSERT INTO User (Name, Email, Role) VALUES
('Ahmed Ali', 'ahmed@example.com', 'Admin'),
('Fatma Hassan', 'fatma@example.com', 'Engineer'),
('Mohamed Salah', 'mohamed@example.com', 'Engineer'),
('Sara Youssef', 'sara@example.com', 'Admin'),
('Khaled Nabil', 'khaled@example.com', 'Engineer'),
('Laila Samir', 'laila@example.com', 'Engineer'),
('Youssef Ibrahim', 'youssef@example.com', 'Engineer'),
('Hana Omar', 'hana@example.com', 'Admin'),
('Ali Gamal', 'ali@example.com', 'Engineer'),
('Mona Tarek', 'mona@example.com', 'Engineer');

INSERT INTO Crop (CropName, SuitableSoilType) VALUES
('Wheat', 'Clay'),
('Corn', 'Loamy'),
('Rice', 'Silty'),
('Potato', 'Sandy'),
('Beans', 'Loamy'),
('Cotton', 'Clay'),
('Beet', 'Silty'),
('Onion', 'Loamy'),
('Tomato', 'Sandy'),
('Pepper', 'Sandy');

INSERT INTO SoilTest (PH, Nitrogen, Phosphorus, Potassium, SoilType, TestDate, UserID) VALUES
(6.5, 20, 10, 30, 'Clay', '2024-03-01', 2),
(6.8, 22, 12, 28, 'Loamy', '2024-03-02', 3),
(7.0, 18, 15, 25, 'Silty', '2024-03-03', 4),
(6.4, 19, 11, 26, 'Sandy', '2024-03-04', 5),
(6.7, 21, 13, 29, 'Clay', '2024-03-05', 6),
(6.3, 17, 9, 27, 'Loamy', '2024-03-06', 7),
(6.6, 23, 14, 31, 'Silty', '2024-03-07', 8),
(6.9, 24, 16, 32, 'Sandy', '2024-03-08', 9),
(6.2, 15, 8, 24, 'Loamy', '2024-03-09', 10),
(6.0, 16, 7, 23, 'Clay', '2024-03-10', 1);

INSERT INTO Recommendation (TestID, CropID, DateRecommended) VALUES
(1, 1, '2024-03-11'),
(2, 2, '2024-03-12'),
(3, 3, '2024-03-13'),
(4, 4, '2024-03-14'),
(5, 5, '2024-03-15'),
(6, 6, '2024-03-16'),
(7, 7, '2024-03-17'),
(8, 8, '2024-03-18'),
(9, 9, '2024-03-19'),
(10, 10, '2024-03-20');


SELECT * FROM Crop WHERE CropName LIKE '%Tomato%';

SELECT AVG(PH) AS AveragePH FROM SoilTest;

SELECT * FROM SoilTest ORDER BY TestDate ASC;

SELECT * FROM Crop ORDER BY CropName DESC;

SELECT User.Name AS UserName,Crop.CropName,Recommendation.DateRecommended
FROM Recommendation
INNER JOIN SoilTest ON Recommendation.TestID = SoilTest.TestID
INNER JOIN User ON SoilTest.UserID = User.UserID
INNER JOIN Crop ON Recommendation.CropID = Crop.CropID;

SELECT SoilType, COUNT(*) AS TestCount FROM SoilTest GROUP BY SoilType;

SELECT User.Name,COUNT(SoilTest.TestID) AS NumberOfTests
FROM  User
INNER JOIN SoilTest ON User.UserID = SoilTest.UserID
GROUP BY User.UserID
HAVING COUNT(SoilTest.TestID) > 2;


SELECT * FROM SoilTest WHERE PH BETWEEN 6.5 AND 7.0;

SELECT * FROM Crop WHERE SuitableSoilType IN ('Loamy', 'Sandy');

UPDATE SoilTest SET SoilType = 'Loamy' WHERE TestID = 1;

DELETE FROM Recommendation WHERE RecID = 1;
