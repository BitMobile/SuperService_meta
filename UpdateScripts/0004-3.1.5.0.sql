IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.4.0' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.5.0' )

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
PRINT N'Creating [Document].[EventHistory]'
GO
CREATE TABLE [Document].[EventHistory] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[Date] [datetime2] NOT NULL, 
[DeletionMark] [bit] NOT NULL, 
[Status] [uniqueidentifier] NOT NULL, 
[Event] [uniqueidentifier] NOT NULL, 
[Author] [uniqueidentifier] NULL, 
[UserMA] [uniqueidentifier] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_EventHistory] on [Document].[EventHistory]'
GO
ALTER TABLE [Document].[EventHistory] ADD CONSTRAINT [PK_Document_EventHistory] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Document].[EventHistory_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Document].[EventHistory] E 
	JOIN [Document].[EventHistory_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Document.EventHistory' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Date],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Status],NULL AS [Row!2!Event],NULL AS [Row!2!Author],NULL AS [Row!2!UserMA]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Date] AS [Row!2!Date],H.[DeletionMark] AS [Row!2!DeletionMark],H.[Status] AS [Row!2!Status],H.[Event] AS [Row!2!Event],H.[Author] AS [Row!2!Author],H.[UserMA] AS [Row!2!UserMA]							FROM [Document].[EventHistory] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_insert]'
GO
 
 
 
 
CREATE PROCEDURE [Document].[EventHistory_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Date DATETIME2,		@DeletionMark BIT,		@Status UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[EventHistory]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Date],				[DeletionMark],				[Status],				[Event],				[Author],				[UserMA]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Date,				@DeletionMark,				@Status,				@Event,				@Author,				@UserMA			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_update]'
GO
 
