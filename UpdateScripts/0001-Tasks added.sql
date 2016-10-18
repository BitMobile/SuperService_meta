/*

  Updates SuperService database for using Task module

*/


IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.3.0' )

  RETURN

SET NUMERIC_ROUNDABORT OFF -- не валимся при ошибках округления
GO

SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

SET XACT_ABORT ON   --прекращаем выполнение при ошибке
GO

SET QUOTED_IDENTIFIER ON
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

BEGIN TRANSACTION
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Update index for [Catalog].[Equipment_Equiements]'
GO

PRINT N'Dropping [Catalog].[UQ_Catalog_Equipment_Equiements_Key]...';
GO

DROP INDEX [UQ_Catalog_Equipment_Equiements_Key] ON [Catalog].[Equipment_Equiements]
GO

PRINT N'Creating [Catalog].[UQ_Catalog_Equipment_Equiements_Key]...';
GO

CREATE UNIQUE NONCLUSTERED INDEX [UQ_Catalog_Equipment_Equiements_Key] ON [Catalog].[Equipment_Equiements]
(
  [Ref] ASC,
  [Clients] ASC,
  [Equiement] ASC,
  [Period] ASC
)
WHERE ([IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Change lenght'
GO

ALTER TABLE [Catalog].[TypesDepartures] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[RIM] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [DetailedDescription] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [TargInteractions] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [ResultInteractions] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
DROP INDEX [UQ_Document_Event_Files_Key] ON [Document].[Event_Files]
GO
ALTER TABLE [Document].[Event_Files] ALTER COLUMN [FullFileName] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Document_Event_Files_Key] ON [Document].[Event_Files]
(
  [Ref] ASC,
  [FileName] ASC
)
WHERE ([IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Document].[Event_Equipments] ALTER COLUMN [Terget] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Document].[Event_CheckList] ALTER COLUMN [Result] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[SKU] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[ServiceAgreement] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ALTER COLUMN [Val] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[Equipment] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[Equipment_Equiements] ALTER COLUMN [ContactForEquiemnt] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[Equipment_Equiements] ALTER COLUMN [Info] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[Equipment_EquiementsHistory] ALTER COLUMN [ObjectGet] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[Equipment_EquiementsHistory] ALTER COLUMN [Comment] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
DROP INDEX [UQ_Catalog_Equipment_Files_Key] ON [Catalog].[Equipment_Files]
GO
ALTER TABLE [Catalog].[Equipment_Files] ALTER COLUMN [FullFileName] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Catalog_Equipment_Files_Key] ON [Catalog].[Equipment_Files]
(
  [Ref] ASC,
  [FileName] ASC
)
WHERE ([IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Catalog].[Client] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[Client] ALTER COLUMN [Address] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
DROP INDEX [UQ_Catalog_Client_Files_Key] ON [Catalog].[Client_Files]
GO
ALTER TABLE [Catalog].[Client_Files] ALTER COLUMN [FullFileName] nvarchar(1000) COLLATE Cyrillic_General_CI_AS NULL
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Catalog_Client_Files_Key] ON [Catalog].[Client_Files]
(
  [Ref] ASC,
  [FileName] ASC
)
WHERE ([IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Catalog].[SettingMobileApplication] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [Password] nvarchar(100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [EMail] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [Phone] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ALTER COLUMN [Val] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ALTER COLUMN [Val] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Document].[CheckList] ALTER COLUMN [Description] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO
ALTER TABLE [Catalog].[Contacts] ALTER COLUMN [Tel] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL
GO

PRINT N'Creating [Enum].[StatusTasks]'
GO

CREATE TABLE [Enum].[StatusTasks]
(
  [Id] [uniqueidentifier] NOT NULL,
  [Timestamp] [bigint] NULL,
  [IsDeleted] [bit] NULL,
  [Name] [nvarchar](100) NOT NULL,
  [Description] [nvarchar](100) NOT NULL,
  CONSTRAINT [PK_Enum_StatusTasks] PRIMARY KEY NONCLUSTERED 
  (
    [Id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Creating elements in [Enum].[StatusTasks]'

DECLARE @ts_date datetime2 = getdate()
DECLARE @ticksPerDay bigint = 864000000000
DECLARE @ts_date2 datetime2 = @ts_date
DECLARE @ts_dateBinary binary(9) = cast(reverse(cast(@ts_date2 as binary(9))) as binary(9))
DECLARE @ts_days bigint = cast(substring(@ts_dateBinary, 1, 3) as bigint)
DECLARE @ts_time bigint = cast(substring(@ts_dateBinary, 4, 5) as bigint)
DECLARE @ts_stamp bigint = @ts_days * @ticksPerDay + @ts_time

INSERT INTO [Enum].[StatusTasks]
           ([Id]
           ,[Timestamp]
           ,[IsDeleted]
           ,[Name]
           ,[Description])
     VALUES
           ('a0a9e67f-483e-419a-a714-859f13c1245c'
           ,@ts_stamp
           ,0
           ,'New'
           ,'Новая'),
      ('a0a9e67f-483e-423a-a714-859f13c1245c'
           ,@ts_stamp
           ,0
           ,'Done'
           ,'Выполнена'),
      ('a0a9e67f-483e-426b-a714-859f13c1245c'
           ,@ts_stamp
           ,0
           ,'Rejected'
           ,'Отклонена');

GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Creating [Document].[Task]'

CREATE TABLE [Document].[Task](
  [Id] [uniqueidentifier] NOT NULL,
  [Timestamp] [bigint] NULL,
  [IsDeleted] [bit] NULL,
  [Posted] [bit] NULL,
  [DeletionMark] [bit] NULL,
  [Date] [datetime2](7) NOT NULL,
  [Number] [nvarchar](9) NULL,
  [Description] [nvarchar](500) NULL,
  [TaskType] [nvarchar](100) NULL,
  [Client] [uniqueidentifier] NOT NULL,
  [Equipment] [uniqueidentifier] NULL,
  [CloseEvent] [uniqueidentifier] NULL,
  CONSTRAINT [PK_Document_Task] PRIMARY KEY NONCLUSTERED 
  (
    [Id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Catalog_Client_Client] FOREIGN KEY([Client])
REFERENCES [Catalog].[Client] ([Id])
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Catalog_Client_Client]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Catalog_Equipment_Equipment] FOREIGN KEY([Equipment])
REFERENCES [Catalog].[Equipment] ([Id])
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Catalog_Equipment_Equipment]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Document_Event_Event] FOREIGN KEY([Event])
REFERENCES [Document].[Event] ([Id])
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Document_Event_Event]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Creating [Document].[Task_Targets]'

CREATE TABLE [Document].[Task_Targets](
  [Id] [uniqueidentifier] NOT NULL,
  [Timestamp] [bigint] NULL,
  [IsDeleted] [bit] NULL,
  [Ref] [uniqueidentifier] NOT NULL,
  [Description]  [nvarchar](500) NULL,
  [IsDone] [bit] NULL,
  CONSTRAINT [PK_Document_Task_Targets] PRIMARY KEY NONCLUSTERED
  (
    [Id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Targets]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Targets_Document_Task_EntityId] FOREIGN KEY([Ref])
REFERENCES [Document].[Task] ([Id])
ON DELETE CASCADE
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Targets] CHECK CONSTRAINT [FK_Document_Task_Targets_Document_Task_EntityId]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO


PRINT N'Creating [Document].[Task_Status]'

CREATE TABLE [Document].[Task_Status](
  [Timestamp] [bigint] NULL,
  [IsDeleted] [bit] NULL,
  [Id] [uniqueidentifier] NOT NULL,
  [Ref] [uniqueidentifier] NOT NULL,
  [LineNumber] [int] NULL,
  [CommentContractor] [nvarchar](1000) NULL,
  [Status] [uniqueidentifier] NULL,
  [UserMA] [uniqueidentifier] NULL,
  [ActualEndDate] [datetime2](7) NULL,
  CONSTRAINT [PK_Document_Task_Status] PRIMARY KEY NONCLUSTERED
  (
    [Id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Document_Task_EntityId] FOREIGN KEY([Ref])
REFERENCES [Document].[Task] ([Id])
ON DELETE CASCADE
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Document_Task_EntityId]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Catalog_User_UserMA] FOREIGN KEY([UserMA])
REFERENCES [Catalog].[User] ([Id])
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Catalog_User_UserMA]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Enum_StatusTasks_Status] FOREIGN KEY([Status])
REFERENCES [Enum].[StatusTasks] ([Id])
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Enum_StatusTasks_Status]
GO

