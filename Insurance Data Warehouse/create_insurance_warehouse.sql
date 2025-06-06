use insurance_warehouse
go



CREATE TABLE InsuranceAgent (
    AgentID INT IDENTITY(1,1) PRIMARY KEY,
    AgentName VARCHAR(50),
    Branch VARCHAR(30)
);

CREATE TABLE Adjuster (
    AdjusterID INT IDENTITY(1,1) PRIMARY KEY,
    AdjusterName VARCHAR(50),
    Specialization VARCHAR(30),
	IsCurrent Bit
);

CREATE TABLE Date(
	DateID INT PRIMARY KEY,
	Date date,
	Year INT,
	MonthNumeric INT,
	MonthName varchar(10)
);

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Pesel CHAR(11),
    Name VARCHAR(50),
    City VARCHAR(30),
    Street VARCHAR(100),
    AgeRange varchar(20),
);

CREATE TABLE Policy (
    PolicyID INT PRIMARY KEY,
	StartDateID INT,
	EndDateID INT,
    CoverageDetails VARCHAR(30),
	PayoutAmountCategory Varchar(30),
	FOREIGN KEY (StartDateID) REFERENCES Date(DateID),
	FOREIGN KEY (EndDateID) REFERENCES Date(DateID),
);

CREATE TABLE Junk(
	JunkID INT  PRIMARY KEY,
	Status varchar(30),
	FraudSuspicion Varchar(30),
);


CREATE TABLE ClaimProcessing (
    PolicyID INT,
    AdjusterID INT,
	CustomerID INT,
	AgentID INT,
	JunkID INT,
	SubmissionDateID INT,
	DecisionDateID INT,
	ClaimNumber Int,
	DaysForDecision INT,
	PayoutAmount INT,
    FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID),
    FOREIGN KEY (AdjusterID) REFERENCES Adjuster(AdjusterID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (AgentID) REFERENCES InsuranceAgent(AgentID),
	FOREIGN KEY (JunkID) REFERENCES Junk(JunkID),
	FOREIGN KEY (SubmissionDateID) REFERENCES Date(DateID),
	FOREIGN KEY (DecisionDateID) REFERENCES Date(DateID)
);
