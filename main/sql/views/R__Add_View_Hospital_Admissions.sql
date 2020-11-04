-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW VWSDEST.V_HOSPITAL_ADMISSIONS AS
SELECT 
    [DATE_OF_REPORT_UNIX],
    DBO.NO_NEGATIVE_NUMBER_F([MOVING_AVERAGE_HOSPITAL]) AS MOVING_AVERAGE_HOSPITAL,
    dbo.CONVERT_DATETIME_TO_UNIX(DATE_LAST_INSERTED)  AS DATE_OF_INSERTION_UNIX
FROM VWSDEST.HOSPITAL_ADMISSIONS
WHERE DATE_OF_REPORT >=  '2020-03-16 00:00:00.000'
AND DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED)
                            FROM VWSDEST.HOSPITAL_ADMISSIONS);
