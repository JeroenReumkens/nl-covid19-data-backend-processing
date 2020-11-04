-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.
-- Table for the percentage of positive tested people per region with GGD.

IF NOT EXISTS(SELECT * FROM sys.sequences WHERE object_id = OBJECT_ID(N'[dbo].[SEQ_VWSINTER_GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION]') AND type = 'SO')
CREATE SEQUENCE SEQ_VWSINTER_GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION
  START WITH 1
  INCREMENT BY 1;
GO

CREATE TABLE VWSINTER.GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION(
	[ID] INT PRIMARY KEY NOT NULL DEFAULT (NEXT VALUE FOR [dbo].[SEQ_VWSINTER_GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION]),
  [WEEK OF APPOINTMENT] DATETIME NULL,
  [SECURITY REGION NAME] VARCHAR(100) NULL,
  [SECURITY REGION CODE] VARCHAR(100) NULL,
  [POPULATION PER SECURITY REGION] INT NULL,
  [TOTAL TESTED WITH RESULT] INT NULL,
  [TOTAL TESTED WITH RESULT/100.000] DECIMAL(16, 2) NULL,
  [TOTAL POSITIVE] INT NULL,
  [% POSITIVE] DECIMAL(16, 2),
  [POSITIVE/100.000] DECIMAL(16, 2),
	[DATE_LAST_INSERTED]  DATETIME DEFAULT GETDATE()
);