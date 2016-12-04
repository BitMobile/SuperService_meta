--
-- DO NOT START SCRIPT FOR INCORRECT VERSION
-- 


IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.3.1' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.4.0' )

  RETURN

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

--
-- INSERT ALL MODIFICATIONS HERE 
--



--
-- BEGIN DATABASE VERSION SETUP 
--


PRINT N'Creating [Enum].[Webactions]'
GO
CREATE TABLE [Enum].[Webactions] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[Name] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
)
GO
PRINT N'Insert into [Enum].[Webactions]'
GO
DECLARE @ts_date datetime2 = getdate()
DECLARE @ticksPerDay bigint = 864000000000
DECLARE @ts_date2 datetime2 = @ts_date
DECLARE @ts_dateBinary binary(9) = cast(reverse(cast(@ts_date2 as binary(9))) as binary(9))
DECLARE @days bigint = cast(substring(@ts_dateBinary, 1, 3) as bigint)
DECLARE @ts_time bigint = cast(substring(@ts_dateBinary, 4, 5) as bigint)
DECLARE @ts_stamp bigint = @days * @ticksPerDay + @ts_time

INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-490b-9152-86b037e79a79','EventsEditing',					'Создание и редактирование нарядов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-489b-9152-86b037e79a79','EventsDeleting',					'Удаление нарядов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-491b-9152-86b037e79a79','EventsOptionsEditing',			'Управление параметрами нарядов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-492b-9152-86b037e79a79','EventsAllAvaliable',				'Разрешить доступ ко всем нарядам (иначе только к назначенным)')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-494b-9152-86b037e79a79','EventsShowAVR',					'Отображать АВР в нарядах')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-495b-9152-86b037e79a79','UsersEditing',					'Редактирование сотрудников')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-496b-9152-86b037e79a79','UsersDeleting',					'Удаление сотрудников')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-497b-9152-86b037e79a79','UsersManageRoles',				'Управление ролями сотрудников')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-498b-9152-86b037e79a79','ClientsEditing',					'Создание и редактирование клиентов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-499b-9152-86b037e79a79','ClientsDeleting',				'Удаление клиентов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-500b-9152-86b037e79a79','ClientsOptionsEditing',			'Управление параметрами клиентов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-501b-9152-86b037e79a79','TasksEditing',					'Редактирование задач')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-502b-9152-86b037e79a79','EquipmentsEditing',				'Создание и редактирование оборудования')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-503b-9152-86b037e79a79','EquipmentsDeleting',				'Удаление оборудования')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-504b-9152-86b037e79a79','EquipmentsOptionsEditing',		'Управление параметрами оборудования')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-505b-9152-86b037e79a79','RIMEditing',						'Создание и редактирование услуг и материалов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-506b-9152-86b037e79a79','RIMDeleting',					'Удаление услуг и материалов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-507b-9152-86b037e79a79','CheckListsEditing',				'Создание и редактирование чек-листов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-508b-9152-86b037e79a79','CheckListManageActivityStatus',	'Управление активностью чек-листов')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-509b-9152-86b037e79a79','AnaliticAccess',					'Доступ к аналитике')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-510b-9152-86b037e79a79','WebInterfaceAccess',				'Доступ к веб-приложению')
INSERT INTO [Enum].[Webactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,Name,[Description]) VALUES(@ts_stamp,0,NULL,'0236eb9f-eed9-511b-9152-86b037e79a79','MobileAppAccess',				'Доступ к мобильному веб-приложению')


IF @@ERROR <> 0 SET NOEXEC ON
GO
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Enum_Webactions] on [Enum].[Webactions]'
GO
ALTER TABLE [Enum].[Webactions] ADD CONSTRAINT [PK_Enum_Webactions] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Enum].[Webactions_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Enum].[Webactions]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Name],				[Description]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Name,				@Description			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_update]'
GO
 
