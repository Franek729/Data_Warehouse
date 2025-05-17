USE insurance_database;
GO

CREATE TABLE Customer (
    PESEL CHAR(11) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
	DateOfBirth DATE,
    Phone VARCHAR(11),
	City VARCHAR(30),
    Address VARCHAR(100),
	Email VARCHAR(50)
   
);

CREATE TABLE InsuranceAgent (
    AgentName VARCHAR(50) NOT NULL PRIMARY KEY,
	Email VARCHAR(50),
	Phone VARCHAR(11),
    Branch VARCHAR(30)
);

CREATE TABLE Policy (
    PolicyID INT PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
	PESEL CHAR(11),
	AgentName VARCHAR(50),
	Coverage VARCHAR(30),
	FOREIGN KEY (PESEL) REFERENCES Customer(PESEL),
	FOREIGN KEY (AgentName) REFERENCES InsuranceAgent(AgentName),
    
);

CREATE TABLE Adjuster (
    AdjusterName VARCHAR(50) NOT NULL PRIMARY KEY,
    Email VARCHAR(50),
	Specialization VArchar(30)
);

CREATE TABLE Claim (
    Claim_ID INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
	AdjusterName VARCHAR(50),
    PolicyID INT,
	FOREIGN KEY (AdjusterName) REFERENCES Adjuster(AdjusterName),
    FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID),

    
);
