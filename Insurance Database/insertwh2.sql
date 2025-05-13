USE insurance_database;
GO

BULK INSERT InsuranceAgent
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\agents.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Customer
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\customers.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Policy
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\policies.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Adjuster
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\adjusters.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO

BULK INSERT Claim
FROM 'C:\Users\pc\Desktop\Data_Warehouse\Generator\t2\csv\claims.csv'
WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);
GO