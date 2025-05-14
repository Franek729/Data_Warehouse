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
USING vETLDimAdjusterData AS Source
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
	AND Target.AdjusterName != 'UNKNOWN' -- do not update the UNKNOWN tuple
THEN
	UPDATE
	SET Target.IsCurrent = 0
;

INSERT INTO Adjuster(
	AdjusterName, 
	Specialization, 
	IsCurrent
	)
	SELECT 
		AdjusterName, 
		Specialization, 
		1
	FROM vETLDimAdjusterData

DROP VIEW vETLDimAdjusterData;
GO