CREATE PROCEDURE [Enum].[Webactions_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	UPDATE [Enum].[Webactions] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id AND 
	( 1=0 OR [Name] <> @Name OR ([Name] IS NULL AND NOT @Name IS NULL) OR (NOT [Name] IS NULL AND @Name IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_markdelete]'
GO
 
CREATE PROCEDURE [Enum].[Webactions_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Enum].[Webactions] WHERE Id = @Id) 
	UPDATE [Enum].[Webactions] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Enum].[Webactions] 
	( 
				[Id],				[Name],				[Description]			) 
	VALUES 
	( 
				@Id,				@Name,				@Description			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Enum.Webactions',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_delete]'
GO
 
CREATE PROCEDURE [Enum].[Webactions_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Enum].[Webactions] WHERE Id = @Id 
	UPDATE [Enum].[Webactions_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_exists]'
GO
 
CREATE PROCEDURE [Enum].[Webactions_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Enum].[Webactions] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Enum].[Webactions_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Enum.Webactions' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Enum].[Webactions] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles]'
GO
CREATE TABLE [Catalog].[Roles] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[DeletionMark] [bit] NOT NULL, 
[Name] [nvarchar] (9) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Ident] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[CanManageSelf] [bit] NOT NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Insert into [Catalog].[Roles]'
GO
DECLARE @ts_date datetime2 = getdate()
DECLARE @ticksPerDay bigint = 864000000000
DECLARE @ts_date2 datetime2 = @ts_date
DECLARE @ts_dateBinary binary(9) = cast(reverse(cast(@ts_date2 as binary(9))) as binary(9))
DECLARE @days bigint = cast(substring(@ts_dateBinary, 1, 3) as bigint)
DECLARE @ts_time bigint = cast(substring(@ts_dateBinary, 4, 5) as bigint)
DECLARE @ts_stamp bigint = @days * @ticksPerDay + @ts_time

INSERT INTO [Catalog].[Roles]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,DeletionMark,Name,Ident,[Description],CanManageSelf) VALUES(@ts_stamp,0,NULL,'680efa97-b038-46b4-bed0-d652a82e914d',0,'Admin','Admin','Administrator',0)
INSERT INTO [Catalog].[Roles]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,DeletionMark,Name,Ident,[Description],CanManageSelf) VALUES(@ts_stamp,0,NULL,'452a8e4d-4ad9-4a1c-abac-0c916cfabcfb',0,'SRM','SRM','SRM',0)
INSERT INTO [Catalog].[Roles]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,DeletionMark,Name,Ident,[Description],CanManageSelf) VALUES(@ts_stamp,0,NULL,'679dc4bb-7d76-427c-abfa-d2e53996ef48',0,'SR','SR','SR',0)

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Roles] on [Catalog].[Roles]'
GO
ALTER TABLE [Catalog].[Roles] ADD CONSTRAINT [PK_Catalog_Roles] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Catalog].[Roles_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Name NVARCHAR(9),		@Ident NVARCHAR(50),		@Description NVARCHAR(100),		@CanManageSelf BIT	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Roles]( 
		[Timestamp], [IsDeleted], 
				[Id],				[DeletionMark],				[Name],				[Ident],				[Description],				[CanManageSelf]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@DeletionMark,				@Name,				@Ident,				@Description,				@CanManageSelf			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_update]'
GO
 
