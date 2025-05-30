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
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t1\csv\claims_data.csv'
WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
     TABLOCK
 );

IF OBJECT_ID('vETLClaimProcessing') IS NOT NULL DROP VIEW vETLClaimProcessing;
GO


CREATE VIEW vETLClaimProcessing AS
SELECT
    c.Claim_ID AS ClaimNumber,
    p.PolicyID AS PolicyID,
    dAdj.AdjusterID AS AdjusterID,
    dCust.CustomerID AS CustomerID,
    dAgent.AgentID AS AgentID,
    c1.Claim_ID AS JunkID,
    d1.DateID AS SubmissionDateID,
    d2.DateID AS DecisionDateID,
    DATEDIFF(DAY, c1.SubmissionDate, c1.DecisionDate) AS DaysForDecision,
    c1.AmountPaid AS PayoutAmount
FROM insurance_database.dbo.Claim as c
JOIN dbo.ClaimsTemp as c1 ON c.Claim_ID = c1.Claim_ID
JOIN insurance_database.dbo.Policy p On c.PolicyID = p.PolicyID
JOIN insurance_warehouse.dbo.Policy dPol ON dPol.PolicyID = c.PolicyID 
JOIN insurance_warehouse.dbo.Adjuster dAdj ON dAdj.AdjusterName = c.AdjusterName
JOIN insurance_warehouse.dbo.Customer dCust ON dCust.PESEL = p.PESEL
JOIN insurance_warehouse.dbo.InsuranceAgent dAgent ON dAgent.AgentName = p.AgentName
JOIN insurance_warehouse.dbo.Date d1 ON c1.SubmissionDate = d1.Date
JOIN insurance_warehouse.dbo.Date d2 ON c1.DecisionDate = d2.Date;
GO




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



GO


DROP VIEW vETLClaimProcessing;
USE insurance_warehouse;
DROP TABLE dbo.ClaimsTemp;
GO