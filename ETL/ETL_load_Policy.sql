USE insurance_warehouse;
GO

If (object_id('dbo.PoliciesDataTemp') is not null) DROP TABLE dbo.PoliciesDataTemp;
CREATE TABLE dbo.PoliciesDataTemp(PolicyID int, insurance_price int, minimal_payout int, maximal_payout int, duration_of_policy int);
go

BULK INSERT dbo.PoliciesDataTemp
    FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t1\csv\policies_data.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    TABLOCK
    )


IF OBJECT_ID('vETLDimPolicyData') IS NOT NULL
    DROP VIEW vETLDimPolicyData;
GO


CREATE VIEW vETLDimPolicyData AS

SELECT
    p1.PolicyID,
    CAST(CONVERT(varchar(8), p1.StartDate, 112) AS INT) AS StartDateID,
    CAST(CONVERT(varchar(8), p1.EndDate, 112) AS INT) AS EndDateID,
    p1.Coverage,
    CASE
        WHEN p2.maximal_payout BETWEEN 100000 AND 225000 THEN 'LOW'
        WHEN p2.maximal_payout BETWEEN 225001 AND 375000 THEN 'MEDIUM'
        WHEN p2.maximal_payout BETWEEN 375001 AND 500000 THEN 'HIGH'
    END AS PayoutAmountCategory
FROM insurance_database.dbo.Policy AS p1
JOIN insurance_warehouse.dbo.PoliciesDataTemp AS p2 ON p1.PolicyID = p2.PolicyID
JOIN insurance_warehouse.dbo.Date AS d1 ON CAST(CONVERT(varchar(8), p1.StartDate, 112) AS INT) = d1.DateID
JOIN insurance_warehouse.dbo.Date AS d2 ON CAST(CONVERT(varchar(8), p1.EndDate, 112) AS INT) = d2.DateID;
GO





MERGE INTO Policy AS Target
USING vETLDimPolicyData AS Source
ON Target.PolicyID = Source.PolicyID
WHEN NOT MATCHED THEN
    INSERT (PolicyID, StartDateID, EndDateID, CoverageDetails, PayoutAmountCategory)
    VALUES (Source.PolicyID, Source.StartDateID, Source.EndDateID, Source.Coverage, Source.PayoutAmountCategory)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


GO

DROP VIEW vETLDimPolicyData;
GO