CREATE PROCEDURE [Catalog].[Roles_adm_update] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Name NVARCHAR(9),		@Ident NVARCHAR(50),		@Description NVARCHAR(100),		@CanManageSelf BIT	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Roles] SET 
				[Id] = @Id,				[DeletionMark] = @DeletionMark,				[Name] = @Name,				[Ident] = @Ident,				[Description] = @Description,				[CanManageSelf] = @CanManageSelf			WHERE Id = @Id AND 
	( 1=0 OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Name] <> @Name OR ([Name] IS NULL AND NOT @Name IS NULL) OR (NOT [Name] IS NULL AND @Name IS NULL)  OR [Ident] <> @Ident OR ([Ident] IS NULL AND NOT @Ident IS NULL) OR (NOT [Ident] IS NULL AND @Ident IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [CanManageSelf] <> @CanManageSelf OR ([CanManageSelf] IS NULL AND NOT @CanManageSelf IS NULL) OR (NOT [CanManageSelf] IS NULL AND @CanManageSelf IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_markdelete]'
GO
 
CREATE PROCEDURE [Catalog].[Roles_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Name NVARCHAR(9),		@Ident NVARCHAR(50),		@Description NVARCHAR(100),		@CanManageSelf BIT	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Roles] WHERE Id = @Id) 
	UPDATE [Catalog].[Roles] SET 
				[Id] = @Id,				[DeletionMark] = @DeletionMark,				[Name] = @Name,				[Ident] = @Ident,				[Description] = @Description,				[CanManageSelf] = @CanManageSelf			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[Roles] 
	( 
				[Id],				[DeletionMark],				[Name],				[Ident],				[Description],				[CanManageSelf]			) 
	VALUES 
	( 
				@Id,				@DeletionMark,				@Name,				@Ident,				@Description,				@CanManageSelf			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.Roles',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_delete]'
GO
 
CREATE PROCEDURE [Catalog].[Roles_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Catalog].[Roles] WHERE Id = @Id 
	UPDATE [Catalog].[Roles_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_exists]'
GO
 
CREATE PROCEDURE [Catalog].[Roles_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Catalog].[Roles] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Catalog].[Roles_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Catalog.Roles' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Catalog].[Roles] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ADD 
[Language] [nvarchar] (5) COLLATE Cyrillic_General_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ADD [RoleNew] [uniqueidentifier] NOT NULL 
DEFAULT cast(cast(0 as binary) as uniqueidentifier) WITH VALUES 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'New Colum RoleNew In [Catalog].[User]'
GO
UPDATE [Catalog].[User] SET [RoleNew] = CASE WHEN [Role] ='SR' 
	THEN '679dc4bb-7d76-427c-abfa-d2e53996ef48' ELSE 
		CASE WHEN [Role] ='Admin' THEN '680efa97-b038-46b4-bed0-d652a82e914d' ELSE
		 CASE WHEN [Role] = 'SRM' THEN '452a8e4d-4ad9-4a1c-abac-0c916cfabcfb'
		 ELSE '679dc4bb-7d76-427c-abfa-d2e53996ef48'
		  END END END 
GO
PRINT N'DropColum Role'
GO
ALTER TABLE [Catalog].[User] DROP COLUMN [Role]
GO
PRINT N'Rename Colum RoleNew to Role'
GO
SP_RENAME 'Catalog.User.RoleNew', 'Role', 'COLUMN';
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [Role] [uniqueidentifier] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[User_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role UNIQUEIDENTIFIER,		@Language NVARCHAR(5),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[User]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[UserName],				[Password],				[UserDB],				[EMail],				[UserID],				[Phone],				[Role],				[Language],				[AspNetUserID]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@UserName,				@Password,				@UserDB,				@EMail,				@UserID,				@Phone,				@Role,				@Language,				@AspNetUserID			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[User_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role UNIQUEIDENTIFIER,		@Language NVARCHAR(5),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[User] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[UserName] = @UserName,				[Password] = @Password,				[UserDB] = @UserDB,				[EMail] = @EMail,				[UserID] = @UserID,				[Phone] = @Phone,				[Role] = @Role,				[Language] = @Language,				[AspNetUserID] = @AspNetUserID			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [UserName] <> @UserName OR ([UserName] IS NULL AND NOT @UserName IS NULL) OR (NOT [UserName] IS NULL AND @UserName IS NULL)  OR [Password] <> @Password OR ([Password] IS NULL AND NOT @Password IS NULL) OR (NOT [Password] IS NULL AND @Password IS NULL)  OR [UserDB] <> @UserDB OR ([UserDB] IS NULL AND NOT @UserDB IS NULL) OR (NOT [UserDB] IS NULL AND @UserDB IS NULL)  OR [EMail] <> @EMail OR ([EMail] IS NULL AND NOT @EMail IS NULL) OR (NOT [EMail] IS NULL AND @EMail IS NULL)  OR [UserID] <> @UserID OR ([UserID] IS NULL AND NOT @UserID IS NULL) OR (NOT [UserID] IS NULL AND @UserID IS NULL)  OR [Phone] <> @Phone OR ([Phone] IS NULL AND NOT @Phone IS NULL) OR (NOT [Phone] IS NULL AND @Phone IS NULL)  OR [Role] <> @Role OR ([Role] IS NULL AND NOT @Role IS NULL) OR (NOT [Role] IS NULL AND @Role IS NULL)  OR [Language] <> @Language OR ([Language] IS NULL AND NOT @Language IS NULL) OR (NOT [Language] IS NULL AND @Language IS NULL)  OR [AspNetUserID] <> @AspNetUserID OR ([AspNetUserID] IS NULL AND NOT @AspNetUserID IS NULL) OR (NOT [AspNetUserID] IS NULL AND @AspNetUserID IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[User_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role UNIQUEIDENTIFIER,		@Language NVARCHAR(5),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[User] WHERE Id = @Id) 
	UPDATE [Catalog].[User] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[UserName] = @UserName,				[Password] = @Password,				[UserDB] = @UserDB,				[EMail] = @EMail,				[UserID] = @UserID,				[Phone] = @Phone,				[Role] = @Role,				[Language] = @Language,				[AspNetUserID] = @AspNetUserID			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[User] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[UserName],				[Password],				[UserDB],				[EMail],				[UserID],				[Phone],				[Role],				[Language],				[AspNetUserID]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@UserName,				@Password,				@UserDB,				@EMail,				@UserID,				@Phone,				@Role,				@Language,				@AspNetUserID			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.User',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Roles_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Catalog].[Roles_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Catalog].[Roles] E 
	JOIN [Catalog].[Roles_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Catalog.Roles' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Name],NULL AS [Row!2!Ident],NULL AS [Row!2!Description],NULL AS [Row!2!CanManageSelf]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[DeletionMark] AS [Row!2!DeletionMark],H.[Name] AS [Row!2!Name],H.[Ident] AS [Row!2!Ident],H.[Description] AS [Row!2!Description],H.[CanManageSelf] AS [Row!2!CanManageSelf]							FROM [Catalog].[Roles] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_getchanges]'
GO
 
 
ALTER PROCEDURE [Catalog].[User_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Catalog].[User] E 
	JOIN [Catalog].[User_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[User_Bag] E 
	JOIN [Catalog].[User_Bag_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[User_RemainsNorms] E 
	JOIN [Catalog].[User_RemainsNorms_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Catalog.User' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!UserName],NULL AS [Row!2!Password],NULL AS [Row!2!UserDB],NULL AS [Row!2!EMail],NULL AS [Row!2!UserID],NULL AS [Row!2!Phone],NULL AS [Row!2!Role],NULL AS [Row!2!Language],NULL AS [Row!2!AspNetUserID]						,NULL AS [Bag!11] 
						,NULL AS [RemainsNorms!21] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Materials] 
					,NULL AS [Row!12!Count] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Materials] 
					,NULL AS [Row!22!Count] 
			 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Predefined] AS [Row!2!Predefined],H.[DeletionMark] AS [Row!2!DeletionMark],H.[Description] AS [Row!2!Description],H.[Code] AS [Row!2!Code],H.[UserName] AS [Row!2!UserName],H.[Password] AS [Row!2!Password],H.[UserDB] AS [Row!2!UserDB],H.[EMail] AS [Row!2!EMail],H.[UserID] AS [Row!2!UserID],H.[Phone] AS [Row!2!Phone],H.[Role] AS [Row!2!Role],H.[Language] AS [Row!2!Language],H.[AspNetUserID] AS [Row!2!AspNetUserID]						,NULL AS [Bag!11] 
						,NULL AS [RemainsNorms!21] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Materials] 
					,NULL AS [Row!12!Count] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Materials] 
					,NULL AS [Row!22!Count] 
				FROM [Catalog].[User] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
			 
	UNION ALL 
 
	SELECT 
	11 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!UserName],NULL AS [Row!2!Password],NULL AS [Row!2!UserDB],NULL AS [Row!2!EMail],NULL AS [Row!2!UserID],NULL AS [Row!2!Phone],NULL AS [Row!2!Role],NULL AS [Row!2!Language],NULL AS [Row!2!AspNetUserID]			,NULL AS [Bag!11] 
				,NULL AS [RemainsNorms!11] 
										,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Materials] 
					,NULL AS [Row!12!Count] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Materials] 
					,NULL AS [Row!12!Count] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	12 AS Tag, 11 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!UserName],NULL AS [Row!2!Password],NULL AS [Row!2!UserDB],NULL AS [Row!2!EMail],NULL AS [Row!2!UserID],NULL AS [Row!2!Phone],NULL AS [Row!2!Role],NULL AS [Row!2!Language],NULL AS [Row!2!AspNetUserID]			,NULL AS [Bag!11] 
				,NULL AS [RemainsNorms!11] 
										 ,T.[Id] AS [Row!12!Id]								 ,T.[Ref] AS [Row!12!Ref]								 ,T.[LineNumber] AS [Row!12!LineNumber]								 ,T.[Materials] AS [Row!12!Materials]								 ,T.[Count] AS [Row!12!Count]															 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Materials]								 ,NULL AS [Row!12!Count]				FROM @Ids Ids 
	JOIN [Catalog].[User_Bag] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	21 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!UserName],NULL AS [Row!2!Password],NULL AS [Row!2!UserDB],NULL AS [Row!2!EMail],NULL AS [Row!2!UserID],NULL AS [Row!2!Phone],NULL AS [Row!2!Role],NULL AS [Row!2!Language],NULL AS [Row!2!AspNetUserID]			,NULL AS [Bag!21] 
				,NULL AS [RemainsNorms!21] 
										,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Materials] 
					,NULL AS [Row!22!Count] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Materials] 
					,NULL AS [Row!22!Count] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	22 AS Tag, 21 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!UserName],NULL AS [Row!2!Password],NULL AS [Row!2!UserDB],NULL AS [Row!2!EMail],NULL AS [Row!2!UserID],NULL AS [Row!2!Phone],NULL AS [Row!2!Role],NULL AS [Row!2!Language],NULL AS [Row!2!AspNetUserID]			,NULL AS [Bag!21] 
				,NULL AS [RemainsNorms!21] 
													 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Materials]								 ,NULL AS [Row!22!Count]									 ,T.[Id] AS [Row!22!Id]								 ,T.[Ref] AS [Row!22!Ref]								 ,T.[LineNumber] AS [Row!22!LineNumber]								 ,T.[Materials] AS [Row!22!Materials]								 ,T.[Count] AS [Row!22!Count]							FROM @Ids Ids 
	JOIN [Catalog].[User_RemainsNorms] T ON T.Ref = Ids.Id 
 
	 
	ORDER BY [Row!2!Id], Tag ,[Row!12!LineNumber],[Row!22!LineNumber] 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions]'
