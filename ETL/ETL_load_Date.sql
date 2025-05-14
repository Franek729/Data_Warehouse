USE insurance_warehouse;
GO

DROP TABLE IF EXISTS DimDate;
GO

CREATE TABLE DimDate (
	DateID INT PRIMARY KEY,
    [Date] DATE NOT NULL,
    [Year] VARCHAR(4),
    [MonthName] VARCHAR(10),
    [MonthNumeric] INT
);


DECLARE @StartDate DATE; 
DECLARE @EndDate DATE;


SELECT @StartDate = '2010-01-01', @EndDate = '2020-12-31';


DECLARE @DateInProcess DATETIME = @StartDate;

WHILE @DateInProcess <= @EndDate
BEGIN
    INSERT INTO [dbo].[DimDate] 
    (	
		DateID,
        [Date],
        [Year],
        [MonthName],
        [MonthNumeric]
    )
    VALUES 
    (
		CONVERT(INT, FORMAT(@DateInProcess, 'yyyyMMdd')),
        @DateInProcess,                          
        CAST(YEAR(@DateInProcess) AS VARCHAR(4)),   
        CAST(DATENAME(month, @DateInProcess) AS VARCHAR(10)),
        MONTH(@DateInProcess)                       
    );

    SET @DateInProcess = DATEADD(DAY, 1, @DateInProcess);
END;
GO

If (object_id('vETLDimDatesData') is not null) Drop View vETLDimDatesData;
go

CREATE VIEW vETLDimDatesData
AS
SELECT 
	dd.DateID
	, dd.Date
	, dd.Year
	, dd.MonthName,
	dd.MonthNumeric
FROM dbo.DimDate dd
go

MERGE INTO DimDate AS Target
USING vETLDimDatesData AS Source
    ON Target.Date = Source.Date
WHEN NOT MATCHED BY TARGET THEN
    INSERT (DateID, Date, Year, MonthName, MonthNumeric)
    VALUES (Source.DateID, Source.Date, Source.Year, Source.MonthName, Source.MonthNumeric);
GO

DROP VIEW vETLDimDatesData;
GO
