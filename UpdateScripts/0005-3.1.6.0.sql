IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.5.0' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.6.0' )

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



GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating types'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Event_EventFiskalProperties] AS TABLE 
( 
[LineNumber] [int] NULL, 
[CheckNumber] [int] NULL, 
[Date] [datetime2] NULL, 
[ShiftNumber] [int] NULL, 
[NumberFtpr] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
[PaymentType] [int] NULL, 
[PaymentAmount] [decimal] (15, 2) NULL, 
[User] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([User]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[RIM] ADD 
[VAT] [uniqueidentifier] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_getchanges]'
GO
 
 
ALTER PROCEDURE [Catalog].[RIM_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Catalog].[RIM] E 
	JOIN [Catalog].[RIM_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Catalog.RIM' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!IsFolder],NULL AS [Row!2!Parent],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!Price],NULL AS [Row!2!Service],NULL AS [Row!2!SKU],NULL AS [Row!2!Unit],NULL AS [Row!2!VAT]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Predefined] AS [Row!2!Predefined],H.[DeletionMark] AS [Row!2!DeletionMark],H.[IsFolder] AS [Row!2!IsFolder],H.[Parent] AS [Row!2!Parent],H.[Description] AS [Row!2!Description],H.[Code] AS [Row!2!Code],H.[Price] AS [Row!2!Price],H.[Service] AS [Row!2!Service],H.[SKU] AS [Row!2!SKU],H.[Unit] AS [Row!2!Unit],H.[VAT] AS [Row!2!VAT]							FROM [Catalog].[RIM] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties]'
GO
CREATE TABLE [Document].[Event_EventFiskalProperties] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Event_EventF__Id__2FBA0BF1] DEFAULT (newsequentialid()), 
[Ref] [uniqueidentifier] NOT NULL, 
[LineNumber] [int] NULL, 
[CheckNumber] [int] NULL, 
[Date] [datetime2] NULL, 
[ShiftNumber] [int] NULL, 
[NumberFtpr] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
[PaymentType] [int] NULL, 
[PaymentAmount] [decimal] (15, 2) NULL, 
[User] [uniqueidentifier] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_EventFiskalProperties] on [Document].[Event_EventFiskalProperties]'
GO
ALTER TABLE [Document].[Event_EventFiskalProperties] ADD CONSTRAINT [PK_Document_Event_EventFiskalProperties] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_EventFiskalProperties]'
GO
ALTER TABLE [Document].[Event_EventFiskalProperties] ADD CONSTRAINT [UQ_Document_Event_EventFiskalProperties_Key] UNIQUE NONCLUSTERED  ([Ref], [User])
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]						,NULL AS [Files!11] 
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
	H.[Posted] AS [Row!2!Posted],H.[DeletionMark] AS [Row!2!DeletionMark],H.[Date] AS [Row!2!Date],H.[Number] AS [Row!2!Number],H.[ApplicationJustification] AS [Row!2!ApplicationJustification],H.[Client] AS [Row!2!Client],H.[DivisionSource] AS [Row!2!DivisionSource],H.[KindEvent] AS [Row!2!KindEvent],H.[AnySale] AS [Row!2!AnySale],H.[AnyProblem] AS [Row!2!AnyProblem],H.[StartDatePlan] AS [Row!2!StartDatePlan],H.[EndDatePlan] AS [Row!2!EndDatePlan],H.[ActualStartDate] AS [Row!2!ActualStartDate],H.[ActualEndDate] AS [Row!2!ActualEndDate],H.[Author] AS [Row!2!Author],H.[UserMA] AS [Row!2!UserMA],H.[Comment] AS [Row!2!Comment],H.[DetailedDescription] AS [Row!2!DetailedDescription],H.[CommentContractor] AS [Row!2!CommentContractor],H.[TargInteractions] AS [Row!2!TargInteractions],H.[ResultInteractions] AS [Row!2!ResultInteractions],H.[Status] AS [Row!2!Status],H.[Latitude] AS [Row!2!Latitude],H.[Longitude] AS [Row!2!Longitude],H.[GPSTime] AS [Row!2!GPSTime],H.[ContactVisiting] AS [Row!2!ContactVisiting],H.[TypesDepartures] AS [Row!2!TypesDepartures],H.[Importance] AS [Row!2!Importance]						,NULL AS [Files!11] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!11] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!11] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!21] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!21] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!31] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!31] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!41] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!41] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!51] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!51] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!61] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!61] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!71] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!71] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!81] 
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
	NULL AS [Row!2!Posted],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!ApplicationJustification],NULL AS [Row!2!Client],NULL AS [Row!2!DivisionSource],NULL AS [Row!2!KindEvent],NULL AS [Row!2!AnySale],NULL AS [Row!2!AnyProblem],NULL AS [Row!2!StartDatePlan],NULL AS [Row!2!EndDatePlan],NULL AS [Row!2!ActualStartDate],NULL AS [Row!2!ActualEndDate],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA],NULL AS [Row!2!Comment],NULL AS [Row!2!DetailedDescription],NULL AS [Row!2!CommentContractor],NULL AS [Row!2!TargInteractions],NULL AS [Row!2!ResultInteractions],NULL AS [Row!2!Status],NULL AS [Row!2!Latitude],NULL AS [Row!2!Longitude],NULL AS [Row!2!GPSTime],NULL AS [Row!2!ContactVisiting],NULL AS [Row!2!TypesDepartures],NULL AS [Row!2!Importance]			,NULL AS [Files!81] 
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
PRINT N'Creating [Enum].[VATS]'
GO
CREATE TABLE [Enum].[VATS] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[Name] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Enum_VATS] on [Enum].[VATS]'
GO
ALTER TABLE [Enum].[VATS] ADD CONSTRAINT [PK_Enum_VATS] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Enum].[VATS_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Enum].[VATS] E 
	JOIN [Enum].[VATS_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Enum.VATS' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Name],NULL AS [Row!2!Description]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Name] AS [Row!2!Name],H.[Description] AS [Row!2!Description]							FROM [Enum].[VATS] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Enum].[VATS_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Enum].[VATS]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Name],				[Description]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Name,				@Description			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_update]'
GO
 
CREATE PROCEDURE [Enum].[VATS_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	UPDATE [Enum].[VATS] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id AND 
	( 1=0 OR [Name] <> @Name OR ([Name] IS NULL AND NOT @Name IS NULL) OR (NOT [Name] IS NULL AND @Name IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_markdelete]'
GO
 
CREATE PROCEDURE [Enum].[VATS_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Enum].[VATS] WHERE Id = @Id) 
	UPDATE [Enum].[VATS] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Enum].[VATS] 
	( 
				[Id],				[Name],				[Description]			) 
	VALUES 
	( 
				@Id,				@Name,				@Description			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Enum.VATS',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_delete]'
GO
 
CREATE PROCEDURE [Enum].[VATS_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Enum].[VATS] WHERE Id = @Id 
	UPDATE [Enum].[VATS_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_exists]'
GO
 
CREATE PROCEDURE [Enum].[VATS_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Enum].[VATS] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[VATS_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Enum].[VATS_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Enum.VATS' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Enum].[VATS] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@CheckNumber INT,		@Date DATETIME2,		@ShiftNumber INT,		@NumberFtpr NVARCHAR(100),		@PaymentType INT,		@PaymentAmount DECIMAL(15,2),		@User UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_EventFiskalProperties]( 
		[Ref],[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@CheckNumber,@Date,@ShiftNumber,@NumberFtpr,@PaymentType,@PaymentAmount,@User	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_EventFiskalProperties] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_EventFiskalProperties]( 
		[Ref],[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]	) 
	SELECT  
		@Ref 
		,[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_clear]'
GO
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_clear] @Ref UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Event_EventFiskalProperties] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_selectkeys]'
GO
 
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_selectkeys] @Ref UNIQUEIDENTIFIER AS 
	SELECT [Ref],[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]	FROM [Document].[Event_EventFiskalProperties] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_update]'
