-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER PROCEDURE DBO.SP_HOSPITAL_ADMISSIONS_PER_MUNICIPALITY
AS
BEGIN
    INSERT INTO VWSDEST.DECEASED_PER_MUNICIPALITY
    (DATE_OF_REPORT, DATE_OF_REPORT_UNIX, MUNICIPALITY_CODE, MUNICIPALITY_NAME, DECEASED)
    SELECT
    DATE_OF_REPORT
    ,   dbo.CONVERT_DATETIME_TO_UNIX(DATE_OF_REPORT) AS [DATE_OF_REPORT_UNIX]
    ,   MUNICIPALITY_CODE
    ,   MUNICIPALITY_NAME
    ,   DECEASED
    FROM(
        SELECT
                DATE_OF_PUBLICATION AS DATE_OF_REPORT
            ,   MUNICIPALITY_CODE
            ,   MUNICIPALITY_NAME
            ,   SUM(DECEASED) AS DECEASED
            FROM VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY
            WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) FROM VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY)
            AND MUNICIPALITY_CODE != '' 
            GROUP BY DATE_OF_PUBLICATION, MUNICIPALITY_CODE, MUNICIPALITY_NAME
    ) AS SubqueryA 
END;

