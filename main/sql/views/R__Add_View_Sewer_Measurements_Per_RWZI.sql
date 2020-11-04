-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW [VWSDEST].[V_SEWER_MEASUREMENTS_PER_RWZI] AS
SELECT
            [DATE_MEASUREMENT_UNIX]
        ,    dbo.CONVERT_DATETIME_TO_UNIX(dbo.WEEK_START([DATE_MEASUREMENT])) AS WEEK_START_UNIX
        ,    dbo.CONVERT_DATETIME_TO_UNIX(dbo.WEEK_END([DATE_MEASUREMENT])) AS WEEK_END_UNIX
        ,   [WEEK]
        ,   [RWZI_AWZI_CODE]
        ,   [RWZI_AWZI_NAME]
        ,   [VRCODE]
        ,   [VRNAAM]
        ,   T2.GM_CODE AS GMCODE
        ,   RNA_FLOW_PER_100000 AS RNA_NORMALIZED
        ,   dbo.CONVERT_DATETIME_TO_UNIX(DATE_LAST_INSERTED) AS DATE_OF_INSERTION_UNIX
FROM VWSDEST.SEWER_MEASUREMENTS_PER_RWZI T1
LEFT JOIN VWSSTATIC.RWZI_GMCODE T2
ON T2.RWZI_CODE = T1.[RWZI_AWZI_CODE]
WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) FROM VWSDEST.SEWER_MEASUREMENTS_PER_RWZI)
AND RWZI_AWZI_CODE != '0'
AND GM_CODE IS NOT NULL
AND DATE_MEASUREMENT > '2020-01-01'