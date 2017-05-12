IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.7.0' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.8.0' )

  RETURN
/* 
Run this script on: 
 
        (local)\SQLEXPRESS.BitMobile_bitmobile3_airsystems    -  This database will be modified 
 
to synchronize it with: 
 
        PC093005.BitMobile_1_biovitrum 
 
You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.33.3389 from Red Gate Software Ltd at 16.01.2017 13:16:46 
 
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DELETE FROM [dbo].[ReportQuery]
GO
PRINT(N'Update 2 rows in [dbo].[ReportQuery]')
INSERT
INTO [dbo].[ReportQuery] ([Name], [Query])
VALUES ('RimPlanFact', N'Select Total.EventId,
Total.AmountFact,
Total.AmountFactSumMaterials,
Total.AmountFactSumServices,
Total.AmountPlan,
Total.AmountPlanSumMaterials,
Total.AmountPlanSumServices,
Total.ClientDesc AS ClientDescription,
Total.Date AS StartDatePlan,
Total.Importance AS ImportanceID,
Total.IsService,
Total.Number,
Total.Price,
Total.RIMDesc,
Total.SumFact,
Total.SumFactSumMaterials,
Total.SumFactSumServices,
Total.SumPlan,
Total.SumPlanSumMaterials,
Total.SumPlanSumServices,
Total.TypeDeparture AS TypeDepartureDescription,
Total.Unit,
Total.UserName
 From
(Select Distinct DocumentEvent.Id As ''EventIdRight'' 

From Document.Event AS DocumentEvent
	Inner Join Catalog.Client AS CatalogClient
	On CatalogClient.Id = DocumentEvent.Client
	Inner Join Document.Event_TypeDepartures AS DocumentEventTypeDepartures
		On DocumentEventTypeDepartures.Ref = DocumentEvent.Id 
		Inner Join Catalog.TypesDepartures As CatalogTypesDepartures
			On CatalogTypesDepartures.Id = DocumentEventTypeDepartures.TypeDeparture AND DocumentEventTypeDepartures.Active=1
			Inner Join Document.Event_ServicesMaterials As DocumentEventServicesMaterials
				On DocumentEventServicesMaterials.Ref = DocumentEvent.Id And DocumentEventServicesMaterials.IsDeleted = 0
				Inner Join Catalog.RIM As CatalogRIM
					On CatalogRIM.Id = DocumentEventServicesMaterials.SKU
					Inner Join Catalog.[User] As CatalogUser
						On CatalogUser.Id = DocumentEvent.UserMA
						Left JOIN Enum.StatusImportance As EnumStatusImportance
							On DocumentEvent.Importance = EnumStatusImportance.Id
	Where (
    ''@Search'' = ''null''
    OR CatalogClient.Description Like ''%@Search%'' 
    OR CatalogTypesDepartures.Description Like ''%@Search%'' 
    OR DocumentEvent.Number Like ''%@Search%'' 
    OR CatalogRIM.Description Like ''%@Search%'' 
    )
    AND(
    ''@ClientId'' = ''null''
    OR ''@ClientId'' = CatalogClient.Id
    )
    AND(
    ''@TypeDepartureID'' = ''null''
    OR ''@TypeDepartureID'' = CatalogTypesDepartures.Id
    )
    AND(
    ''@UserId'' = ''null''
    OR ''@UserId'' = CatalogUser.Id
    )
    AND(
    ''@StartDate'' = ''null''
    OR DATEADD(DAY, DATEDIFF(DAY, ''19000101'', ''@StartDate''), ''19000101'') <= DocumentEvent.StartDatePlan
    )
    AND(
    ''@EndDate'' = ''null''
    OR  DATEADD(DAY, DATEDIFF(DAY, ''18991231'', ''@EndDate''), ''19000101'') >= DocumentEvent.StartDatePlan
    )
	) As OnlyId
	Left Join
(
Select 
DocumentEvent.Id As ''EventId'',
DocumentEvent.StartDatePlan AS ''Date'',
CatalogClient.Description AS ''ClientDesc'',
DocumentEvent.Number AS ''Number'',
CatalogTypesDepartures.Description AS ''TypeDeparture'',
CatalogUser.UserName AS ''UserName'',
CatalogRIM.[Description] AS ''RIMDesc'',
CatalogRIM.Service AS ''IsService'',
CatalogRIM.Unit AS ''Unit'',
CatalogRIM.Price As ''Price'',
DocumentEventServicesMaterials.AmountPlan AS ''AmountPlan'',
DocumentEventServicesMaterials.AmountFact AS ''AmountFact'',
DocumentEventServicesMaterials.SumPlan AS ''SumPlan'',
DocumentEventServicesMaterials.SumFact AS ''SumFact'',
EnumStatusImportance.[Name] AS ''Importance'',
(Select Sum(DocumentEventServicesMaterialsGroup.AmountPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''AmountPlanSumServices'',
(Select Sum(DocumentEventServicesMaterialsGroup.AmountFact)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''AmountFactSumServices'',
  (Select Sum(DocumentEventServicesMaterialsGroup.SumPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''SumPlanSumServices'',
  (Select Sum(DocumentEventServicesMaterialsGroup.SumFact)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''SumFactSumServices'',
 (Select Sum(DocumentEventServicesMaterialsGroup.AmountPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 0
 ) As ''AmountPlanSumMaterials'',
(Select Sum(DocumentEventServicesMaterialsGroup.AmountFact)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 0
 ) As ''AmountFactSumMaterials'',
  (Select Sum(DocumentEventServicesMaterialsGroup.SumPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 0
 ) As ''SumPlanSumMaterials'',
  (Select Sum(DocumentEventServicesMaterialsGroup.SumFact)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 0
 ) As ''SumFactSumMaterials''


From Document.Event AS DocumentEvent
	Inner Join Catalog.Client AS CatalogClient
	On CatalogClient.Id = DocumentEvent.Client
	Inner Join Document.Event_TypeDepartures AS DocumentEventTypeDepartures
		On DocumentEventTypeDepartures.Ref = DocumentEvent.Id 
		Inner Join Catalog.TypesDepartures As CatalogTypesDepartures
			On CatalogTypesDepartures.Id = DocumentEventTypeDepartures.TypeDeparture AND DocumentEventTypeDepartures.Active=1
			Inner Join Document.Event_ServicesMaterials As DocumentEventServicesMaterials
				On DocumentEventServicesMaterials.Ref = DocumentEvent.Id And DocumentEventServicesMaterials.IsDeleted = 0
				Inner Join Catalog.RIM As CatalogRIM
					On CatalogRIM.Id = DocumentEventServicesMaterials.SKU
					Inner Join Catalog.[User] As CatalogUser
						On CatalogUser.Id = DocumentEvent.UserMA
						Left JOIN Enum.StatusImportance As EnumStatusImportance
							On DocumentEvent.Importance = EnumStatusImportance.Id
	
	) as Total
	On OnlyId.EventIdRight = Total.EventId

		Order By Total.Number
')
INSERT
INTO [dbo].[ReportQuery] ([Name], [Query])
VALUES ('Discipline', N'Select *,
Total.TimeSpendFact - Total.TimeSpendPlan As ''DiffSpendTime'',
Case 
When Total.MeterDiffGPsEnd Is Null then null
When Total.MeterDiffGPsEnd <= 300 Then ''dist_ok'' 
When Total.MeterDiffGPsEnd>300 And Total.MeterDiffGPsEnd <= 600 Then ''dist_half''
When Total.MeterDiffGPsEnd>600 Then ''dist_big''
End As ''IconStatusGpsEnd'',
Case 
When Total.MeterDiffGPsStart Is Null then null
When Total.MeterDiffGPsStart <= 300 Then ''dist_ok'' 
When Total.MeterDiffGPsStart>300 And Total.MeterDiffGPsStart <= 600 Then ''dist_half''
When Total.MeterDiffGPsStart>600 Then ''dist_big''
End As ''IconStatusGpsStart'',
Case 
When Total.TimeLate <= 5 AND Total.TimeLate >= -5 Then ''OK'' 
When Total.TimeLate > 5 AND Total.TimeLate <= 15 Then ''yellow_circle_15''
When Total.TimeLate < -5 AND Total.TimeLate >= -15 Then ''yellow_circle_45''
When Total.TimeLate < -15 Then ''red_circle_15''
When Total.TimeLate > 15 Then ''red_circle_45''
End As ''IconStatusTimeLate'',
Case 
When Total.TimeSpendFact - Total.TimeSpendPlan >=-15 And Total.TimeSpendFact - Total.TimeSpendPlan <= 15 then ''OK''
When Total.TimeSpendFact - Total.TimeSpendPlan > 15 And Total.TimeSpendFact - Total.TimeSpendPlan <= 30 then ''yellow_circle_15'' 
When Total.TimeSpendFact - Total.TimeSpendPlan < -15 And Total.TimeSpendFact - Total.TimeSpendPlan >= -30 then ''yellow_circle_45'' 
When Total.TimeSpendFact - Total.TimeSpendPlan < 30 then ''red_circle_15'' 
When Total.TimeSpendFact - Total.TimeSpendPlan > 30 then ''red_circle_45'' 
End As ''IconStatusDiffSpendTime'',
CONVERT(varchar(10), Total.TimeSpendFact) + ''/'' +CONVERT(varchar(10),  Total.TimeSpendPlan) As ''TimeSpentSub''
From (
Select 
DocumentEvent.Id As ''EventId'',
DocumentEvent.Date AS ''StartDatePlan'',
CatalogClient.Description AS ''ClientDescription'',
DocumentEvent.Number AS ''Number'',
CatalogTypesDepartures.Description AS ''TypeDepartureDescription'',
CatalogUser.UserName AS ''UserName'',
DATEDIFF ( MINUTE , DocumentEvent.StartDatePlan , DocumentEvent.ActualStartDate )  As ''TimeLate'',
DocumentEvent.StartDatePlan AS ''PlanTimeStart'',
DocumentEvent.ActualStartDate AS ''FactTimeStart'',
DATEDIFF ( MINUTE ,  DocumentEvent.ActualStartDate,DocumentEvent.ActualEndDate )  As ''TimeSpendFact'',
DATEDIFF ( MINUTE ,  DocumentEvent.StartDatePlan,DocumentEvent.EndDatePlan)  As ''TimeSpendPlan'',
Case 
	When  (CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL OR DocumentEvent.LatitudeStart IS NULL OR DocumentEvent.LongitudeStart IS NULL) OR (CatalogClient.Latitude = 0 AND CatalogClient.Longitude = 0) OR (DocumentEvent.LatitudeStart = 0 AND DocumentEvent.LongitudeStart = 0) Then
		null
	Else
		geography::Point(CatalogClient.Latitude,CatalogClient.Longitude, 4326).STDistance(geography::Point(DocumentEvent.LatitudeStart,DocumentEvent.LongitudeStart, 4326))
END as ''MeterDiffGPsStart'',

Case 
	When  (CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL OR DocumentEvent.LatitudeEnd IS NULL OR DocumentEvent.LongitudeEnd IS NULL) OR (CatalogClient.Latitude = 0 AND CatalogClient.Longitude = 0) OR (DocumentEvent.LatitudeEnd = 0 AND DocumentEvent.LongitudeEnd = 0) Then
		null
	Else 
		geography::Point(CatalogClient.Latitude,CatalogClient.Longitude, 4326).STDistance(geography::Point(DocumentEvent.LatitudeEnd,DocumentEvent.LongitudeEnd, 4326))  
END as ''MeterDiffGPsEnd'',
Case 
	When  (CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL) OR (CatalogClient.Latitude = 0 AND CatalogClient.Longitude = 0) Then
		0
	Else 
		1
END as ''IsClientCoordinates'',
Case 
	When  (DocumentEvent.LatitudeStart IS NULL OR DocumentEvent.LongitudeStart IS NULL) OR (DocumentEvent.LatitudeStart = 0 AND DocumentEvent.LongitudeStart = 0) Then
		0
	Else 
		1
END as ''IsEventStartCoordinates'',

Case 
	When  (DocumentEvent.LatitudeEnd IS NULL OR DocumentEvent.LongitudeEnd IS NULL) OR (DocumentEvent.LatitudeEnd = 0 AND DocumentEvent.LongitudeEnd = 0) Then
		0
	Else 
		1
END as ''IsEventEndCoordinates'',
EnumStatusImportance.[Name] AS ''Importance'' 
From Document.Event AS DocumentEvent
	Inner Join Catalog.Client AS CatalogClient
	On CatalogClient.Id = DocumentEvent.Client
	Inner Join Document.Event_TypeDepartures AS DocumentEventTypeDepartures
		On DocumentEventTypeDepartures.Ref = DocumentEvent.Id 
		Inner Join Catalog.TypesDepartures As CatalogTypesDepartures
			On CatalogTypesDepartures.Id = DocumentEventTypeDepartures.TypeDeparture AND DocumentEventTypeDepartures.Active=1
					Inner Join Catalog.[User] As CatalogUser
						On CatalogUser.Id = DocumentEvent.UserMA
						Inner Join Enum.StatusImportance AS EnumStatusImportance
							On EnumStatusImportance.Id = DocumentEvent.Importance
							Inner Join Enum.StatusyEvents As EnumStatusyEvents
								On EnumStatusyEvents.Id = DocumentEvent.Status And (EnumStatusyEvents.Name = ''Done'' 
									OR EnumStatusyEvents.Name = ''DoneWithTrouble''
									OR EnumStatusyEvents.Name = ''OnTheApprovalOf''
									OR EnumStatusyEvents.Name = ''Close''
									OR EnumStatusyEvents.Name = ''NotDone'')
	Where (
    ''@Search'' = ''null''
    OR CatalogClient.Description Like ''%@Search%'' 
    OR CatalogTypesDepartures.Description Like ''%@Search%'' 
    OR DocumentEvent.Number Like ''%@Search%'' 
    )
    AND(
    ''@ClientId'' = ''null''
    OR ''@ClientId'' = CatalogClient.Id
    )
    AND(
    ''@TypeDepartureID'' = ''null''
    OR ''@TypeDepartureID'' = CatalogTypesDepartures.Id
    )
    AND(
    ''@UserId'' = ''null''
    OR ''@UserId'' = CatalogUser.Id
    )
    AND(
    ''@StartDate'' = ''null''
    OR ''@StartDate'' <= DocumentEvent.Date
    )
    AND(
    ''@EndDate'' = ''null''
    OR ''@EndDate'' >= DocumentEvent.Date
    )

	) as Total
	Order By Total.Number')
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Updating checklist dates'
UPDATE Document.Event_CheckList
Set Result = 
CASE 
when TRY_PARSE(Result as datetime USING 'ru-ru') IS NULL
then Result
Else CONVERT(varchar(50), TRY_PARSE(Result as datetime USING 'ru-ru'), 127) + 'Z'
End
 WHERE ActionType = 'BE371BA8-80CB-B12E-4445-D9DBD848CD08'
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Set DBVersion = 3.1.8.0'
IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.8.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.8.0');
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO


DECLARE @Success AS BIT 
SET @Success = 1 
SET NOEXEC OFF 
IF (@Success = 1) PRINT 'The database update succeeded' 
ELSE BEGIN 
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION 
	PRINT 'The database update failed' 
END
GO
