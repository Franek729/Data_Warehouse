USE insurance_warehouse;
GO

IF OBJECT_ID('vETLDimAdjusterData') IS NOT NULL
    DROP VIEW vETLDimAdjusterData;
GO

CREATE VIEW vETLDimAdjusterData AS
SELECT
    AdjusterName,
    Specialization
FROM insurance_database.dbo.Adjuster;
GO

MERGE INTO Adjuster AS Target
USING (
    SELECT
        AdjusterName,
        Specialization
    FROM vETLDimAdjusterData
) AS Source
ON Target.AdjusterName = Source.AdjusterName
WHEN NOT MATCHED THEN
    INSERT (AdjusterName, Specialization, IsCurrent)
    VALUES (Source.AdjusterName, Source.Specialization, 1)
WHEN MATCHED 
	AND (Source.Specialization <> Target.Specialization)
THEN
    UPDATE
	SET Target.IsCurrent = 0
WHEN Not Matched BY Source
	AND Target.AdjusterName != 'UNKNOWN' 
THEN
	UPDATE
	SET Target.IsCurrent = 0
;

DROP VIEW vETLDimAdjusterData;
GO
