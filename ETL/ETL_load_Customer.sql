USE insurance_warehouse;
GO

IF OBJECT_ID('vETLDimCustomerData') IS NOT NULL
    DROP VIEW vETLDimCustomerData;
GO

CREATE VIEW vETLDimCustomerData AS
SELECT
    PESEL,
    Name,
    City,
    Address AS Street,
    CAST(DateOfBirth AS DATE) AS BirthDate
FROM insurance_database.dbo.Customer
WHERE PESEL IS NOT NULL;
GO

MERGE INTO Customer AS Target
USING (
    SELECT
        v.PESEL,
        v.Name,
        v.City,
        v.Street,
		CASE
		WHEN DATEDIFF(year, v.BirthDate, CURRENT_TIMESTAMP) BETWEEN 18 AND 21 THEN '18-21'
		WHEN DATEDIFF(year, v.BirthDate, CURRENT_TIMESTAMP) BETWEEN 22 AND 29 THEN '22-29'
		WHEN DATEDIFF(year, v.BirthDate, CURRENT_TIMESTAMP) BETWEEN 30 AND 49 THEN '30-49'
		WHEN DATEDIFF(year, v.BirthDate, CURRENT_TIMESTAMP) BETWEEN 50 AND 64 THEN '50-64'
		WHEN DATEDIFF(year, v.BirthDate, CURRENT_TIMESTAMP) BETWEEN 65 AND 85 THEN '65-85'
	END AS [AgeRange]
    FROM vETLDimCustomerData v
) AS Source
ON Target.PESEL = Source.PESEL
WHEN NOT MATCHED THEN
    INSERT (Pesel, Name, City, Street, AgeRange)
    VALUES (Source.PESEL, Source.Name, Source.City, Source.Street, Source.AgeRange);
GO

DROP VIEW vETLDimCustomerData;
GO
