IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.6.0' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.7.0' )

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
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ADD 
[LatitudeEnd] [decimal] (12, 8) NULL, 
[LongitudeEnd] [decimal] (12, 8) NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[Document].[Event].[Latitude]', N'LatitudeStart', N'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[Document].[Event].[Longitude]', N'LongitudeStart', N'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_getchanges]'
GO
 
 
ALTER PROCEDURE [Document].[Event_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Document].[Event] E 
	JOIN [Document].[Event_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_Files] E 
	JOIN [Document].[Event_Files_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_Equipments] E 
	JOIN [Document].[Event_Equipments_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_Photos] E 
	JOIN [Document].[Event_Photos_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_Parameters] E 
	JOIN [Document].[Event_Parameters_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_CheckList] E 
	JOIN [Document].[Event_CheckList_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_TypeDepartures] E 
	JOIN [Document].[Event_TypeDepartures_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_ServicesMaterials] E 
	JOIN [Document].[Event_ServicesMaterials_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Event_EventFiskalProperties] E 
	JOIN [Document].[Event_EventFiskalProperties_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Document.Event' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]						,NULL AS [Files!11] 
						,NULL AS [Equipments!21] 
						,NULL AS [Photos!31] 
						,NULL AS [Parameters!41] 
						,NULL AS [CheckList!51] 
						,NULL AS [TypeDepartures!61] 
						,NULL AS [ServicesMaterials!71] 
						,NULL AS [EventFiskalProperties!81] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!FullFileName] 
					,NULL AS [Row!12!FileName] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Equipment] 
					,NULL AS [Row!22!Terget] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!SID] 
												,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!UIDPhoto] 
					,NULL AS [Row!32!Equipment] 
												,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
												,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!Action] 
					,NULL AS [Row!52!CheckListRef] 
					,NULL AS [Row!52!Result] 
					,NULL AS [Row!52!ActionType] 
					,NULL AS [Row!52!Required] 
												,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!TypeDeparture] 
					,NULL AS [Row!62!Active] 
												,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!SKU] 
					,NULL AS [Row!72!Price] 
					,NULL AS [Row!72!AmountPlan] 
					,NULL AS [Row!72!SumPlan] 
					,NULL AS [Row!72!AmountFact] 
					,NULL AS [Row!72!SumFact] 
												,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!CheckNumber] 
					,NULL AS [Row!82!Date] 
					,NULL AS [Row!82!ShiftNumber] 
					,NULL AS [Row!82!NumberFtpr] 
					,NULL AS [Row!82!PaymentType] 
					,NULL AS [Row!82!PaymentAmount] 
					,NULL AS [Row!82!User] 
			 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Posted] AS [Row!2!Posted],H.[DeletionMark] AS [Row!2!DeletionMark],H.[Date] AS [Row!2!Date],H.[Number] AS [Row!2!Number],H.[ApplicationJustification] AS [Row!2!ApplicationJustification],H.[Client] AS [Row!2!Client],H.[DivisionSource] AS [Row!2!DivisionSource],H.[KindEvent] AS [Row!2!KindEvent],H.[AnySale] AS [Row!2!AnySale],H.[AnyProblem] AS [Row!2!AnyProblem],H.[StartDatePlan] AS [Row!2!StartDatePlan],H.[EndDatePlan] AS [Row!2!EndDatePlan],H.[ActualStartDate] AS [Row!2!ActualStartDate],H.[ActualEndDate] AS [Row!2!ActualEndDate],H.[Author] AS [Row!2!Author],H.[UserMA] AS [Row!2!UserMA],H.[Comment] AS [Row!2!Comment],H.[DetailedDescription] AS [Row!2!DetailedDescription],H.[CommentContractor] AS [Row!2!CommentContractor],H.[TargInteractions] AS [Row!2!TargInteractions],H.[ResultInteractions] AS [Row!2!ResultInteractions],H.[Status] AS [Row!2!Status],H.[LatitudeStart] AS [Row!2!LatitudeStart],H.[LongitudeStart] AS [Row!2!LongitudeStart],H.[LatitudeEnd] AS [Row!2!LatitudeEnd],H.[LongitudeEnd] AS [Row!2!LongitudeEnd],H.[GPSTime] AS [Row!2!GPSTime],H.[ContactVisiting] AS [Row!2!ContactVisiting],H.[TypesDepartures] AS [Row!2!TypesDepartures],H.[Importance] AS [Row!2!Importance]						,NULL AS [Files!11] 
						,NULL AS [Equipments!21] 
						,NULL AS [Photos!31] 
						,NULL AS [Parameters!41] 
						,NULL AS [CheckList!51] 
						,NULL AS [TypeDepartures!61] 
						,NULL AS [ServicesMaterials!71] 
						,NULL AS [EventFiskalProperties!81] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!FullFileName] 
					,NULL AS [Row!12!FileName] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Equipment] 
					,NULL AS [Row!22!Terget] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!SID] 
												,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!UIDPhoto] 
					,NULL AS [Row!32!Equipment] 
												,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
												,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!Action] 
					,NULL AS [Row!52!CheckListRef] 
					,NULL AS [Row!52!Result] 
					,NULL AS [Row!52!ActionType] 
					,NULL AS [Row!52!Required] 
												,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!TypeDeparture] 
					,NULL AS [Row!62!Active] 
												,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!SKU] 
					,NULL AS [Row!72!Price] 
					,NULL AS [Row!72!AmountPlan] 
					,NULL AS [Row!72!SumPlan] 
					,NULL AS [Row!72!AmountFact] 
					,NULL AS [Row!72!SumFact] 
												,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!CheckNumber] 
					,NULL AS [Row!82!Date] 
					,NULL AS [Row!82!ShiftNumber] 
					,NULL AS [Row!82!NumberFtpr] 
					,NULL AS [Row!82!PaymentType] 
					,NULL AS [Row!82!PaymentAmount] 
					,NULL AS [Row!82!User] 
				FROM [Document].[Event] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
			 
	UNION ALL 
 
	SELECT 
	11 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!11] 
				,NULL AS [Equipments!11] 
				,NULL AS [Photos!11] 
				,NULL AS [Parameters!11] 
				,NULL AS [CheckList!11] 
				,NULL AS [TypeDepartures!11] 
				,NULL AS [ServicesMaterials!11] 
				,NULL AS [EventFiskalProperties!11] 
										,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!FullFileName] 
					,NULL AS [Row!12!FileName] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Equipment] 
					,NULL AS [Row!12!Terget] 
					,NULL AS [Row!12!Result] 
					,NULL AS [Row!12!Comment] 
					,NULL AS [Row!12!SID] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!UIDPhoto] 
					,NULL AS [Row!12!Equipment] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Parameter] 
					,NULL AS [Row!12!Val] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Action] 
					,NULL AS [Row!12!CheckListRef] 
					,NULL AS [Row!12!Result] 
					,NULL AS [Row!12!ActionType] 
					,NULL AS [Row!12!Required] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!TypeDeparture] 
					,NULL AS [Row!12!Active] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!SKU] 
					,NULL AS [Row!12!Price] 
					,NULL AS [Row!12!AmountPlan] 
					,NULL AS [Row!12!SumPlan] 
					,NULL AS [Row!12!AmountFact] 
					,NULL AS [Row!12!SumFact] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!CheckNumber] 
					,NULL AS [Row!12!Date] 
					,NULL AS [Row!12!ShiftNumber] 
					,NULL AS [Row!12!NumberFtpr] 
					,NULL AS [Row!12!PaymentType] 
					,NULL AS [Row!12!PaymentAmount] 
					,NULL AS [Row!12!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	12 AS Tag, 11 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!11] 
				,NULL AS [Equipments!11] 
				,NULL AS [Photos!11] 
				,NULL AS [Parameters!11] 
				,NULL AS [CheckList!11] 
				,NULL AS [TypeDepartures!11] 
				,NULL AS [ServicesMaterials!11] 
				,NULL AS [EventFiskalProperties!11] 
										 ,T.[Id] AS [Row!12!Id]								 ,T.[Ref] AS [Row!12!Ref]								 ,T.[LineNumber] AS [Row!12!LineNumber]								 ,T.[FullFileName] AS [Row!12!FullFileName]								 ,T.[FileName] AS [Row!12!FileName]															 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Equipment]								 ,NULL AS [Row!12!Terget]								 ,NULL AS [Row!12!Result]								 ,NULL AS [Row!12!Comment]								 ,NULL AS [Row!12!SID]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!UIDPhoto]								 ,NULL AS [Row!12!Equipment]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Parameter]								 ,NULL AS [Row!12!Val]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Action]								 ,NULL AS [Row!12!CheckListRef]								 ,NULL AS [Row!12!Result]								 ,NULL AS [Row!12!ActionType]								 ,NULL AS [Row!12!Required]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!TypeDeparture]								 ,NULL AS [Row!12!Active]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!SKU]								 ,NULL AS [Row!12!Price]								 ,NULL AS [Row!12!AmountPlan]								 ,NULL AS [Row!12!SumPlan]								 ,NULL AS [Row!12!AmountFact]								 ,NULL AS [Row!12!SumFact]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!CheckNumber]								 ,NULL AS [Row!12!Date]								 ,NULL AS [Row!12!ShiftNumber]								 ,NULL AS [Row!12!NumberFtpr]								 ,NULL AS [Row!12!PaymentType]								 ,NULL AS [Row!12!PaymentAmount]								 ,NULL AS [Row!12!User]				FROM @Ids Ids 
	JOIN [Document].[Event_Files] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	21 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!21] 
				,NULL AS [Equipments!21] 
				,NULL AS [Photos!21] 
				,NULL AS [Parameters!21] 
				,NULL AS [CheckList!21] 
				,NULL AS [TypeDepartures!21] 
				,NULL AS [ServicesMaterials!21] 
				,NULL AS [EventFiskalProperties!21] 
										,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!FullFileName] 
					,NULL AS [Row!22!FileName] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Equipment] 
					,NULL AS [Row!22!Terget] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!SID] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!UIDPhoto] 
					,NULL AS [Row!22!Equipment] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Parameter] 
					,NULL AS [Row!22!Val] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Action] 
					,NULL AS [Row!22!CheckListRef] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!ActionType] 
					,NULL AS [Row!22!Required] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!TypeDeparture] 
					,NULL AS [Row!22!Active] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!SKU] 
					,NULL AS [Row!22!Price] 
					,NULL AS [Row!22!AmountPlan] 
					,NULL AS [Row!22!SumPlan] 
					,NULL AS [Row!22!AmountFact] 
					,NULL AS [Row!22!SumFact] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!CheckNumber] 
					,NULL AS [Row!22!Date] 
					,NULL AS [Row!22!ShiftNumber] 
					,NULL AS [Row!22!NumberFtpr] 
					,NULL AS [Row!22!PaymentType] 
					,NULL AS [Row!22!PaymentAmount] 
					,NULL AS [Row!22!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	22 AS Tag, 21 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!21] 
				,NULL AS [Equipments!21] 
				,NULL AS [Photos!21] 
				,NULL AS [Parameters!21] 
				,NULL AS [CheckList!21] 
				,NULL AS [TypeDepartures!21] 
				,NULL AS [ServicesMaterials!21] 
				,NULL AS [EventFiskalProperties!21] 
													 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!FullFileName]								 ,NULL AS [Row!22!FileName]									 ,T.[Id] AS [Row!22!Id]								 ,T.[Ref] AS [Row!22!Ref]								 ,T.[LineNumber] AS [Row!22!LineNumber]								 ,T.[Equipment] AS [Row!22!Equipment]								 ,T.[Terget] AS [Row!22!Terget]								 ,T.[Result] AS [Row!22!Result]								 ,T.[Comment] AS [Row!22!Comment]								 ,T.[SID] AS [Row!22!SID]															 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!UIDPhoto]								 ,NULL AS [Row!22!Equipment]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Parameter]								 ,NULL AS [Row!22!Val]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Action]								 ,NULL AS [Row!22!CheckListRef]								 ,NULL AS [Row!22!Result]								 ,NULL AS [Row!22!ActionType]								 ,NULL AS [Row!22!Required]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!TypeDeparture]								 ,NULL AS [Row!22!Active]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!SKU]								 ,NULL AS [Row!22!Price]								 ,NULL AS [Row!22!AmountPlan]								 ,NULL AS [Row!22!SumPlan]								 ,NULL AS [Row!22!AmountFact]								 ,NULL AS [Row!22!SumFact]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!CheckNumber]								 ,NULL AS [Row!22!Date]								 ,NULL AS [Row!22!ShiftNumber]								 ,NULL AS [Row!22!NumberFtpr]								 ,NULL AS [Row!22!PaymentType]								 ,NULL AS [Row!22!PaymentAmount]								 ,NULL AS [Row!22!User]				FROM @Ids Ids 
	JOIN [Document].[Event_Equipments] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	31 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!31] 
				,NULL AS [Equipments!31] 
				,NULL AS [Photos!31] 
				,NULL AS [Parameters!31] 
				,NULL AS [CheckList!31] 
				,NULL AS [TypeDepartures!31] 
				,NULL AS [ServicesMaterials!31] 
				,NULL AS [EventFiskalProperties!31] 
										,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!FullFileName] 
					,NULL AS [Row!32!FileName] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Equipment] 
					,NULL AS [Row!32!Terget] 
					,NULL AS [Row!32!Result] 
					,NULL AS [Row!32!Comment] 
					,NULL AS [Row!32!SID] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!UIDPhoto] 
					,NULL AS [Row!32!Equipment] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Parameter] 
					,NULL AS [Row!32!Val] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Action] 
					,NULL AS [Row!32!CheckListRef] 
					,NULL AS [Row!32!Result] 
					,NULL AS [Row!32!ActionType] 
					,NULL AS [Row!32!Required] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!TypeDeparture] 
					,NULL AS [Row!32!Active] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!SKU] 
					,NULL AS [Row!32!Price] 
					,NULL AS [Row!32!AmountPlan] 
					,NULL AS [Row!32!SumPlan] 
					,NULL AS [Row!32!AmountFact] 
					,NULL AS [Row!32!SumFact] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!CheckNumber] 
					,NULL AS [Row!32!Date] 
					,NULL AS [Row!32!ShiftNumber] 
					,NULL AS [Row!32!NumberFtpr] 
					,NULL AS [Row!32!PaymentType] 
					,NULL AS [Row!32!PaymentAmount] 
					,NULL AS [Row!32!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	32 AS Tag, 31 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!31] 
				,NULL AS [Equipments!31] 
				,NULL AS [Photos!31] 
				,NULL AS [Parameters!31] 
				,NULL AS [CheckList!31] 
				,NULL AS [TypeDepartures!31] 
				,NULL AS [ServicesMaterials!31] 
				,NULL AS [EventFiskalProperties!31] 
													 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!FullFileName]								 ,NULL AS [Row!32!FileName]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Equipment]								 ,NULL AS [Row!32!Terget]								 ,NULL AS [Row!32!Result]								 ,NULL AS [Row!32!Comment]								 ,NULL AS [Row!32!SID]									 ,T.[Id] AS [Row!32!Id]								 ,T.[Ref] AS [Row!32!Ref]								 ,T.[LineNumber] AS [Row!32!LineNumber]								 ,T.[UIDPhoto] AS [Row!32!UIDPhoto]								 ,T.[Equipment] AS [Row!32!Equipment]															 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Parameter]								 ,NULL AS [Row!32!Val]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Action]								 ,NULL AS [Row!32!CheckListRef]								 ,NULL AS [Row!32!Result]								 ,NULL AS [Row!32!ActionType]								 ,NULL AS [Row!32!Required]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!TypeDeparture]								 ,NULL AS [Row!32!Active]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!SKU]								 ,NULL AS [Row!32!Price]								 ,NULL AS [Row!32!AmountPlan]								 ,NULL AS [Row!32!SumPlan]								 ,NULL AS [Row!32!AmountFact]								 ,NULL AS [Row!32!SumFact]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!CheckNumber]								 ,NULL AS [Row!32!Date]								 ,NULL AS [Row!32!ShiftNumber]								 ,NULL AS [Row!32!NumberFtpr]								 ,NULL AS [Row!32!PaymentType]								 ,NULL AS [Row!32!PaymentAmount]								 ,NULL AS [Row!32!User]				FROM @Ids Ids 
	JOIN [Document].[Event_Photos] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	41 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!41] 
				,NULL AS [Equipments!41] 
				,NULL AS [Photos!41] 
				,NULL AS [Parameters!41] 
				,NULL AS [CheckList!41] 
				,NULL AS [TypeDepartures!41] 
				,NULL AS [ServicesMaterials!41] 
				,NULL AS [EventFiskalProperties!41] 
										,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!FullFileName] 
					,NULL AS [Row!42!FileName] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Equipment] 
					,NULL AS [Row!42!Terget] 
					,NULL AS [Row!42!Result] 
					,NULL AS [Row!42!Comment] 
					,NULL AS [Row!42!SID] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!UIDPhoto] 
					,NULL AS [Row!42!Equipment] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Action] 
					,NULL AS [Row!42!CheckListRef] 
					,NULL AS [Row!42!Result] 
					,NULL AS [Row!42!ActionType] 
					,NULL AS [Row!42!Required] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!TypeDeparture] 
					,NULL AS [Row!42!Active] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!SKU] 
					,NULL AS [Row!42!Price] 
					,NULL AS [Row!42!AmountPlan] 
					,NULL AS [Row!42!SumPlan] 
					,NULL AS [Row!42!AmountFact] 
					,NULL AS [Row!42!SumFact] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!CheckNumber] 
					,NULL AS [Row!42!Date] 
					,NULL AS [Row!42!ShiftNumber] 
					,NULL AS [Row!42!NumberFtpr] 
					,NULL AS [Row!42!PaymentType] 
					,NULL AS [Row!42!PaymentAmount] 
					,NULL AS [Row!42!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	42 AS Tag, 41 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!41] 
				,NULL AS [Equipments!41] 
				,NULL AS [Photos!41] 
				,NULL AS [Parameters!41] 
				,NULL AS [CheckList!41] 
				,NULL AS [TypeDepartures!41] 
				,NULL AS [ServicesMaterials!41] 
				,NULL AS [EventFiskalProperties!41] 
													 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!FullFileName]								 ,NULL AS [Row!42!FileName]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!Equipment]								 ,NULL AS [Row!42!Terget]								 ,NULL AS [Row!42!Result]								 ,NULL AS [Row!42!Comment]								 ,NULL AS [Row!42!SID]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!UIDPhoto]								 ,NULL AS [Row!42!Equipment]									 ,T.[Id] AS [Row!42!Id]								 ,T.[Ref] AS [Row!42!Ref]								 ,T.[LineNumber] AS [Row!42!LineNumber]								 ,T.[Parameter] AS [Row!42!Parameter]								 ,T.[Val] AS [Row!42!Val]															 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!Action]								 ,NULL AS [Row!42!CheckListRef]								 ,NULL AS [Row!42!Result]								 ,NULL AS [Row!42!ActionType]								 ,NULL AS [Row!42!Required]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!TypeDeparture]								 ,NULL AS [Row!42!Active]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!SKU]								 ,NULL AS [Row!42!Price]								 ,NULL AS [Row!42!AmountPlan]								 ,NULL AS [Row!42!SumPlan]								 ,NULL AS [Row!42!AmountFact]								 ,NULL AS [Row!42!SumFact]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!CheckNumber]								 ,NULL AS [Row!42!Date]								 ,NULL AS [Row!42!ShiftNumber]								 ,NULL AS [Row!42!NumberFtpr]								 ,NULL AS [Row!42!PaymentType]								 ,NULL AS [Row!42!PaymentAmount]								 ,NULL AS [Row!42!User]				FROM @Ids Ids 
	JOIN [Document].[Event_Parameters] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	51 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!51] 
				,NULL AS [Equipments!51] 
				,NULL AS [Photos!51] 
				,NULL AS [Parameters!51] 
				,NULL AS [CheckList!51] 
				,NULL AS [TypeDepartures!51] 
				,NULL AS [ServicesMaterials!51] 
				,NULL AS [EventFiskalProperties!51] 
										,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!FullFileName] 
					,NULL AS [Row!52!FileName] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!Equipment] 
					,NULL AS [Row!52!Terget] 
					,NULL AS [Row!52!Result] 
					,NULL AS [Row!52!Comment] 
					,NULL AS [Row!52!SID] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!UIDPhoto] 
					,NULL AS [Row!52!Equipment] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!Parameter] 
					,NULL AS [Row!52!Val] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!Action] 
					,NULL AS [Row!52!CheckListRef] 
					,NULL AS [Row!52!Result] 
					,NULL AS [Row!52!ActionType] 
					,NULL AS [Row!52!Required] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!TypeDeparture] 
					,NULL AS [Row!52!Active] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!SKU] 
					,NULL AS [Row!52!Price] 
					,NULL AS [Row!52!AmountPlan] 
					,NULL AS [Row!52!SumPlan] 
					,NULL AS [Row!52!AmountFact] 
					,NULL AS [Row!52!SumFact] 
									,NULL AS [Row!52!Id] 
					,NULL AS [Row!52!Ref] 
					,NULL AS [Row!52!LineNumber] 
					,NULL AS [Row!52!CheckNumber] 
					,NULL AS [Row!52!Date] 
					,NULL AS [Row!52!ShiftNumber] 
					,NULL AS [Row!52!NumberFtpr] 
					,NULL AS [Row!52!PaymentType] 
					,NULL AS [Row!52!PaymentAmount] 
					,NULL AS [Row!52!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	52 AS Tag, 51 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!51] 
				,NULL AS [Equipments!51] 
				,NULL AS [Photos!51] 
				,NULL AS [Parameters!51] 
				,NULL AS [CheckList!51] 
				,NULL AS [TypeDepartures!51] 
				,NULL AS [ServicesMaterials!51] 
				,NULL AS [EventFiskalProperties!51] 
													 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!FullFileName]								 ,NULL AS [Row!52!FileName]												 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!Equipment]								 ,NULL AS [Row!52!Terget]								 ,NULL AS [Row!52!Result]								 ,NULL AS [Row!52!Comment]								 ,NULL AS [Row!52!SID]												 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!UIDPhoto]								 ,NULL AS [Row!52!Equipment]												 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!Parameter]								 ,NULL AS [Row!52!Val]									 ,T.[Id] AS [Row!52!Id]								 ,T.[Ref] AS [Row!52!Ref]								 ,T.[LineNumber] AS [Row!52!LineNumber]								 ,T.[Action] AS [Row!52!Action]								 ,T.[CheckListRef] AS [Row!52!CheckListRef]								 ,T.[Result] AS [Row!52!Result]								 ,T.[ActionType] AS [Row!52!ActionType]								 ,T.[Required] AS [Row!52!Required]															 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!TypeDeparture]								 ,NULL AS [Row!52!Active]												 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!SKU]								 ,NULL AS [Row!52!Price]								 ,NULL AS [Row!52!AmountPlan]								 ,NULL AS [Row!52!SumPlan]								 ,NULL AS [Row!52!AmountFact]								 ,NULL AS [Row!52!SumFact]												 ,NULL AS [Row!52!Id]								 ,NULL AS [Row!52!Ref]								 ,NULL AS [Row!52!LineNumber]								 ,NULL AS [Row!52!CheckNumber]								 ,NULL AS [Row!52!Date]								 ,NULL AS [Row!52!ShiftNumber]								 ,NULL AS [Row!52!NumberFtpr]								 ,NULL AS [Row!52!PaymentType]								 ,NULL AS [Row!52!PaymentAmount]								 ,NULL AS [Row!52!User]				FROM @Ids Ids 
	JOIN [Document].[Event_CheckList] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	61 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!61] 
				,NULL AS [Equipments!61] 
				,NULL AS [Photos!61] 
				,NULL AS [Parameters!61] 
				,NULL AS [CheckList!61] 
				,NULL AS [TypeDepartures!61] 
				,NULL AS [ServicesMaterials!61] 
				,NULL AS [EventFiskalProperties!61] 
										,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!FullFileName] 
					,NULL AS [Row!62!FileName] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!Equipment] 
					,NULL AS [Row!62!Terget] 
					,NULL AS [Row!62!Result] 
					,NULL AS [Row!62!Comment] 
					,NULL AS [Row!62!SID] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!UIDPhoto] 
					,NULL AS [Row!62!Equipment] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!Parameter] 
					,NULL AS [Row!62!Val] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!Action] 
					,NULL AS [Row!62!CheckListRef] 
					,NULL AS [Row!62!Result] 
					,NULL AS [Row!62!ActionType] 
					,NULL AS [Row!62!Required] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!TypeDeparture] 
					,NULL AS [Row!62!Active] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!SKU] 
					,NULL AS [Row!62!Price] 
					,NULL AS [Row!62!AmountPlan] 
					,NULL AS [Row!62!SumPlan] 
					,NULL AS [Row!62!AmountFact] 
					,NULL AS [Row!62!SumFact] 
									,NULL AS [Row!62!Id] 
					,NULL AS [Row!62!Ref] 
					,NULL AS [Row!62!LineNumber] 
					,NULL AS [Row!62!CheckNumber] 
					,NULL AS [Row!62!Date] 
					,NULL AS [Row!62!ShiftNumber] 
					,NULL AS [Row!62!NumberFtpr] 
					,NULL AS [Row!62!PaymentType] 
					,NULL AS [Row!62!PaymentAmount] 
					,NULL AS [Row!62!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	62 AS Tag, 61 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!61] 
				,NULL AS [Equipments!61] 
				,NULL AS [Photos!61] 
				,NULL AS [Parameters!61] 
				,NULL AS [CheckList!61] 
				,NULL AS [TypeDepartures!61] 
				,NULL AS [ServicesMaterials!61] 
				,NULL AS [EventFiskalProperties!61] 
													 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!FullFileName]								 ,NULL AS [Row!62!FileName]												 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!Equipment]								 ,NULL AS [Row!62!Terget]								 ,NULL AS [Row!62!Result]								 ,NULL AS [Row!62!Comment]								 ,NULL AS [Row!62!SID]												 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!UIDPhoto]								 ,NULL AS [Row!62!Equipment]												 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!Parameter]								 ,NULL AS [Row!62!Val]												 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!Action]								 ,NULL AS [Row!62!CheckListRef]								 ,NULL AS [Row!62!Result]								 ,NULL AS [Row!62!ActionType]								 ,NULL AS [Row!62!Required]									 ,T.[Id] AS [Row!62!Id]								 ,T.[Ref] AS [Row!62!Ref]								 ,T.[LineNumber] AS [Row!62!LineNumber]								 ,T.[TypeDeparture] AS [Row!62!TypeDeparture]								 ,T.[Active] AS [Row!62!Active]															 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!SKU]								 ,NULL AS [Row!62!Price]								 ,NULL AS [Row!62!AmountPlan]								 ,NULL AS [Row!62!SumPlan]								 ,NULL AS [Row!62!AmountFact]								 ,NULL AS [Row!62!SumFact]												 ,NULL AS [Row!62!Id]								 ,NULL AS [Row!62!Ref]								 ,NULL AS [Row!62!LineNumber]								 ,NULL AS [Row!62!CheckNumber]								 ,NULL AS [Row!62!Date]								 ,NULL AS [Row!62!ShiftNumber]								 ,NULL AS [Row!62!NumberFtpr]								 ,NULL AS [Row!62!PaymentType]								 ,NULL AS [Row!62!PaymentAmount]								 ,NULL AS [Row!62!User]				FROM @Ids Ids 
	JOIN [Document].[Event_TypeDepartures] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	71 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!71] 
				,NULL AS [Equipments!71] 
				,NULL AS [Photos!71] 
				,NULL AS [Parameters!71] 
				,NULL AS [CheckList!71] 
				,NULL AS [TypeDepartures!71] 
				,NULL AS [ServicesMaterials!71] 
				,NULL AS [EventFiskalProperties!71] 
										,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!FullFileName] 
					,NULL AS [Row!72!FileName] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!Equipment] 
					,NULL AS [Row!72!Terget] 
					,NULL AS [Row!72!Result] 
					,NULL AS [Row!72!Comment] 
					,NULL AS [Row!72!SID] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!UIDPhoto] 
					,NULL AS [Row!72!Equipment] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!Parameter] 
					,NULL AS [Row!72!Val] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!Action] 
					,NULL AS [Row!72!CheckListRef] 
					,NULL AS [Row!72!Result] 
					,NULL AS [Row!72!ActionType] 
					,NULL AS [Row!72!Required] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!TypeDeparture] 
					,NULL AS [Row!72!Active] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!SKU] 
					,NULL AS [Row!72!Price] 
					,NULL AS [Row!72!AmountPlan] 
					,NULL AS [Row!72!SumPlan] 
					,NULL AS [Row!72!AmountFact] 
					,NULL AS [Row!72!SumFact] 
									,NULL AS [Row!72!Id] 
					,NULL AS [Row!72!Ref] 
					,NULL AS [Row!72!LineNumber] 
					,NULL AS [Row!72!CheckNumber] 
					,NULL AS [Row!72!Date] 
					,NULL AS [Row!72!ShiftNumber] 
					,NULL AS [Row!72!NumberFtpr] 
					,NULL AS [Row!72!PaymentType] 
					,NULL AS [Row!72!PaymentAmount] 
					,NULL AS [Row!72!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	72 AS Tag, 71 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!71] 
				,NULL AS [Equipments!71] 
				,NULL AS [Photos!71] 
				,NULL AS [Parameters!71] 
				,NULL AS [CheckList!71] 
				,NULL AS [TypeDepartures!71] 
				,NULL AS [ServicesMaterials!71] 
				,NULL AS [EventFiskalProperties!71] 
													 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!FullFileName]								 ,NULL AS [Row!72!FileName]												 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!Equipment]								 ,NULL AS [Row!72!Terget]								 ,NULL AS [Row!72!Result]								 ,NULL AS [Row!72!Comment]								 ,NULL AS [Row!72!SID]												 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!UIDPhoto]								 ,NULL AS [Row!72!Equipment]												 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!Parameter]								 ,NULL AS [Row!72!Val]												 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!Action]								 ,NULL AS [Row!72!CheckListRef]								 ,NULL AS [Row!72!Result]								 ,NULL AS [Row!72!ActionType]								 ,NULL AS [Row!72!Required]												 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!TypeDeparture]								 ,NULL AS [Row!72!Active]									 ,T.[Id] AS [Row!72!Id]								 ,T.[Ref] AS [Row!72!Ref]								 ,T.[LineNumber] AS [Row!72!LineNumber]								 ,T.[SKU] AS [Row!72!SKU]								 ,T.[Price] AS [Row!72!Price]								 ,T.[AmountPlan] AS [Row!72!AmountPlan]								 ,T.[SumPlan] AS [Row!72!SumPlan]								 ,T.[AmountFact] AS [Row!72!AmountFact]								 ,T.[SumFact] AS [Row!72!SumFact]															 ,NULL AS [Row!72!Id]								 ,NULL AS [Row!72!Ref]								 ,NULL AS [Row!72!LineNumber]								 ,NULL AS [Row!72!CheckNumber]								 ,NULL AS [Row!72!Date]								 ,NULL AS [Row!72!ShiftNumber]								 ,NULL AS [Row!72!NumberFtpr]								 ,NULL AS [Row!72!PaymentType]								 ,NULL AS [Row!72!PaymentAmount]								 ,NULL AS [Row!72!User]				FROM @Ids Ids 
	JOIN [Document].[Event_ServicesMaterials] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	81 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!81] 
				,NULL AS [Equipments!81] 
				,NULL AS [Photos!81] 
				,NULL AS [Parameters!81] 
				,NULL AS [CheckList!81] 
				,NULL AS [TypeDepartures!81] 
				,NULL AS [ServicesMaterials!81] 
				,NULL AS [EventFiskalProperties!81] 
										,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!FullFileName] 
					,NULL AS [Row!82!FileName] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!Equipment] 
					,NULL AS [Row!82!Terget] 
					,NULL AS [Row!82!Result] 
					,NULL AS [Row!82!Comment] 
					,NULL AS [Row!82!SID] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!UIDPhoto] 
					,NULL AS [Row!82!Equipment] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!Parameter] 
					,NULL AS [Row!82!Val] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!Action] 
					,NULL AS [Row!82!CheckListRef] 
					,NULL AS [Row!82!Result] 
					,NULL AS [Row!82!ActionType] 
					,NULL AS [Row!82!Required] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!TypeDeparture] 
					,NULL AS [Row!82!Active] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!SKU] 
					,NULL AS [Row!82!Price] 
					,NULL AS [Row!82!AmountPlan] 
					,NULL AS [Row!82!SumPlan] 
					,NULL AS [Row!82!AmountFact] 
					,NULL AS [Row!82!SumFact] 
									,NULL AS [Row!82!Id] 
					,NULL AS [Row!82!Ref] 
					,NULL AS [Row!82!LineNumber] 
					,NULL AS [Row!82!CheckNumber] 
					,NULL AS [Row!82!Date] 
					,NULL AS [Row!82!ShiftNumber] 
					,NULL AS [Row!82!NumberFtpr] 
					,NULL AS [Row!82!PaymentType] 
					,NULL AS [Row!82!PaymentAmount] 
					,NULL AS [Row!82!User] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	82 AS Tag, 81 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!LatitudeStart],NULL AS [Row!2!LongitudeStart],NULL AS [Row!2!LatitudeEnd],NULL AS [Row!2!LongitudeEnd],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!81] 
				,NULL AS [Equipments!81] 
				,NULL AS [Photos!81] 
				,NULL AS [Parameters!81] 
				,NULL AS [CheckList!81] 
				,NULL AS [TypeDepartures!81] 
				,NULL AS [ServicesMaterials!81] 
				,NULL AS [EventFiskalProperties!81] 
													 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!FullFileName]								 ,NULL AS [Row!82!FileName]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!Equipment]								 ,NULL AS [Row!82!Terget]								 ,NULL AS [Row!82!Result]								 ,NULL AS [Row!82!Comment]								 ,NULL AS [Row!82!SID]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!UIDPhoto]								 ,NULL AS [Row!82!Equipment]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!Parameter]								 ,NULL AS [Row!82!Val]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!Action]								 ,NULL AS [Row!82!CheckListRef]								 ,NULL AS [Row!82!Result]								 ,NULL AS [Row!82!ActionType]								 ,NULL AS [Row!82!Required]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!TypeDeparture]								 ,NULL AS [Row!82!Active]												 ,NULL AS [Row!82!Id]								 ,NULL AS [Row!82!Ref]								 ,NULL AS [Row!82!LineNumber]								 ,NULL AS [Row!82!SKU]								 ,NULL AS [Row!82!Price]								 ,NULL AS [Row!82!AmountPlan]								 ,NULL AS [Row!82!SumPlan]								 ,NULL AS [Row!82!AmountFact]								 ,NULL AS [Row!82!SumFact]									 ,T.[Id] AS [Row!82!Id]								 ,T.[Ref] AS [Row!82!Ref]								 ,T.[LineNumber] AS [Row!82!LineNumber]								 ,T.[CheckNumber] AS [Row!82!CheckNumber]								 ,T.[Date] AS [Row!82!Date]								 ,T.[ShiftNumber] AS [Row!82!ShiftNumber]								 ,T.[NumberFtpr] AS [Row!82!NumberFtpr]								 ,T.[PaymentType] AS [Row!82!PaymentType]								 ,T.[PaymentAmount] AS [Row!82!PaymentAmount]								 ,T.[User] AS [Row!82!User]							FROM @Ids Ids 
	JOIN [Document].[Event_EventFiskalProperties] T ON T.Ref = Ids.Id 
 
	 
	ORDER BY [Row!2!Id], Tag ,[Row!12!LineNumber],[Row!22!LineNumber],[Row!32!LineNumber],[Row!42!LineNumber],[Row!52!LineNumber],[Row!62!LineNumber],[Row!72!LineNumber],[Row!82!LineNumber] 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Document].[Event_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@LatitudeStart DECIMAL(12,8),		@LongitudeStart DECIMAL(12,8),		@LatitudeEnd DECIMAL(12,8),		@LongitudeEnd DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[ApplicationJustification],				[Client],				[DivisionSource],				[KindEvent],				[AnySale],				[AnyProblem],				[StartDatePlan],				[EndDatePlan],				[ActualStartDate],				[ActualEndDate],				[Author],				[UserMA],				[Comment],				[DetailedDescription],				[CommentContractor],				[TargInteractions],				[ResultInteractions],				[Status],				[LatitudeStart],				[LongitudeStart],				[LatitudeEnd],				[LongitudeEnd],				[GPSTime],				[ContactVisiting],				[TypesDepartures],				[Importance]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@ApplicationJustification,				@Client,				@DivisionSource,				@KindEvent,				@AnySale,				@AnyProblem,				@StartDatePlan,				@EndDatePlan,				@ActualStartDate,				@ActualEndDate,				@Author,				@UserMA,				@Comment,				@DetailedDescription,				@CommentContractor,				@TargInteractions,				@ResultInteractions,				@Status,				@LatitudeStart,				@LongitudeStart,				@LatitudeEnd,				@LongitudeEnd,				@GPSTime,				@ContactVisiting,				@TypesDepartures,				@Importance			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_update]'
