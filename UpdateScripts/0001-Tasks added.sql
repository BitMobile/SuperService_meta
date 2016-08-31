/*

	Updates SuperService database for using Task module

*/

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


PRINT N'Creating elements in [Enum].[StatusTasks]'

declare @dtBinary binary(9) = CAST(REVERSE(CONVERT(binary(9), CURRENT_TIMESTAMP)) as binary(9));
declare @dtDateBytes binary(3) = SUBSTRING(@dtBinary, 1, 3);
declare @dtTimeBytes binary(5) = SUBSTRING(@dtBinary, 4, 5);
declare @dtPrecisionByte binary(1) = SUBSTRING(@dtBinary, 9, 1);

declare @ts bigint = (CONVERT(bigint, @dtDateBytes) * 864000000000) + CONVERT(bigint, @dtTimeBytes);

INSERT INTO [Enum].[StatusTasks]
           ([Id]
           ,[Timestamp]
           ,[IsDeleted]
           ,[Name]
           ,[Description])
     VALUES
           ('a0a9e67f-483e-419a-a714-859f13c1245c'
           ,@ts
           ,0
           ,'New'
           ,'Новая');

INSERT INTO [Enum].[StatusTasks]
           ([Id]
           ,[Timestamp]
           ,[IsDeleted]
           ,[Name]
           ,[Description])
     VALUES
           ('a0a9e67f-483e-423a-a714-859f13c1245c'
           ,@ts
           ,0
           ,'Done'
           ,'Выполнена');

INSERT INTO [Enum].[StatusTasks]
           ([Id]
           ,[Timestamp]
           ,[IsDeleted]
           ,[Name]
           ,[Description])
     VALUES
           ('a0a9e67f-483e-426b-a714-859f13c1245c'
           ,@ts
           ,0
           ,'Rejected'
           ,'Отклонена');

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
	[Client] [uniqueidentifier] NOT NULL,
	[Equipment] [uniqueidentifier] NULL,
	[Event] [uniqueidentifier] NULL,
	CONSTRAINT [PK_Document_Task] PRIMARY KEY NONCLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO

ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Catalog_Client_Client] FOREIGN KEY([Client])
REFERENCES [Catalog].[Client] ([Id])
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Catalog_Client_Client]
GO

ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Catalog_Equipment_Equipment] FOREIGN KEY([Equipment])
REFERENCES [Catalog].[Equipment] ([Id])
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Catalog_Equipment_Equipment]
GO


ALTER TABLE [Document].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Document_Event_Event] FOREIGN KEY([Event])
REFERENCES [Document].[Event] ([Id])
GO

ALTER TABLE [Document].[Task] CHECK CONSTRAINT [FK_Document_Task_Document_Event_Event]
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

ALTER TABLE [Document].[Task_Targets]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Targets_Document_Task_EntityId] FOREIGN KEY([Ref])
REFERENCES [Document].[Task] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Document].[Task_Targets] CHECK CONSTRAINT [FK_Document_Task_Targets_Document_Task_EntityId]
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

ALTER TABLE [Document].[Task_Status] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Document_Task_EntityId] FOREIGN KEY([Ref])
REFERENCES [Document].[Task] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Document_Task_EntityId]
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Catalog_User_UserMA] FOREIGN KEY([UserMA])
REFERENCES [Catalog].[User] ([Id])
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Catalog_User_UserMA]
GO

ALTER TABLE [Document].[Task_Status]  WITH CHECK ADD  CONSTRAINT [FK_Document_Task_Status_Enum_StatusTasks_Status] FOREIGN KEY([Status])
REFERENCES [Enum].[StatusTasks] ([Id])
GO

ALTER TABLE [Document].[Task_Status] CHECK CONSTRAINT [FK_Document_Task_Status_Enum_StatusTasks_Status]
GO


PRINT N'Inserting data into [admin].[SyncConfiguration]'

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder])
     VALUES
           ('Document.Task'
           ,''
           ,41)

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder])
     VALUES
           ('Document.Tasks_Targets'
           ,''
           ,42)

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder])
     VALUES
           ('Document.Tasks_Status'
           ,''
           ,43)

INSERT INTO [admin].[SyncConfiguration]
           ([SyncTable]
           ,[SyncFilter]
           ,[SyncOrder])
     VALUES
           ('Enum.StatusTasks'
           ,''
           ,51)
GO


COMMIT TRANSACTION
GO

PRINT 'Finished.'