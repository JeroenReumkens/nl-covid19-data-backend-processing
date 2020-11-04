-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE NONCLUSTERED INDEX IX_ARCHIVE_RIVM_COVID_19_CASE_NATIONAL 
ON VWSARCHIVE.RIVM_COVID_19_CASE_NATIONAL_ARCHIVE_INTER (DATE_FILE, DATE_LAST_INSERTED)
INCLUDE(AGEGROUP)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_CASE_NATIONAL_DF
ON VWSINTER.RIVM_COVID_19_CASE_NATIONAL (DATE_FILE)