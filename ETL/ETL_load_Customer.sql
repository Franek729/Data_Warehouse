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
        v.Address,
        d.DateID AS BirthDateID
    FROM insurance_database.dbo.Customer v
    JOIN Date d ON d.Date = v.DateOfBirth
) AS Source
ON Target.PESEL = Source.PESEL
WHEN NOT MATCHED THEN
    INSERT (Pesel, Name, City, Street, BirthDate)
    VALUES (Source.PESEL, Source.Name, Source.City, Source.Address, Source.BirthDateID);
GO

DROP VIEW vETLDimCustomerData;
GO
