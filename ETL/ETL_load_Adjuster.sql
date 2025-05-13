USE insurance_warehouse;
GO

IF OBJECT_ID('vETLDimAdjusterData') IS NOT NULL
    DROP VIEW vETLDimAdjusterData;
GO

CREATE VIEW vETLDimAdjusterData AS
SELECT
    AdjusterName,
    Specialization,
    1 AS IsCurrent
FROM insurance_database.dbo.Adjuster;
GO

MERGE INTO Adjuster AS Target
USING (
    SELECT AdjusterName, Specialization, IsCurrent FROM vETLDimAdjusterData
) AS Source
ON Target.AdjusterName = Source.AdjusterName
WHEN NOT MATCHED THEN
    INSERT (AdjusterName, Specialization, IsCurrent)
    VALUES (Source.AdjusterName, Source.Specialization, Source.IsCurrent)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO

DROP VIEW vETLDimAdjusterData;
GO