GO
CREATE TABLE [Catalog].[RoleWebactions] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[Role] [uniqueidentifier] NOT NULL, 
[Webaction] [uniqueidentifier] NOT NULL 
)
GO
PRINT N'Insert into [Catalog].[RoleWebactions]'
GO
DECLARE @ts_date datetime2 = getdate()
DECLARE @ticksPerDay bigint = 864000000000
DECLARE @ts_date2 datetime2 = @ts_date
DECLARE @ts_dateBinary binary(9) = cast(reverse(cast(@ts_date2 as binary(9))) as binary(9))
DECLARE @days bigint = cast(substring(@ts_dateBinary, 1, 3) as bigint)
DECLARE @ts_time bigint = cast(substring(@ts_dateBinary, 4, 5) as bigint)
DECLARE @ts_stamp bigint = @days * @ticksPerDay + @ts_time

INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'3929ba7a-53e8-4845-9514-8db9c2a18525','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-489b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'0a06a3b7-64a8-48dd-b7e0-87490b7ee080','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-490b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'0fdbb04a-20af-46f0-95b5-af16f08e2e48','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-491b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'d3ef9a98-ad3f-4e14-91dd-fc85a1731ad0','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-492b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'55a6e5ac-b211-4869-911f-e70540ffc7d8','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-494b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'224212fb-9136-4c11-9005-b9c91dbff797','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-495b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'1becab3c-d81f-4cab-9520-81deec108d3c','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-496b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'3a255f28-178d-47d9-9460-a121bde54989','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-497b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'6879f766-d8d7-4621-a40d-61da906fdfb8','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-498b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'f85baac7-0a90-4704-957e-bdc238bef8eb','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-499b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'f27ec6e0-cc42-4cb6-8482-8c15366d1c7d','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-500b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'43ec0da6-9f75-40ba-ba30-f05d2c325410','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-501b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'5a8fd8d9-3478-4de7-b316-ea41514b2e23','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-502b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'b6a2f9b7-dcf0-47fe-a2b2-e1ddca3b8cf8','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-503b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'e9246e63-c9ac-43a8-b1c4-a97b3fd79cb1','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-504b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'2b2487d7-1326-4f5c-85c3-089c599c4f72','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-505b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'99b217e3-1f53-4539-ad1a-67f5f36829ce','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-506b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'4a44518e-9934-4052-a81c-7a0b815962d3','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-507b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'51c34669-1797-437b-992b-9b3be9baf8cf','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-508b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'d43a4271-c47f-445c-ad9b-016fd34dfe44','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-509b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'36503f36-91f9-4b18-ae29-7135e1c49bdf','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-510b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'53e652b4-4483-4120-9abe-6ef0d9bad182','680efa97-b038-46b4-bed0-d652a82e914d','0236eb9f-eed9-511b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'0de8c83b-f805-4c10-86a2-9ac838809523','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-489b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'5be66e89-7286-4dd2-9bd7-bdfa84b5cc89','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-490b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'f926b8a4-49e5-4c42-80fc-d733f64e988b','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-491b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'6ec4543e-72b2-4426-a26f-30765c5a24d3','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-492b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'42bd22ed-7095-44e7-9206-f741d7954aaa','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-494b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'e08f59eb-e728-4079-9f5b-76205174a1e2','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-495b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'065fa351-fba4-4dce-bac1-c168ae7f94d9','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-496b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'d6e2315c-a166-4cdc-9911-5e76e26df6f0','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-497b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'496e89cb-e969-4206-a6ec-391d2823c8d3','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-498b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'24a4149e-4aa1-4cc0-a204-bb1707b53feb','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-499b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'54952807-eb03-42ef-82b8-9b8d48137b95','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-500b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'e6b828fb-15dd-4422-a9b2-3b5a315c72f7','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-501b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'e7061b87-304a-4ef7-8e40-36014dc70abb','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-502b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'5d47f12a-8f1a-47ed-91b0-469719d60d0d','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-503b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'25a5c9cd-b930-4b1b-a9b9-57f8c095f9ee','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-504b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'651ce4df-2994-4b7f-92f9-f3fce9022e5c','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-505b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'ca5f7cd4-58c5-45c1-97d1-2d15e3e1c2c2','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-506b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'9b0321bf-af47-4465-8953-44b93b1597e9','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-507b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'4da194ef-0d61-4c2b-9e49-e0bada4d8e49','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-508b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'6c227e58-3dce-4f89-86b9-3e31eda8bc1e','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-509b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'05d584f7-ecaa-46c1-88eb-6a82fe238848','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-510b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'281bf901-b914-417e-ade7-1ac84baa06f7','452a8e4d-4ad9-4a1c-abac-0c916cfabcfb','0236eb9f-eed9-511b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'75d7733f-8f17-4449-b400-e60f4ba8ca34','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-489b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'b91d7dd3-7062-4e93-987d-3383025f042f','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-490b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'25202a16-ec82-4d1e-a830-01eeaac27eb2','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-491b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'41d5eb02-60d7-4f63-93ee-b8ffce5696e2','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-492b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'8d4139f7-124e-486a-b722-9ea09418fbf6','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-494b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'e171d2bb-29ab-4e08-b905-878371682997','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-495b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'9fe85e9d-69b6-4cad-a8c2-5fe6cb53610c','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-496b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'7f2c4548-ea5b-4c75-badb-e1369d1e665f','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-497b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'04966ee3-fded-47a7-a588-e4526880ea43','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-498b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'c9e93c33-d543-4778-867f-1ee1a7f21c85','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-499b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'04a45197-1a23-4d01-8a86-c2bc207cee0b','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-500b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'8cc77251-fe52-4032-a701-b1961ed5fece','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-501b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'6a945d55-9407-433c-9e06-b25d5308119e','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-502b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'d69a4af4-9b37-4b35-9c21-807ab3da7227','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-503b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'25be9a90-da86-49d7-b86f-1850217d52ff','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-504b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'1680f7e6-5652-44d9-b7f6-fe494d1fc625','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-505b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'41d775d0-59b4-4fbe-863a-bf3b2a252521','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-506b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'c96b7158-2e6c-497d-9a1b-af3d263a6b27','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-507b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'96753b4a-d1d4-4a36-a8ee-75a224997f89','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-508b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'b223de25-c632-40fd-b451-d5ddab7f789d','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-509b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'f4678755-2658-4210-b28b-f89d50525d14','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-510b-9152-86b037e79a79')
INSERT INTO [Catalog].[RoleWebactions]([Timestamp],IsDeleted,KeyFieldTimestamp,Id,[Role],Webaction) VALUES(@ts_stamp,0,NULL,'9eec7f13-dd70-43de-b86c-bbcfdec57992','679dc4bb-7d76-427c-abfa-d2e53996ef48','0236eb9f-eed9-511b-9152-86b037e79a79')