GO
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@CheckNumber INT,		@Date DATETIME2,		@ShiftNumber INT,		@NumberFtpr NVARCHAR(100),		@PaymentType INT,		@PaymentAmount DECIMAL(15,2),		@User UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event_EventFiskalProperties] WHERE [Ref] = @Ref AND ([User] = @User OR ([User] IS NULL AND @User IS NULL))) 
	UPDATE [Document].[Event_EventFiskalProperties] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[CheckNumber] = @CheckNumber,				[Date] = @Date,				[ShiftNumber] = @ShiftNumber,				[NumberFtpr] = @NumberFtpr,				[PaymentType] = @PaymentType,				[PaymentAmount] = @PaymentAmount,				[User] = @User			WHERE [Ref] = @Ref AND [User] = @User AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [CheckNumber] <> @CheckNumber OR [Date] <> @Date OR [ShiftNumber] <> @ShiftNumber OR [NumberFtpr] <> @NumberFtpr OR [PaymentType] <> @PaymentType OR [PaymentAmount] <> @PaymentAmount ) 
	ELSE 
	INSERT INTO [Document].[Event_EventFiskalProperties]( 
		[Ref],[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@CheckNumber,@Date,@ShiftNumber,@NumberFtpr,@PaymentType,@PaymentAmount,@User	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_EventFiskalProperties] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event_EventFiskalProperties] SET 
				[LineNumber] = D.[LineNumber],				[CheckNumber] = D.[CheckNumber],				[Date] = D.[Date],				[ShiftNumber] = D.[ShiftNumber],				[NumberFtpr] = D.[NumberFtpr],				[PaymentType] = D.[PaymentType],				[PaymentAmount] = D.[PaymentAmount],				[User] = D.[User]			FROM [Document].[Event_EventFiskalProperties] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[User] = D.[User] OR (T.[User] IS NULL AND D.[User] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[CheckNumber] <> D.[CheckNumber] OR T.[Date] <> D.[Date] OR T.[ShiftNumber] <> D.[ShiftNumber] OR T.[NumberFtpr] <> D.[NumberFtpr] OR T.[PaymentType] <> D.[PaymentType] OR T.[PaymentAmount] <> D.[PaymentAmount] OR T.[User] <> D.[User] ) 
 
	INSERT INTO [Document].[Event_EventFiskalProperties]( 
		[Ref],[LineNumber],[CheckNumber],[Date],[ShiftNumber],[NumberFtpr],[PaymentType],[PaymentAmount],[User]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[CheckNumber],D.[Date],D.[ShiftNumber],D.[NumberFtpr],D.[PaymentType],D.[PaymentAmount],D.[User]		FROM @Data D 
		LEFT JOIN [Document].[Event_EventFiskalProperties] T ON T.Ref = @Ref AND (T.[User] = D.[User] OR (T.[User] IS NULL AND D.[User] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Event_EventFiskalProperties] 
	FROM [Document].[Event_EventFiskalProperties] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[User] = D.[User] OR (T.[User] IS NULL AND D.[User] IS NULL))	WHERE T.Ref = @Ref AND D.[User] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_EventFiskalProperties_adm_delete]'
