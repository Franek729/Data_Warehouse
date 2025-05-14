USE insurance_warehouse;
GO

IF OBJECT_ID('dbo.ClaimsTemp') IS NOT NULL DROP TABLE dbo.ClaimsTemp;
CREATE TABLE dbo.ClaimsTemp (
    Claim_ID INT,
    SubmissionDate DATE,
    DecisionDate DATE,
    PayoutDate DATE,
    AmountPaid MONEY,
    FraudSuspicion VARCHAR(30)
);
GO


BULK INSERT dbo.ClaimsTemp
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\claims_data.csv'
WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
     TABLOCK
 );

IF OBJECT_ID('vETLDimJunkData') IS NOT NULL
    DROP VIEW vETLDimJunkData;
GO

CREATE VIEW vETLDimJunkData AS
SELECT
    c.Claim_ID as JunkID,
	c.Status,
	c1.FraudSuspicion
FROM insurance_database.dbo.Claim as c
JOIN dbo.ClaimsTemp as c1 ON c.Claim_ID = c1.Claim_ID;
GO

MERGE INTO Junk AS Target
USING vETLDimJunkData AS Source
ON Target.JunkID = Source.JunkID
WHEN NOT MATCHED THEN
    INSERT (Status, FraudSuspicion)
    VALUES (Source.Status, Source.FraudSuspicion)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO
DROP TABLE dbo.ClaimsTemp;
DROP VIEW vETLDimJunkData;
GO
