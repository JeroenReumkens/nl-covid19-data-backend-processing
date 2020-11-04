-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW VWSDEST.V_SEWER_MEASUREMENTS_PER_MUNICIPALITY_BACK_UP AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY WEEK_UNIX ASC) AS ID,
    [WEEK],
	[WEEK_UNIX],
	GMCODE,
	AVERAGE,
	DATE_LAST_INSERTED
FROM VWSDEST.SEWER_MEASUREMENTS_PER_MUNICIPALITY 
WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED)
                            FROM VWSDEST.SEWER_MEASUREMENTS_PER_MUNICIPALITY)