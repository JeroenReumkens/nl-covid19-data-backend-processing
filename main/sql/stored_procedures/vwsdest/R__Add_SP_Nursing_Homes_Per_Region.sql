CREATE OR ALTER PROCEDURE DBO.SP_NURSING_HOMES_PER_REGION
AS
BEGIN

    WITH TOTALS_PER_REGION AS (
        SELECT
            MELDINGSDATUMGGD,
            VEILIGHEIDSREGIOCODE,
            AANTAL as INFECTED_NURSERY_DAILY,
            DATE_LAST_INSERTED
        FROM VWSINTER.RIVM_NURSING_HOMES_TOTALS_PER_REGION
        WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) from VWSINTER.RIVM_NURSING_HOMES_TOTALS_PER_REGION)
    )

    , NEW_INFECTED_LOCATIONS_PER_REGION AS (
        SELECT
            PUBLICATIEDATUMRIVM,
            VEILIGHEIDSREGIOCODE,
            AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES,
            AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES,
            DATE_LAST_INSERTED
        FROM VWSINTER.RIVM_NURSING_HOMES_INFECTED_LOCATIONS_PER_REGION
        WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) from VWSINTER.RIVM_NURSING_HOMES_INFECTED_LOCATIONS_PER_REGION)
    )

    , DECEASED_PER_REGION AS (
        SELECT
            DATUM_VAN_OVERLIJDEN,
            VEILIGHEIDSREGIOCODE,
            AANTAL AS DECEASED_NURSERY_DAILY,
            DATE_LAST_INSERTED
        FROM VWSINTER.RIVM_NURSING_HOMES_DECEASED_PER_REGION
        WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) from VWSINTER.RIVM_NURSING_HOMES_DECEASED_PER_REGION)
    )

    , JOINED AS (
        SELECT
             T1.VEILIGHEIDSREGIOCODE as VRCODE,
             T1.MELDINGSDATUMGGD as DATE_OF_REPORT,
             T1.INFECTED_NURSERY_DAILY,
             T2.AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES,
             T2.AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES,
             T3.DECEASED_NURSERY_DAILY,
             T4.VERPLEEGHUIZEN
        FROM TOTALS_PER_REGION T1
        LEFT JOIN NEW_INFECTED_LOCATIONS_PER_REGION T2
            ON DATEDIFF(DAY, T1.MELDINGSDATUMGGD, T2.PUBLICATIEDATUMRIVM) = 0
            AND T1.VEILIGHEIDSREGIOCODE = T2.VEILIGHEIDSREGIOCODE
        LEFT JOIN DECEASED_PER_REGION T3
            ON DATEDIFF(DAY, T1.MELDINGSDATUMGGD, T3.DATUM_VAN_OVERLIJDEN) = 0
            AND T1.VEILIGHEIDSREGIOCODE = T3.VEILIGHEIDSREGIOCODE
        LEFT JOIN [VWSSTATIC].[V_NURSING_HOME_LOCATIONS_PER_REGION] T4
            ON T4.VRCODE = T1.VEILIGHEIDSREGIOCODE
    )

    INSERT INTO VWSDEST.NURSING_HOMES_PER_REGION
    (
        DATE_OF_REPORT,
        DATE_OF_REPORT_UNIX,
        VRCODE,
        INFECTED_NURSERY_DAILY,
        DECEASED_NURSERY_DAILY,
        TOTAL_NEW_REPORTED_LOCATIONS,
        TOTAL_REPORTED_LOCATIONS,
        INFECTED_LOCATIONS_PERCENTAGE
    )

    SELECT
        DATE_OF_REPORT,
        dbo.CONVERT_DATETIME_TO_UNIX(DATE_OF_REPORT) AS DATE_OF_REPORT_UNIX,
        VRCODE,
        ISNULL(INFECTED_NURSERY_DAILY, 0) AS INFECTED_NURSERY_DAILY,
        ISNULL(DECEASED_NURSERY_DAILY, 0) AS DECEASED_NURSERY_DAILY,
        ISNULL(AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES ,0) AS TOTAL_NEW_REPORTED_LOCATIONS,
        ISNULL(AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES , 0) AS TOTAL_REPORTED_LOCATIONS,
        ISNULL(ROUND(
            100 * CAST(AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES AS FLOAT) / VERPLEEGHUIZEN
            , 2
        ), 0) AS INFECTED_LOCATIONS_PERCENTAGE
    FROM JOINED
    WHERE DATE_OF_REPORT > '1900-01-01 00:00:00.000'
END;