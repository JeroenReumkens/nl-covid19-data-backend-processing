-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER PROCEDURE [dbo].[SP_RESULTS_PER_REGION]
AS
BEGIN
-- Move municipal data from intermediate table to destination table. 
-- Base CTE (Common Table Expression) is the first selection on the source table on which two extra tables are joined to get residents per safety region. The result is filtered by max datelastinserted. 
WITH BASE_CTE AS (
SELECT 
	DATE_OF_REPORT
,	VRCODE
,	GMCODE
,	TOTAL_REPORTED
,	HOSPITAL_ADMISSION
,	DECEASED
,	INHABITANTS
,	T1.DATE_LAST_INSERTED
FROM VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE T1
LEFT JOIN [VWSSTATIC].[SAFETY_REGIONS_PER_MUNICIPAL]	T2	ON T1.MUNICIPALITY_CODE	= T2.GMCODE
LEFT JOIN [VWSSTATIC].[INHABITANTS_PER_SAFETY_REGION]   T3	ON T2.VRCODE			= T3.VGRNR
WHERE T1.DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) FROM VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE)
)

-- The second CTE uses the BASE_CTE as source and adds a calculation of [reported per region per 100000] and a total of [hospital admission]. It is grouped by report date and VRCODE. 
,	SECOND_CTE AS (
SELECT
    DATE_OF_REPORT
,   DATE_LAST_INSERTED
,   VRCODE
,   SUM(TOTAL_REPORTED) AS [TOTAL_REPORTED]
,   SUM(CAST(TOTAL_REPORTED AS FLOAT))/(CAST(INHABITANTS AS decimal(10,2))/CAST(100000 AS decimal(10,2))) AS [REPORTED_PER_REGION_100000]
,   SUM(CAST(HOSPITAL_ADMISSION AS FLOAT)) AS [HOSPITAL_ADMISSION_PER_REGION]
FROM BASE_CTE
GROUP BY DATE_LAST_INSERTED, DATE_OF_REPORT, VRCODE, INHABITANTS
)

-- The third CTE uses the SECOND_CTE as source. It adds logic to determine the date of report in unix and uses LAG functions to calculate the difference in reported per region between the last two days.
,	THIRD_CTE AS (
SELECT
    DATE_OF_REPORT
,	DATE_LAST_INSERTED
,   dbo.CONVERT_DATETIME_TO_UNIX(DATE_OF_REPORT) AS [DATE_OF_REPORT_UNIX]
,	VRCODE
,   ROUND(TOTAL_REPORTED - ISNULL(LAG(TOTAL_REPORTED) OVER (PARTITION BY DATE_LAST_INSERTED,VRCODE ORDER BY DATE_OF_REPORT), 0),1) AS TOTAL_REPORTED_INCREASE_PER_REGION
,	ROUND(REPORTED_PER_REGION_100000,2) AS [ROUNDED_REPORTED_PER_REGION_100000]
,	HOSPITAL_ADMISSION_PER_REGION
,	ROUND(REPORTED_PER_REGION_100000 - ISNULL(LAG(REPORTED_PER_REGION_100000) OVER (PARTITION BY DATE_LAST_INSERTED,VRCODE ORDER BY DATE_OF_REPORT), 0),1) AS INCREASE_INFECTED_PER_100000
,	HOSPITAL_ADMISSION_PER_REGION - ISNULL(LAG(HOSPITAL_ADMISSION_PER_REGION) OVER (PARTITION BY DATE_LAST_INSERTED,VRCODE ORDER BY DATE_OF_REPORT), 0) AS INCREASE_HOSPITAL
FROM SECOND_CTE
)

-- Final select and insert into statement. This part adds the calculation of a moving average of increased hospital admissions. It calculates it based on the previous 2 days as can be seen in row 59, after BETWEEN. 
INSERT INTO VWSDEST.RESULTS_PER_REGION
(DATE_OF_REPORT, DATE_OF_REPORT_UNIX, VRCODE, TOTAL_REPORTED_INCREASE_PER_REGION, INFECTED_TOTAL_COUNTS_PER_REGION, HOSPITAL_TOTAL_COUNTS_PER_REGION, INFECTED_INCREASE_PER_REGION, HOSPITAL_INCREASE_PER_REGION, HOSPITAL_MOVING_AVG_PER_REGION)
SELECT
    DATE_OF_REPORT
,	DATE_OF_REPORT_UNIX
,	VRCODE
,   TOTAL_REPORTED_INCREASE_PER_REGION
,	ROUNDED_REPORTED_PER_REGION_100000
,	HOSPITAL_ADMISSION_PER_REGION
,	INCREASE_INFECTED_PER_100000
,	INCREASE_HOSPITAL
,	ROUND(AVG(CAST(INCREASE_HOSPITAL AS FLOAT)) OVER (PARTITION BY DATE_LAST_INSERTED,VRCODE ORDER BY DATE_OF_REPORT ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),1) as [MOVING_AVERAGE_HOSPITAL]
FROM THIRD_CTE

END;
GO