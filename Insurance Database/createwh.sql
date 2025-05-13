USE insurance_database;
GO

CREATE TABLE Customer (
    PESEL VARCHAR(12) PRIMARY KEY,
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
    Policy_ID INT PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Coverage VARCHAR(30),
	AgentName VARCHAR(50),
    PESEL VARCHAR(12)
	FOREIGN KEY (AgentName) REFERENCES InsuranceAgent(AgentName),
    FOREIGN KEY (PESEL) REFERENCES Customer(PESEL)
);

CREATE TABLE Adjuster (
    AdjusterName VARCHAR(50) NOT NULL PRIMARY KEY,
    Email VARCHAR(50),
	Specialization VArchar(30)
);

CREATE TABLE Claim (
    Claim_ID INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
    Policy_ID INT,
    AdjusterName VARCHAR(50),
    FOREIGN KEY (Policy_ID) REFERENCES Policy(Policy_ID),
    FOREIGN KEY (AdjusterName) REFERENCES Adjuster(AdjusterName),
    
);
