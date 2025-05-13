USE insurance_warehouse;
GO


INSERT INTO dbo.Junk
SELECT s, f 
FROM 
	  (
		VALUES 
			('pending'),
            ('accepted'),
            ('declined')
	  ) 
	AS Status(s)
	
	, (
		VALUES 
			('fraud suspected'),
            ('not suspected of fraud')
	  ) 
	AS FraudSuspicion(f);