GO
 
ALTER PROCEDURE [Document].[Event_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@LatitudeStart DECIMAL(12,8),		@LongitudeStart DECIMAL(12,8),		@LatitudeEnd DECIMAL(12,8),		@LongitudeEnd DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[ApplicationJustification] = @ApplicationJustification,				[Client] = @Client,				[DivisionSource] = @DivisionSource,				[KindEvent] = @KindEvent,				[AnySale] = @AnySale,				[AnyProblem] = @AnyProblem,				[StartDatePlan] = @StartDatePlan,				[EndDatePlan] = @EndDatePlan,				[ActualStartDate] = @ActualStartDate,				[ActualEndDate] = @ActualEndDate,				[Author] = @Author,				[UserMA] = @UserMA,				[Comment] = @Comment,				[DetailedDescription] = @DetailedDescription,				[CommentContractor] = @CommentContractor,				[TargInteractions] = @TargInteractions,				[ResultInteractions] = @ResultInteractions,				[Status] = @Status,				[LatitudeStart] = @LatitudeStart,				[LongitudeStart] = @LongitudeStart,				[LatitudeEnd] = @LatitudeEnd,				[LongitudeEnd] = @LongitudeEnd,				[GPSTime] = @GPSTime,				[ContactVisiting] = @ContactVisiting,				[TypesDepartures] = @TypesDepartures,				[Importance] = @Importance			WHERE Id = @Id AND 
	( 1=0 OR [Posted] <> @Posted OR ([Posted] IS NULL AND NOT @Posted IS NULL) OR (NOT [Posted] IS NULL AND @Posted IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Date] <> @Date OR ([Date] IS NULL AND NOT @Date IS NULL) OR (NOT [Date] IS NULL AND @Date IS NULL)  OR [Number] <> @Number OR ([Number] IS NULL AND NOT @Number IS NULL) OR (NOT [Number] IS NULL AND @Number IS NULL)  OR [ApplicationJustification] <> @ApplicationJustification OR ([ApplicationJustification] IS NULL AND NOT @ApplicationJustification IS NULL) OR (NOT [ApplicationJustification] IS NULL AND @ApplicationJustification IS NULL)  OR [Client] <> @Client OR ([Client] IS NULL AND NOT @Client IS NULL) OR (NOT [Client] IS NULL AND @Client IS NULL)  OR [DivisionSource] <> @DivisionSource OR ([DivisionSource] IS NULL AND NOT @DivisionSource IS NULL) OR (NOT [DivisionSource] IS NULL AND @DivisionSource IS NULL)  OR [KindEvent] <> @KindEvent OR ([KindEvent] IS NULL AND NOT @KindEvent IS NULL) OR (NOT [KindEvent] IS NULL AND @KindEvent IS NULL)  OR [AnySale] <> @AnySale OR ([AnySale] IS NULL AND NOT @AnySale IS NULL) OR (NOT [AnySale] IS NULL AND @AnySale IS NULL)  OR [AnyProblem] <> @AnyProblem OR ([AnyProblem] IS NULL AND NOT @AnyProblem IS NULL) OR (NOT [AnyProblem] IS NULL AND @AnyProblem IS NULL)  OR [StartDatePlan] <> @StartDatePlan OR ([StartDatePlan] IS NULL AND NOT @StartDatePlan IS NULL) OR (NOT [StartDatePlan] IS NULL AND @StartDatePlan IS NULL)  OR [EndDatePlan] <> @EndDatePlan OR ([EndDatePlan] IS NULL AND NOT @EndDatePlan IS NULL) OR (NOT [EndDatePlan] IS NULL AND @EndDatePlan IS NULL)  OR [ActualStartDate] <> @ActualStartDate OR ([ActualStartDate] IS NULL AND NOT @ActualStartDate IS NULL) OR (NOT [ActualStartDate] IS NULL AND @ActualStartDate IS NULL)  OR [ActualEndDate] <> @ActualEndDate OR ([ActualEndDate] IS NULL AND NOT @ActualEndDate IS NULL) OR (NOT [ActualEndDate] IS NULL AND @ActualEndDate IS NULL)  OR [Author] <> @Author OR ([Author] IS NULL AND NOT @Author IS NULL) OR (NOT [Author] IS NULL AND @Author IS NULL)  OR [UserMA] <> @UserMA OR ([UserMA] IS NULL AND NOT @UserMA IS NULL) OR (NOT [UserMA] IS NULL AND @UserMA IS NULL)  OR [Comment] <> @Comment OR ([Comment] IS NULL AND NOT @Comment IS NULL) OR (NOT [Comment] IS NULL AND @Comment IS NULL)  OR [DetailedDescription] <> @DetailedDescription OR ([DetailedDescription] IS NULL AND NOT @DetailedDescription IS NULL) OR (NOT [DetailedDescription] IS NULL AND @DetailedDescription IS NULL)  OR [CommentContractor] <> @CommentContractor OR ([CommentContractor] IS NULL AND NOT @CommentContractor IS NULL) OR (NOT [CommentContractor] IS NULL AND @CommentContractor IS NULL)  OR [TargInteractions] <> @TargInteractions OR ([TargInteractions] IS NULL AND NOT @TargInteractions IS NULL) OR (NOT [TargInteractions] IS NULL AND @TargInteractions IS NULL)  OR [ResultInteractions] <> @ResultInteractions OR ([ResultInteractions] IS NULL AND NOT @ResultInteractions IS NULL) OR (NOT [ResultInteractions] IS NULL AND @ResultInteractions IS NULL)  OR [Status] <> @Status OR ([Status] IS NULL AND NOT @Status IS NULL) OR (NOT [Status] IS NULL AND @Status IS NULL)  OR [LatitudeStart] <> @LatitudeStart OR ([LatitudeStart] IS NULL AND NOT @LatitudeStart IS NULL) OR (NOT [LatitudeStart] IS NULL AND @LatitudeStart IS NULL)  OR [LongitudeStart] <> @LongitudeStart OR ([LongitudeStart] IS NULL AND NOT @LongitudeStart IS NULL) OR (NOT [LongitudeStart] IS NULL AND @LongitudeStart IS NULL)  OR [LatitudeEnd] <> @LatitudeEnd OR ([LatitudeEnd] IS NULL AND NOT @LatitudeEnd IS NULL) OR (NOT [LatitudeEnd] IS NULL AND @LatitudeEnd IS NULL)  OR [LongitudeEnd] <> @LongitudeEnd OR ([LongitudeEnd] IS NULL AND NOT @LongitudeEnd IS NULL) OR (NOT [LongitudeEnd] IS NULL AND @LongitudeEnd IS NULL)  OR [GPSTime] <> @GPSTime OR ([GPSTime] IS NULL AND NOT @GPSTime IS NULL) OR (NOT [GPSTime] IS NULL AND @GPSTime IS NULL)  OR [ContactVisiting] <> @ContactVisiting OR ([ContactVisiting] IS NULL AND NOT @ContactVisiting IS NULL) OR (NOT [ContactVisiting] IS NULL AND @ContactVisiting IS NULL)  OR [TypesDepartures] <> @TypesDepartures OR ([TypesDepartures] IS NULL AND NOT @TypesDepartures IS NULL) OR (NOT [TypesDepartures] IS NULL AND @TypesDepartures IS NULL)  OR [Importance] <> @Importance OR ([Importance] IS NULL AND NOT @Importance IS NULL) OR (NOT [Importance] IS NULL AND @Importance IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_markdelete]'
GO
 
ALTER PROCEDURE [Document].[Event_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@LatitudeStart DECIMAL(12,8),		@LongitudeStart DECIMAL(12,8),		@LatitudeEnd DECIMAL(12,8),		@LongitudeEnd DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event] WHERE Id = @Id) 
	UPDATE [Document].[Event] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[ApplicationJustification] = @ApplicationJustification,				[Client] = @Client,				[DivisionSource] = @DivisionSource,				[KindEvent] = @KindEvent,				[AnySale] = @AnySale,				[AnyProblem] = @AnyProblem,				[StartDatePlan] = @StartDatePlan,				[EndDatePlan] = @EndDatePlan,				[ActualStartDate] = @ActualStartDate,				[ActualEndDate] = @ActualEndDate,				[Author] = @Author,				[UserMA] = @UserMA,				[Comment] = @Comment,				[DetailedDescription] = @DetailedDescription,				[CommentContractor] = @CommentContractor,				[TargInteractions] = @TargInteractions,				[ResultInteractions] = @ResultInteractions,				[Status] = @Status,				[LatitudeStart] = @LatitudeStart,				[LongitudeStart] = @LongitudeStart,				[LatitudeEnd] = @LatitudeEnd,				[LongitudeEnd] = @LongitudeEnd,				[GPSTime] = @GPSTime,				[ContactVisiting] = @ContactVisiting,				[TypesDepartures] = @TypesDepartures,				[Importance] = @Importance			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Document].[Event] 
	( 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[ApplicationJustification],				[Client],				[DivisionSource],				[KindEvent],				[AnySale],				[AnyProblem],				[StartDatePlan],				[EndDatePlan],				[ActualStartDate],				[ActualEndDate],				[Author],				[UserMA],				[Comment],				[DetailedDescription],				[CommentContractor],				[TargInteractions],				[ResultInteractions],				[Status],				[LatitudeStart],				[LongitudeStart],				[LatitudeEnd],				[LongitudeEnd],				[GPSTime],				[ContactVisiting],				[TypesDepartures],				[Importance]			) 
	VALUES 
	( 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@ApplicationJustification,				@Client,				@DivisionSource,				@KindEvent,				@AnySale,				@AnyProblem,				@StartDatePlan,				@EndDatePlan,				@ActualStartDate,				@ActualEndDate,				@Author,				@UserMA,				@Comment,				@DetailedDescription,				@CommentContractor,				@TargInteractions,				@ResultInteractions,				@Status,				@LatitudeStart,				@LongitudeStart,				@LatitudeEnd,				@LongitudeEnd,				@GPSTime,				@ContactVisiting,				@TypesDepartures,				@Importance			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Document.Event',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [admin].[SyncDataSession]'
GO
CREATE TABLE [admin].[SyncDataSession] 
( 
[DeviceId] [varchar] (150) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Tablename] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[EntityId] [uniqueidentifier] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__SyncData__85163990D06C15D8] on [admin].[SyncDataSession]'
GO
ALTER TABLE [admin].[SyncDataSession] ADD CONSTRAINT [PK__SyncData__85163990D06C15D8] PRIMARY KEY NONCLUSTERED  ([DeviceId], [Tablename], [EntityId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [admin].[UncomfirmedSyncDataSession]'
GO
CREATE TABLE [admin].[UncomfirmedSyncDataSession] 
( 
[DeviceId] [varchar] (150) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Tablename] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[EntityId] [uniqueidentifier] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__Uncomfir__851639907AA8E2A8] on [admin].[UncomfirmedSyncDataSession]'
GO
ALTER TABLE [admin].[UncomfirmedSyncDataSession] ADD CONSTRAINT [PK__Uncomfir__851639907AA8E2A8] PRIMARY KEY NONCLUSTERED  ([DeviceId], [Tablename], [EntityId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ReportQuery]'
GO
CREATE TABLE [dbo].[ReportQuery] 
( 
[Name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Query] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Number] [int] NOT NULL IDENTITY(1, 1) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__ReportQu__78A1A19C26DEE57B] on [dbo].[ReportQuery]'
GO
ALTER TABLE [dbo].[ReportQuery] ADD CONSTRAINT [PK__ReportQu__78A1A19C26DEE57B] PRIMARY KEY CLUSTERED  ([Number])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

DECLARE @pv binary(16)

PRINT(N'Add 2 rows to [dbo].[ReportQuery]')
SET IDENTITY_INSERT [dbo].[ReportQuery] ON
EXEC(N'INSERT INTO [dbo].[ReportQuery] ([Number], [Name], [Query]) VALUES (1, N''RimPlanFact'', N''Select Total.EventId,
Total.AmountFact,
Total.AmountFactSumMaterials,
Total.AmountFactSumServices,
Total.AmountPlan,
Total.AmountPlanSumMaterials,
Total.AmountPlanSumServices,
Total.ClientDesc,
Total.Date,
Total.Importance,
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
Total.TypeDeparture,
Total.Unit,
Total.UserName
 From
(Select Distinct DocumentEvent.Id As ''''EventIdRight'''' 

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
    ''''@Search'''' = ''''null''''
    OR CatalogClient.Description Like ''''%@Search%'''' 
    OR CatalogTypesDepartures.Description Like ''''%@Search%'''' 
    OR DocumentEvent.Number Like ''''%@Search%'''' 
    OR CatalogRIM.Description Like ''''%@Search%'''' 
    )
    AND(
    ''''@ClientId'''' = ''''null''''
    OR ''''@ClientId'''' = CatalogClient.Id
    )
    AND(
    ''''@TypeDepartureID'''' = ''''null''''
    OR ''''@TypeDepartureID'''' = CatalogTypesDepartures.Id
    )
    AND(
    ''''@UserId'''' = ''''null''''
    OR ''''@UserId'''' = CatalogUser.Id
    )
    AND(
    ''''@StartDate'''' = ''''null''''
    OR DATEADD(DAY, DATEDIFF(DAY, ''''19000101'''', ''''@StartDate''''), ''''19000101'''') <= DocumentEvent.Date
    )
    AND(
    ''''@EndDate'''' = ''''null''''
    OR  DATEADD(DAY, DATEDIFF(DAY, ''''18991231'''', ''''@EndDate''''), ''''19000101'''') >= DocumentEvent.Date
    )
	) As OnlyId
	Left Join
(
Select 
DocumentEvent.Id As ''''EventId'''',
DocumentEvent.StartDatePlan AS ''''Date'''',
CatalogClient.Description AS ''''ClientDesc'''',
DocumentEvent.Number AS ''''Number'''',
CatalogTypesDepartures.Description AS ''''TypeDeparture'''',
CatalogUser.UserName AS ''''UserName'''',
CatalogRIM.[Description] AS ''''RIMDesc'''',
CatalogRIM.Service AS ''''IsService'''',
CatalogRIM.Unit AS ''''Unit'''',
CatalogRIM.Price As ''''Price'''',
DocumentEventServicesMaterials.AmountPlan AS ''''AmountPlan'''',
DocumentEventServicesMaterials.AmountFact AS ''''AmountFact'''',
DocumentEventServicesMaterials.SumPlan AS ''''SumPlan'''',
DocumentEventServicesMaterials.SumFact AS ''''SumFact'''',
EnumStatusImportance.[Name] AS ''''Importance'''',
(Select Sum(DocumentEventServicesMaterialsGroup.AmountPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''''AmountPlanSumServices'''',
(Select Sum(DocumentEventServicesMaterialsGroup.AmountFact)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And DocumentEventServicesMaterialsGroup.IsDeleted=0 
	And CR.Service = 1
 ) As ''''AmountFactSumServices'''',
  (Select Sum(DocumentEventServicesMaterialsGroup.SumPlan)
 From Document.Event_ServicesMaterials As DocumentEventServicesMaterialsGroup
 Left Join Catalog.RIM As CR On CR.Id = DocumentEventServicesMaterialsGroup.SKU
 where DocumentEventServicesMaterialsGroup.Ref = DocumentEvent.Id 
	And Docum'')')
UPDATE [dbo].[ReportQuery] SET [Query].WRITE(N'entEventServicesMaterialsGroup.IsDeleted=0 
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
',NULL,NULL) WHERE [Number] = 1
EXEC(N'INSERT INTO [dbo].[ReportQuery] ([Number], [Name], [Query]) VALUES (2, N''Discipline'', N''Select *,
Total.TimeSpendFact - Total.TimeSpendPlan As ''''DiffSpendTime'''',
Case 
When Total.MeterDiffGPsEnd Is Null then ''''undefine''''
When Total.MeterDiffGPsEnd <= 300 Then ''''dist_ok'''' 
When Total.MeterDiffGPsEnd>300 And Total.MeterDiffGPsEnd <= 600 Then ''''dist_half''''
When Total.MeterDiffGPsEnd>600 Then ''''dist_big''''
End As ''''IconStatusGpsEnd'''',
Case 
When Total.MeterDiffGPsStart Is Null then ''''undefine''''
When Total.MeterDiffGPsStart <= 300 Then ''''dist_ok'''' 
When Total.MeterDiffGPsStart>300 And Total.MeterDiffGPsStart <= 600 Then ''''dist_half''''
When Total.MeterDiffGPsStart>600 Then ''''dist_big''''
End As ''''IconStatusGpsStart'''',
Case 
When Total.TimeLate <= 5 AND Total.TimeLate >= -5 Then ''''OK'''' 
When Total.TimeLate > 5 AND Total.TimeLate <= 15 Then ''''yellow_circle_15''''
When Total.TimeLate < -5 AND Total.TimeLate >= -15 Then ''''yellow_circle_45''''
When Total.TimeLate < -15 Then ''''red_circle_15''''
When Total.TimeLate > 15 Then ''''red_circle_45''''
End As ''''IconStatusTimeLate'''',
Case 
When Total.TimeSpendFact - Total.TimeSpendPlan >=-15 And Total.TimeSpendFact - Total.TimeSpendPlan <= 15 then ''''OK''''
When Total.TimeSpendFact - Total.TimeSpendPlan > 15 And Total.TimeSpendFact - Total.TimeSpendPlan <= 30 then ''''yellow_circle_15'''' 
When Total.TimeSpendFact - Total.TimeSpendPlan < -15 And Total.TimeSpendFact - Total.TimeSpendPlan >= -30 then ''''yellow_circle_45'''' 
When Total.TimeSpendFact - Total.TimeSpendPlan < 30 then ''''red_circle_15'''' 
When Total.TimeSpendFact - Total.TimeSpendPlan > 30 then ''''red_circle_45'''' 
End As ''''IconStatusDiffSpendTime'''',
CONVERT(varchar(10), Total.TimeSpendFact) + ''''/'''' +CONVERT(varchar(10),  Total.TimeSpendPlan) As ''''TimeSpentSub''''
From (
Select 
DocumentEvent.Id As ''''EventId'''',
DocumentEvent.Date AS ''''Date'''',
CatalogClient.Description AS ''''ClientDesc'''',
DocumentEvent.Number AS ''''Number'''',
CatalogTypesDepartures.Description AS ''''TypeDeparture'''',
CatalogUser.UserName AS ''''UserName'''',
DATEDIFF ( MINUTE , DocumentEvent.StartDatePlan , DocumentEvent.ActualStartDate )  As ''''TimeLate'''',
DocumentEvent.StartDatePlan AS ''''PlanTimeStart'''',
DocumentEvent.ActualStartDate AS ''''FactTimeStart'''',
DATEDIFF ( MINUTE ,  DocumentEvent.ActualStartDate,DocumentEvent.ActualEndDate )  As ''''TimeSpendFact'''',
DATEDIFF ( MINUTE ,  DocumentEvent.StartDatePlan,DocumentEvent.EndDatePlan)  As ''''TimeSpendPlan'''',
Case 
	When  CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL OR DocumentEvent.LatitudeStart IS NULL OR DocumentEvent.LongitudeStart IS NULL Then
		null
	Else
		geography::Point(CatalogClient.Latitude,CatalogClient.Longitude, 4326).STDistance(geography::Point(DocumentEvent.LatitudeStart,DocumentEvent.LongitudeStart, 4326))
END as ''''MeterDiffGPsStart'''',

Case 
	When  CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL OR DocumentEvent.LatitudeEnd IS NULL OR DocumentEvent.LongitudeEnd IS NULL Then
		null
	Else 
		geography::Point(CatalogClient.Latitude,CatalogClient.Longitude, 4326).STDistance(geography::Point(DocumentEvent.LatitudeEnd,DocumentEvent.LongitudeEnd, 4326))  
END as ''''MeterDiffGPsEnd'''',
EnumStatusImportance.[Name] AS ''''Importance'''' 
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
								On EnumStatusyEvents.Id = DocumentEvent.Status And (EnumStatusyEvents.Name = ''''Done'''' 
									OR EnumStatusyEvents.Name = ''''DoneWithTrouble''''
									OR EnumStatusyEvents.Name ='')')
UPDATE [dbo].[ReportQuery] SET [Query].WRITE(N' ''OnTheApprovalOf''
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
	Order By Total.Number',NULL,NULL) WHERE [Number] = 2
SET IDENTITY_INSERT [dbo].[ReportQuery] OFF
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Update Event End GPS, Set 0'
Update Document.Event Set LatitudeEnd = 0 Where NOT LatitudeStart Is NULL
Update Document.Event Set LongitudeEnd = 0 Where NOT LongitudeStart Is NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Set DBVersion = 3.1.7.0'
IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.7.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.7.0');
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
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