PRINT N'Creating [dbo].[PicturePaths]...';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

CREATE TABLE [dbo].[PicturePaths] (
    [Id]          UNIQUEIDENTIFIER NOT NULL,
    [Name]        NVARCHAR (200)   NOT NULL,
    [PrivatePath] NVARCHAR (250)   NULL,
    [SharedPath]  NVARCHAR (250)   NULL,
    CONSTRAINT [UQ_PicturePaths_Name] UNIQUE NONCLUSTERED ([Name] ASC),
  CONSTRAINT [PK_PicturePaths] PRIMARY KEY ([Id])
);
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Creating unnamed constraint on [dbo].[PicturePaths]...';
GO

ALTER TABLE [dbo].[PicturePaths]
    ADD DEFAULT (newsequentialid()) FOR [Id];
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [Name_ASC_Unclustered_Unique]
ON [dbo].[PicturePaths] ([Name] ASC)
WITH (PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [default]
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Add field [DeleteFilter] to [admin].[SyncConfiguration]'

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[admin].[SyncConfiguration]') 
         AND name = 'DeleteFilter'
)
BEGIN
  ALTER TABLE [admin].[SyncConfiguration] ADD
    [DeleteFilter] varchar(max) NOT NULL DEFAULT '' WITH VALUES
END
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Inserting data into [admin].[SyncConfiguration]'

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder]
           ,[DeleteFilter])
     VALUES
           ('Document.Task'
           ,''
           ,41
           ,'')

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder]
           ,[DeleteFilter])
     VALUES
           ('Document.Task_Targets'
           ,''
           ,42
           ,'')

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder]
           ,[DeleteFilter])
     VALUES
           ('Document.Task_Status'
           ,''
           ,43
           ,'')

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder]
           ,[DeleteFilter])
     VALUES
           ('Enum.StatusTasks'
           ,''
           ,51
           ,'')
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Update [Enum].[TypesDataParameters]'