CREATE PROCEDURE [Document].[EventHistory_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Date DATETIME2,		@DeletionMark BIT,		@Status UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Document].[EventHistory] SET 
				[Id] = @Id,				[Date] = @Date,				[DeletionMark] = @DeletionMark,				[Status] = @Status,				[Event] = @Event,				[Author] = @Author,				[UserMA] = @UserMA			WHERE Id = @Id AND 
	( 1=0 OR [Date] <> @Date OR ([Date] IS NULL AND NOT @Date IS NULL) OR (NOT [Date] IS NULL AND @Date IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Status] <> @Status OR ([Status] IS NULL AND NOT @Status IS NULL) OR (NOT [Status] IS NULL AND @Status IS NULL)  OR [Event] <> @Event OR ([Event] IS NULL AND NOT @Event IS NULL) OR (NOT [Event] IS NULL AND @Event IS NULL)  OR [Author] <> @Author OR ([Author] IS NULL AND NOT @Author IS NULL) OR (NOT [Author] IS NULL AND @Author IS NULL)  OR [UserMA] <> @UserMA OR ([UserMA] IS NULL AND NOT @UserMA IS NULL) OR (NOT [UserMA] IS NULL AND @UserMA IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_markdelete]'
GO
 
CREATE PROCEDURE [Document].[EventHistory_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Date DATETIME2,		@DeletionMark BIT,		@Status UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[EventHistory] WHERE Id = @Id) 
	UPDATE [Document].[EventHistory] SET 
				[Id] = @Id,				[Date] = @Date,				[DeletionMark] = @DeletionMark,				[Status] = @Status,				[Event] = @Event,				[Author] = @Author,				[UserMA] = @UserMA			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Document].[EventHistory] 
	( 
				[Id],				[Date],				[DeletionMark],				[Status],				[Event],				[Author],				[UserMA]			) 
	VALUES 
	( 
				@Id,				@Date,				@DeletionMark,				@Status,				@Event,				@Author,				@UserMA			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Document.EventHistory',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_delete]'
GO
 
CREATE PROCEDURE [Document].[EventHistory_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Document].[EventHistory] WHERE Id = @Id 
	UPDATE [Document].[EventHistory_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_exists]'
GO
 
CREATE PROCEDURE [Document].[EventHistory_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Document].[EventHistory] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[EventHistory_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Document].[EventHistory_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Document.EventHistory' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Document].[EventHistory] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[EventHistory]'
GO
ALTER TABLE [Document].[EventHistory] ADD CONSTRAINT [FK_Document_EventHistory_Enum_StatusyEvents_Status] FOREIGN KEY ([Status]) REFERENCES [Enum].[StatusyEvents] ([Id]) 
GO
ALTER TABLE [Document].[EventHistory] ADD CONSTRAINT [FK_Document_EventHistory_Document_Event_Event] FOREIGN KEY ([Event]) REFERENCES [Document].[Event] ([Id]) 
GO
ALTER TABLE [Document].[EventHistory] ADD CONSTRAINT [FK_Document_EventHistory_Catalog_User_Author] FOREIGN KEY ([Author]) REFERENCES [Catalog].[User] ([Id]) 
GO
ALTER TABLE [Document].[EventHistory] ADD CONSTRAINT [FK_Document_EventHistory_Catalog_User_UserMA] FOREIGN KEY ([UserMA]) REFERENCES [Catalog].[User] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

DELETE FROM [admin].[SyncConfiguration]
PRINT(N'Add 66 rows to [admin].[SyncConfiguration]')
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'admin.Entity', N'', N'', 0)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Accounts', N'', N'', 1)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Actions', N't.Id IN (SELECT DEC.Action FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)', N'', 2)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Actions_ValueList', N' EXISTS(SELECT NULL FROM [Catalog].[Actions] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DEC.Action FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)))', N'', 3)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Client', N't.Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)', N'', 4)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Client_Contacts', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 6)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Client_Files', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 5)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Client_Parameters', N' EXISTS(SELECT NULL FROM [Catalog].[Client] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId)))', N'', 7)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.ClientOptions', N'', N'', 9)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.ClientOptions_ListValues', N'', N'', 10)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Contacts', N'', N'', 8)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Equipment', N't.Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))', N'', 12)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Equipment_Equipments', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 13)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Equipment_EquipmentsHistory', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId)))) AND (T.[Period] >(SELECT CASE WHEN LogicValue = 1         THEN CASE WHEN NumericValue = 0            THEN CAST(''1980-01-01 00:00:00'' as date)            ELSE (getDate() - NumericValue)            END         ELSE CAST(''2100-01-01 00:00:00'' as date)          END             FROM [Catalog].[SettingMobileApplication]       WHERE [Description] = ''HistoryLength''))', N'', 14)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Equipment_Files', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 15)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Equipment_Parameters', N' EXISTS(SELECT NULL FROM [Catalog].[Equipment] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))))', N'', 16)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.EquipmentOptions', N'', N'', 22)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.EquipmentOptions_ListValues', N'', N'', 23)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.EventOptions', N'', N'', 24)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.EventOptions_ListValues', N'', N'', 25)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.RIM', N'', N'', 26)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.Roles', N'', N'', 18)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.RoleWebactions', N'', N'', 27)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.ServiceAgreement', N't.Id IN (SELECT SE.CantractService FROM [Catalog].[Equipment_Equipments] SE WHERE SE.Clients IN (SELECT DE.Client FROM [Document].[Event] DE WHERE DE.UserMA = @UserId))', N'', 17)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.SettingMobileApplication', N'', N'', 28)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.SKU', N't.Id IN (SELECT DE.SKU FROM [Document].[Event_ServicesMaterials] DE WHERE DE.Ref IN (SELECT SE.Id FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))', N'', 11)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.TypesDepartures', N'', N'', 29)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.User', N't.[Id] = @UserId OR t.[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR t.[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)', N'', 19)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.User_Bag', N' EXISTS(SELECT NULL FROM [Catalog].[User] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] = @UserId OR [base].[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR [base].[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)))', N'', 20)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Catalog.User_RemainsNorms', N' EXISTS(SELECT NULL FROM [Catalog].[User] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] = @UserId OR [base].[Id] IN (SELECT Executor FROM [Catalog].[Equipment_EquipmentsHistory] WHERE Equipments IN ( SELECT DE.Equipment FROM [Catalog].[Equipment_Equipments] DE WHERE DE.Clients IN (SELECT SE.Client FROM [Document].[Event] SE WHERE SE.UserMA = @UserId))) OR [base].[Id] IN (SELECT [Author] FROM [Document].[Event] WHERE [UserMA] = @UserId)))', N'', 21)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.CheckList', N't.Id IN (SELECT DEC.[CheckListRef] FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)', N'', 30)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.CheckList_Actions', N' EXISTS(SELECT NULL FROM [Document].[CheckList] base WHERE [base].[Id]=T.[Ref] AND ([base].Id IN (SELECT DEC.[CheckListRef] FROM [Document].[Event_CheckList] DEC LEFT JOIN [Document].[Event] DE ON DEC.Ref = DE.Id WHERE DE.[UserMA] = @UserId)))', N'', 31)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event', N't.[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ', N'', 32)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_CheckList', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 37)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_Equipments', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 34)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_Files', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 33)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_Parameters', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 36)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_Photos', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 35)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_ServicesMaterials', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 39)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Event_TypeDepartures', N' EXISTS(SELECT NULL FROM [Document].[Event] base WHERE [base].[Id]=T.[Ref] AND ([base].[Id] IN(SELECT DISTINCT EV.[Id] FROM [Document].[Event] EV JOIN [Enum].[StatusyEvents] SE ON EV.[Status] = SE.[Id] JOIN [Document].[EventHistory] EH ON EH.Event = EV.Id WHERE (EV.[UserMA] = @UserId OR (EH.UserMA = @UserId AND EH.Date >(getDate()-30))) AND EV.[StartDatePlan] >(getDate() - 31) AND (NOT (SE.[Name] = ''New'')) AND (NOT (SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') OR ((SE.[Name] = ''Done'' OR SE.[Name] = ''Cancel'' OR SE.[Name] = ''DoneWithTrouble'' OR SE.[Name] = ''Close'' OR SE.[Name] = ''NotDone'' OR SE.[Name] = ''OnTheApprovalOf'') AND EV.[ActualEndDate] >(getDate() - 1)))) ))', N'', 38)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.EventHistory', N'', N'', 40)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.NeedMat', N't.[SR] = @UserId', N'', 41)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.NeedMat_Matireals', N' EXISTS(SELECT NULL FROM [Document].[NeedMat] base WHERE [base].[Id]=T.[Ref] AND ([base].[SR] = @UserId))', N'', 42)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Reminder', N'', N'', 43)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Reminder_Photo', N'', N'', 44)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Task', N'', N'', 45)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Task_Status', N'', N'', 47)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Document.Task_Targets', N'', N'', 46)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.CheckListStatus', N'', N'', 48)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.FoReminders', N'', N'', 49)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.ResultEvent', N'', N'', 50)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.StatsNeedNum', N'', N'', 51)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.StatusEquipment', N'', N'', 52)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.StatusImportance', N'', N'', 53)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.StatusTasks', N'', N'', 54)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.StatusyEvents', N'', N'', 55)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.TypesDataParameters', N'', N'', 56)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.TypesEvents', N'', N'', 57)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'Enum.Webactions', N'', N'', 58)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.BusinessProcess', N'', N'', 59)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Configuration', N'', N'', 60)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Image', N'', N'', 61)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Screen', N'', N'', 62)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Script', N'', N'', 63)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Style', N'', N'', 64)
INSERT INTO [admin].[SyncConfiguration] ([SyncTable], [SyncFilter], [DeleteFilter], [SyncOrder]) VALUES (N'resource.Translation', N'', N'', 65)
PRINT(N'Add rows to [Enum].[StatusyEvents]')
UPDATE [Enum].[StatusyEvents] SET [Name] = 'CancelOLD' Where [Name] = 'Cancel'
UPDATE [Enum].[StatusyEvents] SET [Name] = 'DoneOLD' Where [Name] = 'Done'
UPDATE [Enum].[StatusyEvents] SET [Description] = 'В работе' Where [Name] = 'InWork'
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('1220b261-dbcf-4df5-aec1-6630c250d643', 1, 0, NULL, N'DoneWithTrouble', N'Выполнен с проблемой')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('5f99e04e-10a8-4224-949a-7ed7863e1fb9', 1, 0, NULL, N'New', N'Создан')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('e97536d7-061f-4b9a-9257-871ed9ad9229', 1, 0, NULL, N'OnHarmonization', N'На согласовании')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('57e71cfb-3d2e-4f57-9764-8f1a8a41d387', 1, 0, NULL, N'Cancel', N'Отклонен')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('46428625-7b29-41dc-a2a2-9c07cfbd85b2', 1, 0, NULL, N'Agreed', N'Согласован')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('be45c12b-267a-4c59-89b1-ac06af6dbc86', 1, 0, NULL, N'OnTheApprovalOf', N'На утверждении')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('7ecb70fa-fc91-49f0-a7fd-b905bd994a02', 1, 0, NULL, N'NotDone', N'Не справились')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('3943413c-cf47-4f3b-8795-b93c9f78d1c6', 1, 0, NULL, N'Done', N'Выполнен')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('c36d3c89-3dbb-4b12-aef0-c970347e3961', 1, 0, NULL, N'Close', N'Закрыт')
INSERT INTO [Enum].[StatusyEvents] ([Id], [Timestamp], [IsDeleted], [KeyFieldTimestamp], [Name], [Description]) VALUES ('dfbe38ad-0b3b-462c-b4fe-e026b4701604', 1, 0, NULL, N'Accepted', N'Просмотрен')
PRINT(N'Operation applied to 10 rows out of 10')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Change appointed to Agreed')
UPDATE [Document].[Event] Set Status = '46428625-7b29-41dc-a2a2-9c07cfbd85b2' Where Status = (Select [Id] From [Enum].[StatusyEvents] where [Name]='Appointed')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Change Done to Close')
UPDATE [Document].[Event] Set Status = 'c36d3c89-3dbb-4b12-aef0-c970347e3961' Where Status = (Select [Id] From [Enum].[StatusyEvents] where [Name]='DoneOLD')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT(N'Change Cancel to Cancel')
UPDATE [Document].[Event] Set Status = '57e71cfb-3d2e-4f57-9764-8f1a8a41d387' Where Status = (Select [Id] From [Enum].[StatusyEvents] where [Name]='CancelOLD')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DELETE FROM [Enum].[StatusyEvents] Where [Name] = 'CancelOLD' OR [Name] = 'DoneOLD'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Set DBVersion = 3.1.5.0'
IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.5.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.5.0');
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
