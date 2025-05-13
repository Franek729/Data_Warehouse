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
	DateID INT IDENTITY(1,1) PRIMARY KEY,
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
    BirthDate INT,
	FOREIGN KEY (BirthDate) REFERENCES Date(DateID)
);

CREATE TABLE Policy (
    PolicyID INT IDENTITY(1,1) PRIMARY KEY,
	StartDateID INT,
	EndDateID INT,
    CoverageDetails VARCHAR(30),
	PayoutAmountCategory Varchar(30),
	FOREIGN KEY (StartDateID) REFERENCES Date(DateID),
	FOREIGN KEY (EndDateID) REFERENCES Date(DateID),
);

CREATE TABLE Junk(
	JunkID INT IDENTITY(1,1) PRIMARY KEY,
	Status varchar(30),
	FraudSuspicion Varchar(30),
	CONSTRAINT chk_Status CHECK (Status IN ('pending', 'accepted', 'declined')),
	CONSTRAINT chk_FraudSuspicion CHECK (FraudSuspicion IN ('fraud suspected', 'not suspected of fraud'))
);


CREATE TABLE ClaimProcessing (
    PolicyID INT,
    AdjusterID INT,
	CustomerID INT,
	AgentID INT,
	JunkID INT,
	SubmissionDateID INT,
	DecisionDateID INT,
	ClaimNumber Int IDENTITY(1,1),
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
