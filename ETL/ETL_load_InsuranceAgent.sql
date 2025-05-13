USE insurance_warehouse;
GO

IF OBJECT_ID('vETLDimAgentData') IS NOT NULL
    DROP VIEW vETLDimAgentData;
GO

CREATE VIEW vETLDimAgentData AS
SELECT
    AgentName,
    Branch
FROM insurance_database.dbo.InsuranceAgent;
GO

MERGE INTO InsuranceAgent AS Target
USING (
    SELECT
        AgentName,
        Branch
    FROM vETLDimAgentData
) AS Source
ON Target.AgentName = Source.AgentName
WHEN NOT MATCHED THEN
    INSERT (AgentName, Branch)
    VALUES (Source.AgentName, Source.Branch)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
GO

DROP VIEW vETLDimAgentData;
GO
