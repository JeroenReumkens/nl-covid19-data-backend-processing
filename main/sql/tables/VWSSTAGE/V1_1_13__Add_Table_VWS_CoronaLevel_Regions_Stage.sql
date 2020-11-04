-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport.
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.
-- Table for raw input of sewage measurements

IF NOT EXISTS(SELECT * FROM sys.sequences WHERE object_id = OBJECT_ID(N'[dbo].[SEQ_VWSSTAGE_VWS_CORONALEVEL_REGIONS]') AND type = 'SO')
CREATE SEQUENCE SEQ_VWSSTAGE_VWS_CORONALEVEL_REGIONS
  START WITH 1
  INCREMENT BY 1;
GO

CREATE TABLE VWSSTAGE.VWS_CORONALEVEL_REGIONS(
    [ID] INT PRIMARY KEY NOT NULL DEFAULT (NEXT VALUE FOR [dbo].[SEQ_VWSSTAGE_VWS_CORONALEVEL_REGIONS]),
	VEILIGHEIDSREGIO_NAAM VARCHAR(100) NULL,
    VEILIGHEIDSREGIO_CODE VARCHAR(100) NULL,
    [CORONANIVEAU_CODE] VARCHAR(100) NULL,
    [CORONANIVEAU_NAAM] VARCHAR(100) NULL,
    GELDIG_VANAF_DATUM VARCHAR(100) NULL,
    GELDIG_TM_DATUM VARCHAR(100) NULL,
    TEKSTUELE_DUIDING VARCHAR(100) NULL,
    CONTACTPERSOON_1_NAAM VARCHAR(100) NULL,
    CONTACTPERSOON_2_NAAM VARCHAR(100) NULL,
    CONTACTPERSOON_1_EMAIL VARCHAR(100) NULL,
    CONTACTPERSOON_2_EMAIL VARCHAR(100) NULL,
    DOOR_WIE_INGEVULD VARCHAR(100) NULL,
    DOOR_WIE_GECHECKT VARCHAR(100) NULL,
    DATUM_INGEVULD VARCHAR(100) NULL,
	[DATE_LAST_INSERTED]  DATETIME DEFAULT GETDATE()
);

CREATE NONCLUSTERED INDEX IX_VWS_CORONALEVEL_REGIONS_STAGE
ON VWSSTAGE.VWS_CORONALEVEL_REGIONS(DATE_LAST_INSERTED);