GO
 
CREATE PROCEDURE [Document].[Event_EventFiskalProperties_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@User UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Event_EventFiskalProperties] 
	WHERE [Ref] = @Ref AND [User] = @User	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[RIM_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5),		@VAT UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[RIM]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code],				[Price],				[Service],				[SKU],				[Unit],				[VAT]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code,				@Price,				@Service,				@SKU,				@Unit,				@VAT			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[RIM_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5),		@VAT UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[RIM] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code,				[Price] = @Price,				[Service] = @Service,				[SKU] = @SKU,				[Unit] = @Unit,				[VAT] = @VAT			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [IsFolder] <> @IsFolder OR ([IsFolder] IS NULL AND NOT @IsFolder IS NULL) OR (NOT [IsFolder] IS NULL AND @IsFolder IS NULL)  OR [Parent] <> @Parent OR ([Parent] IS NULL AND NOT @Parent IS NULL) OR (NOT [Parent] IS NULL AND @Parent IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [Price] <> @Price OR ([Price] IS NULL AND NOT @Price IS NULL) OR (NOT [Price] IS NULL AND @Price IS NULL)  OR [Service] <> @Service OR ([Service] IS NULL AND NOT @Service IS NULL) OR (NOT [Service] IS NULL AND @Service IS NULL)  OR [SKU] <> @SKU OR ([SKU] IS NULL AND NOT @SKU IS NULL) OR (NOT [SKU] IS NULL AND @SKU IS NULL)  OR [Unit] <> @Unit OR ([Unit] IS NULL AND NOT @Unit IS NULL) OR (NOT [Unit] IS NULL AND @Unit IS NULL)  OR [VAT] <> @VAT OR ([VAT] IS NULL AND NOT @VAT IS NULL) OR (NOT [VAT] IS NULL AND @VAT IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[RIM_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5),		@VAT UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[RIM] WHERE Id = @Id) 
	UPDATE [Catalog].[RIM] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code,				[Price] = @Price,				[Service] = @Service,				[SKU] = @SKU,				[Unit] = @Unit,				[VAT] = @VAT			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[RIM] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code],				[Price],				[Service],				[SKU],				[Unit],				[VAT]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code,				@Price,				@Service,				@SKU,				@Unit,				@VAT			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.RIM',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Rebuilding [admin].[SyncConfiguration]'
