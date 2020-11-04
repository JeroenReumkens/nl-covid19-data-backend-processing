-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

exec [dbo].[SafeInsertWorkflow] 'RIVM_COVID_19_NUMBER_MUNICIPALITY', 'Day', '12:17', 'N', 'true';
exec [dbo].[SafeInsertWorkflow] 'GGD_PERCENTAGE_POSITIVE_TESTED_PEOPLE', 'Week', '12:17', 'N', 'true';
exec [dbo].[SafeInsertWorkflow] 'VWS_CORONALEVEL_REGIONS', 'Week', '12:17', 'N', 'true';

GO