Create Database Library_management_db;
use Library_management_db;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
	Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
	Phone VARCHAR(15) NOT NULL UNIQUE,
    Role ENUM('Librarian', 'Customer','Other') NOT NULL,
	created_at bigint,
    updated_at BIGInt
);

Create Table Address(
	UserId INT NOT NULL unique,
	Address_line1 VARCHAR(255),
    Address_line2 VARCHAR(255),	
	City VARCHAR(100),
	State VARCHAR(100),
	Zip VARCHAR(20),
	Country VARCHAR(100)
);

CREATE TABLE Librarian (
    LibrarianID INT AUTO_INCREMENT PRIMARY KEY,
    HireDate DATE NOT NULL,
    UserID INT NOT NULL UNIQUE,
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    RegistrationDate DATE NOT NULL,
    UserID INT NOT NULL UNIQUE,
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    Publisher VARCHAR(100),
    PublishedYear YEAR NOT NULL CHECK (PublishedYear >= 1900 AND PublishedYear <= YEAR(CURDATE())),
	TotalCopies INT NOT NULL CHECK (TotalCopies >= 0), 
    AvailableCopies INT NOT NULL CHECK (AvailableCopies >= 0 AND AvailableCopies <= TotalCopies),
    Genre VARCHAR(50)
);


CREATE TABLE IssueStatus (
    IssueID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookID INT NOT NULL,
    IssueDate DATE NOT NULL,
    DueDate DATE NOT NULL CHECK (DueDate > IssueDate),
    LibrarianID INT NOT NULL,  -- issued by
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID)
);

CREATE TABLE ReturnStatus (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    IssueID INT NOT NULL UNIQUE,
    Return_date DATE NOT NULL,
    Fine_amount DECIMAL(10, 2) DEFAULT 0 CHECK (FineAmount >= 0),
    LibrarianID INT NOT NULL, -- Receiver
    FOREIGN KEY (IssueID) REFERENCES IssueStatus(IssueID),
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID)
);

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    IssueID INT,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount > 0),
    Transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Transaction_type ENUM('Fine', 'book','Membership', 'Other') NOT NULL,
    FOREIGN KEY (IssueID) REFERENCES Customer(IssueID)
);

CREATE TABLE AuditLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,             
    Action ENUM('ADD', 'ISSUE', 'RETURN', 'ZERO_COPIES','Other' ) NOT NULL Default 'Other', 
    BookID INT,                                       
    CustomerID INT,
    LibrarianID INT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    Details TEXT,                                     
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL,
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID) ON DELETE SET NULL
);

ALTER TABLE Books 
ADD COLUMN created_at bigint;
ALTER TABLE Books 
ADD COLUMN modified_at bigint;
DROP TABLE Address;
