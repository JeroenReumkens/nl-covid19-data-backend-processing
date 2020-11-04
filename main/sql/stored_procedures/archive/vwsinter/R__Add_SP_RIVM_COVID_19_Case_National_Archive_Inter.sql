-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER PROCEDURE dbo.SP_RIVM_COVID_19_CASE_NATIONAL_ARCHIVE_INTER
AS
BEGIN

    WITH SELECTED_TO_BE_ARCHIVED AS (
    SELECT
        DATE_FILE,
        DATE_STATISTICS,
        DATE_STATISTICS_TYPE,
        AGEGROUP,
        SEX,
        PROVINCE,
        HOSPITAL_ADMISSION,
        DECEASED,
        WEEK_OF_DEATH,
        MUNICIPAL_HEALTH_SERVICE,
        DATE_LAST_INSERTED
    FROM VWSINTER.RIVM_COVID_19_CASE_NATIONAL
    WHERE DATE_LAST_INSERTED IN (
        SELECT SubQueryC.DATE_LAST_INSERTED
        FROM(
        SELECT SubQueryB.DATE_LAST_INSERTED, SubQueryB.RANKING 
        FROM (
            SELECT SubQueryA.DATE_LAST_INSERTED, rank() OVER(ORDER BY DATE_LAST_INSERTED DESC) RANKING
            FROM (
            SELECT DISTINCT DATE_LAST_INSERTED
            FROM VWSINTER.RIVM_COVID_19_CASE_NATIONAL) SubQueryA
        ) SubQueryB
        WHERE SubQueryB.RANKING > 2)SubQueryC)) 


    INSERT INTO VWSARCHIVE.RIVM_COVID_19_CASE_NATIONAL_ARCHIVE_INTER
        (DATE_FILE, 
        DATE_STATISTICS, 
        DATE_STATISTICS_TYPE, 
        AGEGROUP, 
        SEX, 
        PROVINCE, 
        HOSPITAL_ADMISSION, 
        DECEASED, 
        WEEK_OF_DEATH, 
        MUNICIPAL_HEALTH_SERVICE, 
        DATE_LAST_INSERTED)
     SELECT
        DATE_FILE,
        DATE_STATISTICS,
        DATE_STATISTICS_TYPE,
        AGEGROUP,
        SEX,
        PROVINCE,
        HOSPITAL_ADMISSION,
        DECEASED,
        WEEK_OF_DEATH,
        MUNICIPAL_HEALTH_SERVICE,
        DATE_LAST_INSERTED
    FROM SELECTED_TO_BE_ARCHIVED;

    DELETE FROM VWSINTER.RIVM_COVID_19_CASE_NATIONAL
    WHERE DATE_LAST_INSERTED IN (
        SELECT SubQueryC.DATE_LAST_INSERTED
        FROM(
        SELECT SubQueryB.DATE_LAST_INSERTED, SubQueryB.RANKING 
        FROM (
            SELECT SubQueryA.DATE_LAST_INSERTED, rank() OVER(ORDER BY DATE_LAST_INSERTED DESC) RANKING
            FROM (
            SELECT DISTINCT DATE_LAST_INSERTED
            FROM VWSINTER.RIVM_COVID_19_CASE_NATIONAL) SubQueryA
        ) SubQueryB
        WHERE SubQueryB.RANKING > 2)SubQueryC);
END