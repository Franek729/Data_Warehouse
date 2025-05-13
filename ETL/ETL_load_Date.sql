USE insurance_warehouse;
GO

DROP TABLE IF EXISTS DimDate;
GO

CREATE TABLE DimDate (
    [Date] DATE PRIMARY KEY,
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
        [Date],
        [Year],
        [MonthName],
        [MonthNumeric]
    )
    VALUES 
    (
        @DateInProcess,                          
        CAST(YEAR(@DateInProcess) AS VARCHAR(4)),   
        CAST(DATENAME(month, @DateInProcess) AS VARCHAR(10)),
        MONTH(@DateInProcess)                       
    );

    SET @DateInProcess = DATEADD(DAY, 1, @DateInProcess);
END;
GO