IF @@ERROR <> 0 SET NOEXEC ON
GO
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_RoleWebactions] on [Catalog].[RoleWebactions]'
GO
ALTER TABLE [Catalog].[RoleWebactions] ADD CONSTRAINT [PK_Catalog_RoleWebactions] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Catalog].[RoleWebactions] E 
	JOIN [Catalog].[RoleWebactions_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Catalog.RoleWebactions' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Role],NULL AS [Row!2!Webaction]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Role] AS [Row!2!Role],H.[Webaction] AS [Row!2!Webaction]							FROM [Catalog].[RoleWebactions] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Role UNIQUEIDENTIFIER,		@Webaction UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[RoleWebactions]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Role],				[Webaction]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Role,				@Webaction			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_update]'
GO
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Role UNIQUEIDENTIFIER,		@Webaction UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[RoleWebactions] SET 
				[Id] = @Id,				[Role] = @Role,				[Webaction] = @Webaction			WHERE Id = @Id AND 
	( 1=0 OR [Role] <> @Role OR ([Role] IS NULL AND NOT @Role IS NULL) OR (NOT [Role] IS NULL AND @Role IS NULL)  OR [Webaction] <> @Webaction OR ([Webaction] IS NULL AND NOT @Webaction IS NULL) OR (NOT [Webaction] IS NULL AND @Webaction IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_markdelete]'
GO
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Role UNIQUEIDENTIFIER,		@Webaction UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[RoleWebactions] WHERE Id = @Id) 
	UPDATE [Catalog].[RoleWebactions] SET 
				[Id] = @Id,				[Role] = @Role,				[Webaction] = @Webaction			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[RoleWebactions] 
	( 
				[Id],				[Role],				[Webaction]			) 
	VALUES 
	( 
				@Id,				@Role,				@Webaction			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.RoleWebactions',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_delete]'
GO
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Catalog].[RoleWebactions] WHERE Id = @Id 
	UPDATE [Catalog].[RoleWebactions_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_exists]'
GO
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Catalog].[RoleWebactions] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[Webactions_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Enum].[Webactions_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Enum].[Webactions] E 
	JOIN [Enum].[Webactions_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Enum.Webactions' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Name],NULL AS [Row!2!Description]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Name] AS [Row!2!Name],H.[Description] AS [Row!2!Description]							FROM [Enum].[Webactions] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[RoleWebactions_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Catalog].[RoleWebactions_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Catalog.RoleWebactions' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Catalog].[RoleWebactions] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[RoleWebactions]'
GO
ALTER TABLE [Catalog].[RoleWebactions] ADD CONSTRAINT [FK_Catalog_RoleWebactions_Catalog_Roles_Role] FOREIGN KEY ([Role]) REFERENCES [Catalog].[Roles] ([Id]) 
GO
ALTER TABLE [Catalog].[RoleWebactions] ADD CONSTRAINT [FK_Catalog_RoleWebactions_Enum_Webactions_Webaction] FOREIGN KEY ([Webaction]) REFERENCES [Enum].[Webactions] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[User]'
GO
ALTER TABLE [Catalog].[User] ADD CONSTRAINT [FK_Catalog_User_Catalog_Roles_Role] FOREIGN KEY ([Role]) REFERENCES [Catalog].[Roles] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

NSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
     VALUES
           ('bitmobileURL'
           ,'');
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
     VALUES
           ('bitmobileLogin'
           ,'');
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
     VALUES
           ('bitmobilePass'
           ,'');
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Set DBVersion = 3.1.4.0'

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.4.0'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.4.0');
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
