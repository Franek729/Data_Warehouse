USE warehousy;
GO

BULK INSERT InsuranceAgent
FROM 'C:\Users\szymo\Desktop\DataGenerator-main\t1_agents.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Customer
FROM 'C:\Users\szymo\Desktop\DataGenerator-main\t1_customers.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Policy
FROM 'C:\Users\szymo\Desktop\DataGenerator-main\t1_policies.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Adjuster
FROM 'C:\Users\szymo\Desktop\DataGenerator-main\t1_adjusters.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Claim
FROM 'C:\Users\szymo\Desktop\DataGenerator-main\t1_claims.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO