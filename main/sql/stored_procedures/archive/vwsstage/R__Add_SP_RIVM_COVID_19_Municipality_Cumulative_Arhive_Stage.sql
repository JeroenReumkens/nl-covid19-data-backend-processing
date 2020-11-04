-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport.
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER PROCEDURE dbo.SP_RIVM_COVID_19_MUNICIPALITY_CUMULATIVE_ARCHIVE_STAGE
AS
BEGIN

    WITH SELECTED_TO_BE_ARCHIVED AS (
    SELECT
        DATE_OF_REPORT,
        MUNICIPALITY_CODE,
        MUNICIPALITY_NAME,
        PROVINCE,
        TOTAL_REPORTED,
        HOSPITAL_ADMISSION,
        DECEASED,
        DATE_LAST_INSERTED
    FROM VWSSTAGE.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE
     WHERE DATE_LAST_INSERTED IN (
        SELECT SubQueryC.DATE_LAST_INSERTED
        FROM(
        SELECT SubQueryB.DATE_LAST_INSERTED, SubQueryB.RANKING
        FROM (
            SELECT SubQueryA.DATE_LAST_INSERTED, rank() OVER(ORDER BY DATE_LAST_INSERTED DESC) RANKING
            FROM (
            SELECT DISTINCT DATE_LAST_INSERTED
            FROM VWSSTAGE.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE) SubQueryA
        ) SubQueryB
        WHERE SubQueryB.RANKING > 2)SubQueryC))


    INSERT INTO VWSARCHIVE.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE_ARCHIVE_STAGE
        (DATE_OF_REPORT,
        MUNICIPALITY_CODE,
        MUNICIPALITY_NAME,
        PROVINCE,
        TOTAL_REPORTED,
        HOSPITAL_ADMISSION,
        DECEASED,
        DATE_LAST_INSERTED)
     SELECT
        DATE_OF_REPORT,
        MUNICIPALITY_CODE,
        MUNICIPALITY_NAME,
        PROVINCE,
        TOTAL_REPORTED,
        HOSPITAL_ADMISSION,
        DECEASED,
        DATE_LAST_INSERTED
    FROM SELECTED_TO_BE_ARCHIVED;

    DELETE
    FROM VWSSTAGE.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE
     WHERE DATE_LAST_INSERTED IN (
        SELECT SubQueryC.DATE_LAST_INSERTED
        FROM(
        SELECT SubQueryB.DATE_LAST_INSERTED, SubQueryB.RANKING
        FROM (
            SELECT SubQueryA.DATE_LAST_INSERTED, rank() OVER(ORDER BY DATE_LAST_INSERTED DESC) RANKING
            FROM (
            SELECT DISTINCT DATE_LAST_INSERTED
            FROM VWSSTAGE.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE) SubQueryA
        ) SubQueryB
        WHERE SubQueryB.RANKING > 2)SubQueryC);
END;