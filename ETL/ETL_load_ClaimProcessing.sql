USE insurance_warehouse;
GO

IF OBJECT_ID('dbo.ClaimsTemp') IS NOT NULL DROP TABLE dbo.ClaimsTemp;
CREATE TABLE dbo.ClaimsTemp (
    Claim_ID INT,
    PolicyID INT,
    AdjusterName VARCHAR(50),
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

USE insurance_warehouse;
GO


IF OBJECT_ID('vETLClaimProcessing') IS NOT NULL DROP VIEW vETLClaimProcessing;
GO

CREATE VIEW vETLClaimProcessing AS
SELECT
    c.Claim_ID AS ClaimNumber,
    c.PolicyID,
    c.AdjusterName,
    p.PESEL,
    p.AgentName,
    c.FraudSuspicion AS Status,
    c.SubmissionDate,
    c.DecisionDate,
    DATEDIFF(DAY, c.SubmissionDate, c.DecisionDate) AS DaysForDecision,
    c.AmountPaid AS PayoutAmount
FROM dbo.ClaimsTemp c
JOIN insurance_database.dbo.Policy p ON c.PolicyID = p.PolicyID;
GO

MERGE INTO ClaimProcessing AS Target
USING (
    SELECT
        p.PolicyID,
        a.AdjusterID,
        cu.CustomerID,
        ag.AgentID,
        j.JunkID,
        d1.DateID AS SubmissionDateID,
        d2.DateID AS DecisionDateID,
        v.ClaimNumber,
        v.DaysForDecision,
        v.PayoutAmount
    FROM vETLClaimProcessing v
	JOIN Policy p ON p.PolicyID = v.PolicyID
    JOIN Adjuster a ON a.AdjusterName = v.AdjusterName AND a.isCurrent = 1
    JOIN Customer cu ON cu.PESEL = v.PESEL
    JOIN InsuranceAgent ag ON ag.AgentName = v.AgentName
    JOIN Junk j ON j.JunkID = v.JunkID
    JOIN Date d1 ON d1.Date = v.SubmissionDate
    JOIN Date d2 ON d2.Date = v.DecisionDate
) AS Source
ON Target.ClaimNumber = Source.ClaimNumber
WHEN NOT MATCHED THEN
    INSERT (
        PolicyID,
        AdjusterID,
        CustomerID,
        AgentID,
        JunkID,
        SubmissionDateID,
        DecisionDateID,
        ClaimNumber,
        DaysForDecision,
        PayoutAmount
    )
    VALUES (
        Source.PolicyID,
        Source.AdjusterID,
        Source.CustomerID,
        Source.AgentID,
        Source.JunkID,
        Source.SubmissionDateID,
        Source.DecisionDateID,
        Source.ClaimNumber,
        Source.DaysForDecision,
        Source.PayoutAmount
    );
GO


DROP VIEW vETLClaimProcessing;
USE insurance_database;
DROP TABLE dbo.ClaimsTemp;
GO
