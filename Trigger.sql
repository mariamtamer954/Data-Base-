--This code creates a table named LogUsers to log user-related events, adds a trigger to insert a record into this table after a new user is inserted into the Users table, inserts user data for verification, and finally selects all records from the LogUsers table.
CREATE TABLE  LogUsers (
    log_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    user_name VARCHAR(225),
    user_status VARCHAR(225),
    user_phonenumber VARCHAR(20),
    Status VARCHAR(255), 
    log_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users([UserID])
);

CREATE TRIGGER AfterUserLog
ON Users
AFTER INSERT
AS
BEGIN
    INSERT INTO LogUsers (user_id, user_name, user_status, user_phonenumber, Status, log_time) 
    SELECT UserID, Username, 'Active', '', 'Insert', GETDATE() 
    FROM inserted;
END;

INSERT INTO users ([UserID], [Username], [Email], [Theme], [Password])
VALUES (370, 'example_user', 'example@example.com', 'light', 'password123');

INSERT INTO users ([UserID], [Username], [Email], [Theme], [Password])
VALUES (380, 'example_user', 'example@example.com', 'light', 'password123');

INSERT INTO users ([UserID], [Username], [Email], [Theme], [Password])
VALUES (390, 'example_user', 'example@example.com', 'light', 'password123');

INSERT INTO users ([UserID], [Username], [Email], [Theme], [Password])
VALUES (400, 'example_user', 'example@example.com', 'light', 'password123');

SELECT  * FROM  LogUsers

--This code creates a table named UserAudits to record changes, then sets up a trigger named InsertOrDelete to record insertions and deletions in the Users table. Some data is inserted into the Users table for testing purposes, and then data for a specific user (with ID 9000) is deleted. Finally, the data from the UserAudits table is selected to verify that the changes were recorded correctly.

CREATE TABLE UserAudits (
    change_id INT IDENTITY PRIMARY KEY,
    UserID INT NOT NULL,
    Username CHAR(255),
    Email VARCHAR(255),
    Age INT,
    Theme VARCHAR(6),
    Password VARCHAR(55),
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' OR operation = 'DEL')
);

CREATE OR ALTER TRIGGER InsertOrDelete
ON Users
AFTER INSERT, DELETE
AS
BEGIN
    INSERT INTO UserAudits (
        UserID,
        Username,
        Email,
        Age,
        Theme,
        Password,
        updated_at,
        operation
    )
    SELECT i.UserID, i.Username, i.Email, i.Age, i.Theme, i.Password, GETDATE(), 'INS'
    FROM inserted AS i
    UNION ALL
    SELECT d.UserID, d.Username, d.Email, d.Age, d.Theme, d.Password, GETDATE(), 'DEL'
    FROM deleted AS d;
END;

INSERT INTO Users (UserID, Username, Email, Age, Theme, Password)
VALUES 
(5080, 'user1', 'user1@example.com', 25, 'Light', 'password1'),
(9000, 'user2', 'user2@example.com', 30, 'Dark', 'password2'),
(10000, 'user2', 'user2@example.com', 30, 'Dark', 'password2');


INSERT INTO Users (UserID, Username, Email, Age, Theme, Password)
VALUES 
(50800, 'user1', 'user1@example.com', 25, 'Light', 'password1')

DELETE FROM Users WHERE UserID = 9000;
SELECT * FROM UserAudits;