DECLARE @ts_date datetime2 = getdate()
DECLARE @ticksPerDay bigint = 864000000000
DECLARE @ts_date2 datetime2 = @ts_date
DECLARE @ts_dateBinary binary(9) = cast(reverse(cast(@ts_date2 as binary(9))) as binary(9))
DECLARE @days bigint = cast(substring(@ts_dateBinary, 1, 3) as bigint)
DECLARE @ts_time bigint = cast(substring(@ts_dateBinary, 4, 5) as bigint)
DECLARE @ts_stamp bigint = @days * @ticksPerDay + @ts_time

UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Текст', [Timestamp]=@ts_stamp WHERE [Name]='String'
UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Целое число', [Timestamp]=@ts_stamp WHERE [Name]='Integer'
UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Дробное число', [Timestamp]=@ts_stamp WHERE [Name]='Decimal'
UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Логический', [Timestamp]=@ts_stamp WHERE [Name]='Boolean'
UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Дата', [Timestamp]=@ts_stamp WHERE [Name]='DateTime'
UPDATE [Enum].[TypesDataParameters] SET [Description]=N'Выбор из списка', [Timestamp]=@ts_stamp WHERE [Name]='ValList'
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO



PRINT N'Renaming objects with TYPO - equipment';
GO

 --table
sp_rename 'Catalog.Equipment_Equiements', 'Equipment_Equipments';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--fields
sp_rename 'Catalog.Equipment_Equipments.StatusEquiement', 'StatusEquipment', 'COLUMN';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.Equipment_Equipments.ContactForEquiemnt', 'ContactForEquipment', 'COLUMN';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.Equipment_Equipments.Equiement','Equipment','COLUMN';
GO
--keys

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.PK_Catalog_Equipment_Equiements','PK_Catalog_Equipment_Equipments','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__Equiements_Catalog_Client_Clients','FK_Catalog_Equipment__Equipments_Catalog_Client_Clients','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__Equiements_Catalog_Equipment_Equiement','FK_Catalog_Equipment__Equipments_Catalog_Equipment_Equipment','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__Equiements_Catalog_ServiceAgreement_CantractService','FK_Catalog_Equipment__Equipments_Catalog_ServiceAgreement_CantractService','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__Equiements_Catalog_ServiceAgreement_ContractSale','FK_Catalog_Equipment__Equipments_Catalog_ServiceAgreement_ContractSale','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__Equiements_Enum_StatusEquipment_StatusEquiement','FK_Catalog_Equipment__Equipments_Enum_StatusEquipment_StatusEquipment','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment_Equiements_Catalog_Equipment_EntityId','FK_Catalog_Equipment_Equipments_Catalog_Equipment_EntityId','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--indexes
sp_rename 'Catalog.Equipment_Equipments.UQ_Catalog_Equipment_Equiements_Key','UQ_Catalog_Equipment_Equipments_Key','INDEX';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO


