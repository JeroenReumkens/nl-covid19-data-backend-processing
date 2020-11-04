-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

-- Create view for pulling infected people per age group
CREATE OR ALTER VIEW VWSDEST.V_POSITIVE_TESTED_PEOPLE_PER_AGE_GROUP AS
SELECT
    [DATE_OF_REPORT_UNIX],
    [AGEGROUP],
    DBO.NO_NEGATIVE_NUMBER_I([INFECTED_PER_AGEGROUP_INCREASE]) AS INFECTED_PER_AGEGROUP_INCREASE,
    dbo.CONVERT_DATETIME_TO_UNIX(DATE_LAST_INSERTED) AS DATE_OF_INSERTION_UNIX
FROM VWSDEST.POSITIVE_TESTED_PEOPLE_PER_AGE_GROUP
WHERE DATE_OF_REPORT_UNIX = (SELECT MAX(DATE_OF_REPORT_UNIX)
                            FROM VWSDEST.POSITIVE_TESTED_PEOPLE_PER_AGE_GROUP)
AND DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED)
                            FROM VWSDEST.POSITIVE_TESTED_PEOPLE_PER_AGE_GROUP)
AND AGEGROUP != 'UNKNOWN';