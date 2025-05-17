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

USE insurance_warehouse;
GO


IF OBJECT_ID('vETLClaimProcessing') IS NOT NULL DROP VIEW vETLClaimProcessing;
GO

CREATE VIEW vETLClaimProcessing AS
SELECT
    c.Claim_ID AS ClaimNumber,
    dwPol.PolicyID,                      -- Surrogate Key from DimPolicy
    dwAdj.AdjusterID,                    -- Surrogate Key from DimAdjuster
    dwCust.CustomerID,                   -- Surrogate Key from DimCustomer
    dwAgent.AgentID,                     -- Surrogate Key from DimAgent
    c.Claim_ID AS JunkID,
    d1.DateID AS SubmissionDateID,
    d2.DateID AS DecisionDateID,
    DATEDIFF(DAY, c1.SubmissionDate, c1.DecisionDate) AS DaysForDecision,
    c1.AmountPaid AS PayoutAmount
FROM insurance_database.dbo.Claim c
JOIN dbo.ClaimsTemp c1 ON c.Claim_ID = c1.Claim_ID

-- Join with source system to get business keys
JOIN insurance_database.dbo.Policy p ON c.PolicyID = p.PolicyID
JOIN insurance_database.dbo.Customer cu ON p.PESEL = cu.PESEL
JOIN insurance_database.dbo.InsuranceAgent a ON p.AgentName = a.AgentName

-- Join with warehouse dimensions using business keys
JOIN insurance_warehouse.dbo.Customer dwCust ON dwCust.PESEL = cu.PESEL
JOIN insurance_warehouse.dbo.InsuranceAgent dwAgent ON dwAgent.AgentName = a.AgentName
JOIN insurance_warehouse.dbo.Adjuster dwAdj ON dwAdj.AdjusterName = c.AdjusterName
JOIN insurance_warehouse.dbo.Policy dwPol ON dwPol.PolicyID= p.PolicyID -- if applicable

-- Dates
JOIN insurance_warehouse.dbo.Date d1 ON c1.SubmissionDate = d1.Date
JOIN insurance_warehouse.dbo.Date d2 ON c1.DecisionDate = d2.Date;
GO

SET IDENTITY_INSERT ClaimProcessing ON;

MERGE INTO ClaimProcessing AS Target
USING vETLClaimProcessing AS Source
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

SET IDENTITY_INSERT Policy OFF;

GO


DROP VIEW vETLClaimProcessing;
USE insurance_warehouse;
DROP TABLE dbo.ClaimsTemp;
GO
