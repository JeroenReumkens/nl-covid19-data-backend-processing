-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

-- Intermediate table of infectious cases from RIVM

IF NOT EXISTS(SELECT * FROM sys.sequences WHERE object_id = OBJECT_ID(N'[dbo].[SEQ_VWSINTER_RIVM_INFECTIOUS_PEOPLE]') AND type = 'SO')
CREATE SEQUENCE SEQ_VWSINTER_RIVM_INFECTIOUS_PEOPLE
  START WITH 1
  INCREMENT BY 1;
GO

CREATE TABLE VWSINTER.RIVM_INFECTIOUS_PEOPLE(
	[ID] INT PRIMARY KEY NOT NULL DEFAULT (NEXT VALUE FOR [dbo].[SEQ_VWSINTER_RIVM_INFECTIOUS_PEOPLE]),
	[DATE] DATETIME NULL,
	[PREV_LOW] INT NULL,
	[PREV_AVG] INT NULL,
	[PREV_UP] INT NULL,
	DATE_LAST_INSERTED DATETIME DEFAULT GETDATE()
);