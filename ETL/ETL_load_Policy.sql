USE insurance_warehouse;
GO

If (object_id('dbo.PoliciesDataTemp') is not null) DROP TABLE dbo.PoliciesDataTemp;
CREATE TABLE dbo.PoliciesDataTemp(PolicyID int, insurance_price int, minimal_payout int, maximal_payout int, duration_of_policy int);
go

BULK INSERT dbo.PoliciesDataTemp
    FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\policies_data.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )


IF OBJECT_ID('vETLDimPolicyData') IS NOT NULL
    DROP VIEW vETLDimPolicyData;
GO


CREATE VIEW vETLDimPolicyData AS
SELECT
    p1.PolicyID AS PolicyID,
    p1.StartDate,
    p1.EndDate,
    p1.Coverage,
    CASE
		WHEN p2.maximal_payout BETWEEN 100000 AND 225000 THEN 'LOW'
		WHEN p2.maximal_payout BETWEEN 225001 AND 375000 THEN 'MEDIUM'
		WHEN p2.maximal_payout BETWEEN 375001 AND 500000 THEN 'HIGH'
	END AS PayoutAmountCategory
FROM insurance_database.dbo.Policy as p1
JOIN dbo.PoliciesDataTemp as p2 ON p1.PolicyID = p2.PolicyID;
GO

MERGE INTO Policy AS Target
USING (
    SELECT 
        p.PolicyID,
        d1.DateID AS StartDateID,
        d2.DateID AS EndDateID,
        p.Coverage,
        p.PayoutAmountCategory
    FROM vETLDimPolicyData p
    JOIN Date d1 ON d1.Date = p.StartDate
    JOIN Date d2 ON d2.Date = p.EndDate
) AS Source
ON Target.PolicyID = Source.PolicyID
WHEN NOT MATCHED THEN
    INSERT (PolicyID, StartDateID, EndDateID, CoverageDetails, PayoutAmountCategory)
    VALUES (Source.PolicyID, Source.StartDateID, Source.EndDateID, Source.Coverage, Source.PayoutAmountCategory)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO

DROP VIEW vETLDimPolicyData;
GO