--table
sp_rename 'Catalog.Equipment_EquiementsHistory', 'Equipment_EquipmentsHistory';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--fields
sp_rename 'Catalog.Equipment_EquipmentsHistory.Equiements', 'Equipments', 'COLUMN';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--keys
sp_rename 'Catalog.PK_Catalog_Equipment_EquiementsHistory','PK_Catalog_Equipment_EquipmentsHistory','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__EquiementsHistory_Catalog_Client_Client','FK_Catalog_Equipment__EquipmentsHistory_Catalog_Client_Client','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__EquiementsHistory_Catalog_Equipment_Equiements','FK_Catalog_Equipment__EquipmentsHistory_Catalog_Equipment_Equipments','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__EquiementsHistory_Catalog_User_Executor','FK_Catalog_Equipment__EquipmentsHistory_Catalog_User_Executor','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment__EquiementsHistory_Enum_ResultEvent_Result','FK_Catalog_Equipment__EquipmentsHistory_Enum_ResultEvent_Result','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_rename 'Catalog.FK_Catalog_Equipment_EquiementsHistory_Catalog_Equipment_EntityId','FK_Catalog_Equipment_EquipmentsHistory_Catalog_Equipment_EntityId','OBJECT';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--indexes
sp_rename 'Catalog.Equipment_EquipmentsHistory.UQ_Catalog_Equipment_EquiementsHistory_Key','UQ_Catalog_Equipment_EquipmentsHistory_Key','INDEX';
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Update DeletionMark field'
GO

DECLARE @colName NVARCHAR(50) = 'DeletionMark';
DECLARE @script_update NVARCHAR(MAX);
DECLARE @script_alter NVARCHAR(MAX);
DECLARE @tableName NVARCHAR(MAX);

DECLARE cursor_name CURSOR FAST_FORWARD READ_ONLY FOR
SELECT 
    'UPDATE ['+ z.schemaName +'].[' + z.tableName + ']
          SET [' + @colName + '] = 0
          WHERE [' + @colName + '] IS null' AS scriptUpdate,
	'ALTER TABLE [' + z.schemaName + '].[' + z.tableName + ']
       ALTER COLUMN ' + @colName + ' BIT NOT NULL' AS scriptAlter,
	z.tableName AS tableName
FROM (
       SELECT 
	        t.name AS tableName,
			SCHEMA_NAME(SCHEMA_ID) AS schemaName
		FROM
		    sys.tables AS t 
			    INNER JOIN sys.columns AS c
				ON t.object_id = c.object_id
				where c.name = @colName
	 ) AS z
OPEN cursor_name
FETCH NEXT FROM cursor_name INTO @script_update, @script_alter, @tableName

WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT 'FOR ' + @tableName;
  EXEC(@script_update);
  EXEC(@script_alter);

  FETCH NEXT FROM cursor_name INTO @script_update, @script_alter, @tableName
END

CLOSE cursor_name  		
DEALLOCATE cursor_name	

IF @@ERROR <> 0 SET NOEXEC ON
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[Document].[Task_Status]') 
         AND name = 'CloseEvent'
)
BEGIN
  ALTER TABLE [Document].[Task_Status] ADD
  [CloseEvent] uniqueidentifier NULL
END
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

sp_msForEachTable 
  @command1='IF NOT EXISTS (
    SELECT * 
    FROM   sys.columns 
    WHERE  object_id = OBJECT_ID(''?'') 
          AND name = N''KeyFieldTimestamp''
    )
    BEGIN
      ALTER TABLE ? ADD [KeyFieldTimestamp] bigint NULL
    END',
  @whereand=N'AND SCHEMA_NAME([schema_id])+N''.''+PARSENAME(o.[name], 1) 
    IN (SELECT [SyncTable] FROM [admin].[SyncConfiguration])'

IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Set DBVersion = 3.1.3.0'

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.3.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.3.0');
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