GO
CREATE TABLE [admin].[RG_Recovery_1_SyncConfiguration] 
( 
[SyncTable] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[SyncFilter] [varchar] (max) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[DeleteFilter] [varchar] (max) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[SyncOrder] [int] NOT NULL, 
[SyncDownload] [bit] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TABLE [admin].[SyncConfiguration]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[admin].[RG_Recovery_1_SyncConfiguration]', N'SyncConfiguration', N'OBJECT'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[RIM]'
GO
ALTER TABLE [Catalog].[RIM] ADD CONSTRAINT [FK_Catalog_RIM_Enum_VATS_VAT] FOREIGN KEY ([VAT]) REFERENCES [Enum].[VATS] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_EventFiskalProperties]'
GO
ALTER TABLE [Document].[Event_EventFiskalProperties] ADD CONSTRAINT [FK_Document_Event_EventFiskalProperties_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_EventFiskalProperties] ADD CONSTRAINT [FK_Document_Event__EventFiskalProperties_Catalog_User_User] FOREIGN KEY ([User]) REFERENCES [Catalog].[User] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding New Data'
GO
PRINT(N'Add rows to [Enum].[VATS]')
INSERT INTO [Enum].[VATS] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('123f1daf-215e-417e-b975-223089e9f0d0', 1, 0, NULL, N'PercentWithoOut', N'4')
INSERT INTO [Enum].[VATS] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('7a3bfd88-68bd-44e3-87b0-51a844828792', 1, 0, NULL, N'Percent0', N'1')
INSERT INTO [Enum].[VATS] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('a100a27f-7f2f-488b-aab8-573db25f83c1', 1, 0, NULL, N'Percent10', N'2')
INSERT INTO [Enum].[VATS] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('7cb0603a-e767-4e13-b86b-882242e9e05f', 1, 0, NULL, N'Percent18', N'3')
PRINT(N'Operation applied to 4 rows out of 4')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Add row to [Enum].[Webactions]')
INSERT INTO [Enum].[Webactions] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('f22c49d3-42b4-4ccc-9646-970ee8f7db23', 1, 0, NULL, N'MobileFPRAccess', N'Доступ к фискальному регистратору из мобильного приложения')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Add rows to [Catalog].[SettingMobileApplication]')
INSERT INTO [Catalog].[SettingMobileApplication] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Predefined], [DeletionMark], [Description], [Code], [DataType], [LogicValue], [NumericValue]) VALUES ('8b543510-bc75-4247-9c2a-8f4134e81866', 636222408619217599, 0, 636222408619217599, 1, 0, N'EnableFPTR', N'000000015', NULL, 0, 0)
PRINT(N'Operation applied to 1 rows out of 15')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Add rows to [admin].[SyncConfiguration]')
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'admin.Entity', N'', N'', 0, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Accounts', N'', N'', 1, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Actions', N't.Id IN (SELECT DEC.Action FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)', N'', 2, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Actions_ValueList', N' EXISTS(SELECT NULL FROM [Catalog].[Actions] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DEC.Action FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)))', N'', 3, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Client', N't.Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)', N'', 4, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Client_Contacts', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 6, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Client_Files', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 5, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Client_Parameters', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 7, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.ClientOptions', N'', N'', 9, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.ClientOptions_ListValues', N'', N'', 10, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Contacts', N'', N'', 8, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Equipment', N't.Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))', N'', 12, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Equipment_Equipments', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 13, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Equipment_EquipmentsHistory', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId)))) AND (T.[Period] >(SELECT CASE WHEN LogicValue = 1         THEN CASE WHEN NumericValue = 0            THEN CAST(''1980-01-01 00:00:00'' as date)            ELSE (getDate() - NumericValue)            END         ELSE CAST(''2100-01-01 00:00:00'' as date)          END             FROM [Catalog].[SettingMobileApplication]       WHERE [Description] = ''HistoryLength''))', N'', 14, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Equipment_Files', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 15, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Equipment_Parameters', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 16, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.EquipmentOptions', N'', N'', 22, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.EquipmentOptions_ListValues', N'', N'', 23, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.EventOptions', N'', N'', 24, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.EventOptions_ListValues', N'', N'', 25, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.RIM', N'', N'', 26, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.Roles', N'', N'', 18, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.RoleWebactions', N'', N'', 27, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.ServiceAgreement', N't.Id IN (SELECT SE.CantractService FROM [Catalog].[Equipment_Equipments] SE WHERE SE.Clients IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId))', N'', 17, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.SettingMobileApplication', N'', N'', 28, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.SKU', N't.Id IN (SELECT DE.SKU FROM [Document].[Event_ServicesMaterials] DE WHERE DE.Ref IN (SELECT SE.Id FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))', N'', 11, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.TypesDepartures', N'', N'', 29, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.User', N't.[Id] = @UserId OR t.[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR t.[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)', N'', 19, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.User_Bag', N' EXISTS(SELECT NULL FROM [Catalog].[User] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] = @UserId OR [base].[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR [base].[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)))', N'', 20, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Catalog.User_RemainsNorms', N' EXISTS(SELECT NULL FROM [Catalog].[User] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] = @UserId OR [base].[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR [base].[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)))', N'', 21, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.CheckList', N't.Id IN (SELECT DEC.[CheckListRef] FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)', N'', 30, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.CheckList_Actions', N' EXISTS(SELECT NULL FROM [Document].[CheckList] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DEC.[CheckListRef] FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)))', N'', 31, 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event', N't.[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ', N'', 32, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_CheckList', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 37, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_Equipments', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 34, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_EventFiskalProperties', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 40, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_Files', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 33, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_Parameters', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 36, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_Photos', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 35, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_ServicesMaterials', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 39, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Event_TypeDepartures', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] LEFT JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 38, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.EventHistory', N'', N'', 41, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.NeedMat', N't.[SR] = @UserId', N'', 42, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.NeedMat_Matireals', N' EXISTS(SELECT NULL FROM [Document].[NeedMat] base WHERE [base].[Id]=T.[Ref] AND ([base].[SR] = @UserId))', N'', 43, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Reminder', N'', N'', 44, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Reminder_Photo', N'', N'', 45, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Task', N'', N'', 46, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Task_Status', N'', N'', 48, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Document.Task_Targets', N'', N'', 47, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.CheckListStatus', N'', N'', 49, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.FoReminders', N'', N'', 50, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.ResultEvent', N'', N'', 51, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.StatsNeedNum', N'', N'', 52, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.StatusEquipment', N'', N'', 53, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.StatusImportance', N'', N'', 54, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.StatusTasks', N'', N'', 55, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.StatusyEvents', N'', N'', 56, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.TypesDataParameters', N'', N'', 57, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.TypesEvents', N'', N'', 58, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.VATS', N'', N'', 59, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'Enum.Webactions', N'', N'', 60, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.BusinessProcess', N'', N'', 61, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Configuration', N'', N'', 62, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Image', N'', N'', 63, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Screen', N'', N'', 64, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Script', N'', N'', 65, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Style', N'', N'', 66, 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder], [SyncDownload]) VALUES (N'resource.Translation', N'', N'', 67, 1)
PRINT(N'Operation applied to 68 rows out of 68')

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

Print N'Add 18% for all Rim'
Update Catalog.RIM Set VAT='7cb0603a-e767-4e13-b86b-882242e9e05f'

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO




PRINT N'Set DBVersion = 3.1.6.0'
IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.6.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.6.0');
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
