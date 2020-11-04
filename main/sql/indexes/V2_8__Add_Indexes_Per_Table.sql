-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_COVID_19_CASE_NATIONAL
ON VWSSTAGE.RIVM_COVID_19_CASE_NATIONAL (DATE_LAST_INSERTED) 
INCLUDE (DATE_FILE, DATE_STATISTICS, DATE_STATISTICS_TYPE, AGEGROUP, SEX, 
PROVINCE, HOSPITAL_ADMISSION, DECEASED, WEEK_OF_DEATH, MUNICIPAL_HEALTH_SERVICE);

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_COVID_19_NUMBER_MUNICIPALITY
ON VWSSTAGE.RIVM_COVID_19_NUMBER_MUNICIPALITY (DATE_LAST_INSERTED) 
INCLUDE (DATE_OF_REPORT, DATE_OF_PUBLICATION, MUNICIPALITY_CODE, MUNICIPALITY_NAME, PROVINCE, 
SECURITY_REGION_CODE, SECURITY_REGION_NAME, MUNICIPAL_HEALTH_SERVICE, ROAZ_REGION, TOTAL_REPORTED, HOSPITAL_ADMISSION, DECEASED);

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_SEWER_MEASUREMENTS_DM
ON VWSINTER.RIVM_SEWER_MEASUREMENTS (DATE_LAST_INSERTED) 
INCLUDE (DATE_MEASUREMENT, RWZI_AWZI_CODE, RWZI_AWZI_NAME, SECURITY_REGION_CODE, REPRESENTATIVE_MEASUREMENT)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_SEWER_MEASUREMENTS
ON VWSSTAGE.RIVM_SEWER_MEASUREMENTS (DATE_LAST_INSERTED) 
INCLUDE (DATE_MEASUREMENT, RWZI_AWZI_CODE, RWZI_AWZI_NAME, X_COORDINATE, Y_COORDINATE, POSTAL_CODE, SECURITY_REGION_CODE, 
SECURITY_REGION_NAME, PERCENTAGE_IN_SECURITY_REGION, RNA_PER_ML, REPRESENTATIVE_MEASUREMENT)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_TOTALS_PER_REGION
ON VWSSTAGE.RIVM_NURSING_HOMES_TOTALS_PER_REGION (DATE_LAST_INSERTED) 
INCLUDE (VEILIGHEIDSREGIOCODE, VEILIGHEIDSREGIONAAM, MELDINGSDATUMGGD, AANTAL)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_INFECTED_LOCATIONS_PER_REGION
ON VWSSTAGE.RIVM_NURSING_HOMES_INFECTED_LOCATIONS_PER_REGION (DATE_LAST_INSERTED) 
INCLUDE (VEILIGHEIDSREGIOCODE, VEILIGHEIDSREGIONAAM, PUBLICATIEDATUMRIVM, 
AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES, AANTAL_NIEUW_BESMETTINGSVRIJE_VERPLEEGHUIS_LOCATIES, 
AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_INFECTED_LOCATIONS
ON VWSSTAGE.RIVM_NURSING_HOMES_INFECTED_LOCATIONS (DATE_LAST_INSERTED) 
INCLUDE (PUBLICATIEDATUMRIVM, AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES, AANTAL_NIEUW_BESMETTINGSVRIJE_VERPLEEGHUIS_LOCATIES, 
AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_HANDICAPPED_TOTALS
ON VWSSTAGE.RIVM_NURSING_HOMES_HANDICAPPED_TOTALS (DATE_LAST_INSERTED) 
INCLUDE (MELDINGSDATUM, AANTAL)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_HANDICAPPED_INFECTED_LOCATIONS
ON VWSSTAGE.RIVM_NURSING_HOMES_HANDICAPPED_INFECTED_LOCATIONS (DATE_LAST_INSERTED) 
INCLUDE (PUBLICATIEDATUMRIVM, AANTAL_BESMETTE_GEHANDICAPTENZORGINSTELLING_LOCATIES, 
AANTAL_NIEUW_BESMETTE_GEHANDICAPTENZORGINSTELLING_LOCATIES, AANTAL_NIEUW_BESMETTINGSVRIJE_GEHANDICAPTENZORGINSTELLING_LOCATIES)

CREATE NONCLUSTERED INDEX IX_STAGE_RIVM_NURSING_HOMES_DECEASED_PER_REGION
ON VWSSTAGE.RIVM_NURSING_HOMES_DECEASED_PER_REGION (DATE_LAST_INSERTED) 
INCLUDE (VEILIGHEIDSREGIOCODE, VEILIGHEIDSREGIONAAM, DATUM_VAN_OVERLIJDEN, AANTAL)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (DATE_LAST_INSERTED) 
INCLUDE (DATE_OF_PUBLICATION, SECURITY_REGION_CODE, TOTAL_REPORTED, HOSPITAL_ADMISSION, DECEASED)

CREATE NONCLUSTERED INDEX IX_INTER_GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION
ON VWSINTER.GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION (DATE_LAST_INSERTED) 
INCLUDE ([WEEK OF APPOINTMENT], [SECURITY REGION CODE], [TOTAL TESTED WITH RESULT], [TOTAL POSITIVE], [% POSITIVE])

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY_MC
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (MUNICIPALITY_CODE) 
INCLUDE (DATE_OF_PUBLICATION, MUNICIPALITY_NAME, TOTAL_REPORTED, DATE_LAST_INSERTED)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY_DLI
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (DATE_LAST_INSERTED) 
INCLUDE (DATE_OF_PUBLICATION, MUNICIPALITY_CODE, MUNICIPALITY_NAME, TOTAL_REPORTED)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_NURSING_HOMES_TOTALS_MD
ON VWSINTER.RIVM_NURSING_HOMES_TOTALS (MELDINGSDATUM) 
INCLUDE (AANTAL, DATE_LAST_INSERTED)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_NURSING_HOMES_INFECTED_LOCATIONS_PD
ON VWSINTER.RIVM_NURSING_HOMES_INFECTED_LOCATIONS (PUBLICATIEDATUMRIVM) 
INCLUDE (AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES, AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_NURSING_HOMES_INFECTED_LOCATIONS_DLI
ON VWSINTER.RIVM_NURSING_HOMES_INFECTED_LOCATIONS (DATE_LAST_INSERTED, PUBLICATIEDATUMRIVM) 
INCLUDE (AANTAL_NIEUW_BESMETTE_VERPLEEGHUIS_LOCATIES, AANTAL_BESMETTE_VERPLEEGHUIS_LOCATIES)

CREATE NONCLUSTERED INDEX IX_INTER_FOUNDATION_NICE_IC_INTAKE_COUNT_DLI
ON VWSINTER.FOUNDATION_NICE_IC_INTAKE_COUNT (DATE_LAST_INSERTED) 
INCLUDE (DATE_OF_REPORT, VALUE)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY_MC_DP_MN_HA
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (MUNICIPALITY_CODE) 
INCLUDE (DATE_OF_PUBLICATION, MUNICIPALITY_NAME, HOSPITAL_ADMISSION)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY_MC_DP_MN_HA_DLI
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (MUNICIPALITY_CODE) 
INCLUDE (DATE_OF_PUBLICATION, MUNICIPALITY_NAME, HOSPITAL_ADMISSION, DATE_LAST_INSERTED)

CREATE NONCLUSTERED INDEX IX_INTER_RIVM_COVID_19_NUMBER_MUNICIPALITY_DLI_DP_MC_MN_HA
ON VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY (DATE_LAST_INSERTED) 
INCLUDE (DATE_OF_PUBLICATION, MUNICIPALITY_CODE, MUNICIPALITY_NAME, HOSPITAL_ADMISSION)

CREATE NONCLUSTERED INDEX IX_STAGE_GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION
ON VWSSTAGE.GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE_PER_REGION (DATE_LAST_INSERTED) 
INCLUDE ([WEEK OF APPOINTMENT], [SECURITY REGION NAME], [SECURITY REGION CODE], 
[POPULATION PER SECURITY REGION], [TOTAL TESTED WITH RESULT], [TOTAL TESTED WITH RESULT/100.000], 
[TOTAL POSITIVE], [% POSITIVE])

CREATE NONCLUSTERED INDEX IX_STAGE_FOUNDATION_NICE_IC_INTAKE_COUNT
ON VWSSTAGE.FOUNDATION_NICE_IC_INTAKE_COUNT (DATE_LAST_INSERTED) 
INCLUDE (DATE, VALUE)

CREATE NONCLUSTERED INDEX IX_DEST_HOSPITAL_ADMISSIONS_DOR
ON VWSDEST.HOSPITAL_ADMISSIONS (DATE_OF_REPORT) 
INCLUDE (DATE_OF_REPORT_UNIX, MOVING_AVERAGE_HOSPITAL, DATE_LAST_INSERTED);

CREATE NONCLUSTERED INDEX IX_DEST_HOSPITAL_ADMISSIONS_DLI_DOR
ON VWSDEST.HOSPITAL_ADMISSIONS (DATE_LAST_INSERTED, DATE_OF_REPORT) 
INCLUDE (DATE_OF_REPORT_UNIX, MOVING_AVERAGE_HOSPITAL);

CREATE NONCLUSTERED INDEX IX_DEST_HOSPITAL_ADMISSIONS_PER_MUNICIPALITY_DLI_DOR
ON VWSDEST.HOSPITAL_ADMISSIONS_PER_MUNICIPALITY (DATE_LAST_INSERTED, DATE_OF_REPORT) 
INCLUDE (DATE_OF_REPORT_UNIX, MUNICIPALITY_CODE, MUNICIPALITY_NAME, MOVING_AVERAGE_HOSPITAL);

CREATE NONCLUSTERED INDEX IX_DEST_POSITIVE_TESTED_PEOPLE_PER_MUNICIPALITY_DLI_DOR
ON VWSDEST.POSITIVE_TESTED_PEOPLE_PER_MUNICIPALITY (DATE_LAST_INSERTED, DATE_OF_REPORT) 
INCLUDE (DATE_OF_REPORT_UNIX, MUNICIPALITY_CODE, MUNICIPALITY_NAME, INFECTED_DAILY_TOTAL, INFECTED_DAILY_INCREASE);

CREATE NONCLUSTERED INDEX IX_DEST_SEWER_MEASUREMENTS_PER_MUNICIPALITY_DLI
ON VWSDEST.SEWER_MEASUREMENTS_PER_MUNICIPALITY (DATE_LAST_INSERTED) 
INCLUDE (WEEK, WEEK_UNIX, GMCODE, AVERAGE);

CREATE NONCLUSTERED INDEX IX_DEST_SEWER_MEASUREMENTS_PER_RWZI_DLI
ON VWSDEST.SEWER_MEASUREMENTS_PER_RWZI (DATE_LAST_INSERTED) 
INCLUDE (DATE_MEASUREMENT, DATE_MEASUREMENT_UNIX, WEEK, RWZI_AWZI_CODE, RWZI_AWZI_NAME, VRCODE, VRNAAM, RNA_PER_ML);