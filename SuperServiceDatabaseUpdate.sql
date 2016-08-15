/*

	Updates SuperService database for using with SuSeWebAdmin

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TokenCache]'
GO
CREATE TABLE [dbo].[TokenCache]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[UserName] [nvarchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Token] [varchar] (500) COLLATE Cyrillic_General_CI_AS NOT NULL,
[IssuedDate] [datetime2] NOT NULL CONSTRAINT [DF_TokenCache_CreationDate] DEFAULT (getdate()),
[ExpiresDate] [datetime2] NOT NULL CONSTRAINT [DF_TokenCache_ExpirationDate] DEFAULT (dateadd(day,(1),getdate())),
[ExpireTimespan] [bigint] NOT NULL,
[LocalIp] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL,
[RemoteIp] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL,
[LastRequestDate] [datetime2] NULL,
[IsLoggedout] [bit] NOT NULL CONSTRAINT [DF_TokenCache_IsLoggedout] DEFAULT ((0)),
[IsExpired] AS (case when [ExpiresDate]<getdate() then (1) else (0) end)
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TokenCache] on [dbo].[TokenCache]'
GO
ALTER TABLE [dbo].[TokenCache] ADD CONSTRAINT [PK_TokenCache] PRIMARY KEY CLUSTERED  ([Token])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TokenUpdateExpiration]'
GO

CREATE PROCEDURE [dbo].[TokenUpdateExpiration]
(
	@token	VARCHAR(500),
	@currentDate DATETIME2
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE	tc
	SET		tc.LastRequestDate = @currentDate,
			tc.ExpiresDate = DATEADD(ms, tc.ExpireTimespan / 10000, @currentDate)
	FROM	dbo.TokenCache tc
	WHERE	tc.Token = @token AND
			tc.ExpiresDate >= @currentDate AND
			tc.IsLoggedout = 0;

END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TokenCacheAccessHistory]'
GO
CREATE TABLE [dbo].[TokenCacheAccessHistory]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[TokenId] [int] NOT NULL,
[AccessDate] [datetime2] NOT NULL,
[LocalIp] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL,
[RemoteIp] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TokenCacheAccessHistory] on [dbo].[TokenCacheAccessHistory]'
GO
ALTER TABLE [dbo].[TokenCacheAccessHistory] ADD CONSTRAINT [PK_TokenCacheAccessHistory] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserByToken]'
GO

CREATE PROCEDURE [dbo].[UserByToken]
(
	@token VARCHAR(500),
	@currentDate DATETIME2,
	@localIp VARCHAR(100),
	@remoteIp VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @username TABLE(TokenID INT, UserName NVARCHAR(256));

	UPDATE	tc
	SET		tc.LastRequestDate = @currentDate,
			tc.ExpiresDate = DATEADD(ms, tc.ExpireTimespan / 10000, @currentDate)
	OUTPUT	Inserted.ID, Inserted.UserName INTO @username(TokenID, UserName)
	FROM	dbo.TokenCache tc
	WHERE	tc.Token = @token AND
			tc.ExpiresDate >= @currentDate AND
			tc.IsLoggedout = 0;

	INSERT INTO dbo.TokenCacheAccessHistory
			(TokenId,	AccessDate,		LocalIp,	RemoteIp)
	SELECT	TokenId,	@currentDate,	@localIp,	@remoteIp
	FROM	@username;

	SELECT	UserName
	FROM	@username;

END;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TokenAdd]'
GO

CREATE PROCEDURE [dbo].[TokenAdd]
(
	@userName NVARCHAR(256),
	@token VARCHAR(500),
	@issuedDate DATETIME2,
	@expiresDate DATETIME2,
	@expireTimespan BIGINT,
	@localIp VARCHAR(100),
	@remoteIp VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.TokenCache
			(UserName,	Token,	IssuedDate,		ExpiresDate,	ExpireTimespan,		LocalIp,	RemoteIp)
	VALUES	(@userName,	@token,	@issuedDate,	@expiresDate,	@expireTimespan,	@localIp,	@remoteIp)


END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TokenLogout]'
GO

CREATE PROCEDURE [dbo].[TokenLogout]
(
	@token	VARCHAR(500),
	@currentDate DATETIME2
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE	tc
	SET		tc.LastRequestDate = @currentDate,
			tc.IsLoggedout = 1
	FROM	dbo.TokenCache tc
	WHERE	tc.Token = @token AND
			tc.IsLoggedout = 0;

END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetUsers]'
GO
CREATE TABLE [dbo].[AspNetUsers]
(
[Id] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Email] [nvarchar] (256) COLLATE Cyrillic_General_CI_AS NULL,
[EmailConfirmed] [bit] NOT NULL,
[PasswordHash] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[SecurityStamp] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[PhoneNumber] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[PhoneNumberConfirmed] [bit] NOT NULL,
[TwoFactorEnabled] [bit] NOT NULL,
[LockoutEndDateUtc] [datetime] NULL,
[LockoutEnabled] [bit] NOT NULL,
[AccessFailedCount] [int] NOT NULL,
[UserName] [nvarchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL,
[PasswordLastChangeDateUtc] [datetime] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_AspNetUsers] on [dbo].[AspNetUsers]'
GO
ALTER TABLE [dbo].[AspNetUsers] ADD CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[AspNetUsers]'
GO
ALTER TABLE [dbo].[AspNetUsers] ADD CONSTRAINT [CK_AspNetUsers_UserName] UNIQUE NONCLUSTERED  ([UserName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetUserPreferences]'
GO
CREATE TABLE [dbo].[AspNetUserPreferences]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[AspNetUserID] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[PrefKey] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[PrefValue] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_AspNetUserPreferences1] on [dbo].[AspNetUserPreferences]'
GO
ALTER TABLE [dbo].[AspNetUserPreferences] ADD CONSTRAINT [PK_AspNetUserPreferences1] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetRoles]'
GO
CREATE TABLE [dbo].[AspNetRoles]
(
[Id] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Name] [nvarchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbo.AspNetRoles] on [dbo].[AspNetRoles]'
GO
ALTER TABLE [dbo].[AspNetRoles] ADD CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetUserRoles]'
GO
CREATE TABLE [dbo].[AspNetUserRoles]
(
[UserId] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[RoleId] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbo.AspNetUserRoles] on [dbo].[AspNetUserRoles]'
GO
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED  ([UserId], [RoleId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetUserClaims]'
GO
CREATE TABLE [dbo].[AspNetUserClaims]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[UserId] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ClaimType] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[ClaimValue] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbo.AspNetUserClaims] on [dbo].[AspNetUserClaims]'
GO
ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AspNetUserLogins]'
GO
CREATE TABLE [dbo].[AspNetUserLogins]
(
[LoginProvider] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ProviderKey] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL,
[UserId] [nvarchar] (128) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbo.AspNetUserLogins] on [dbo].[AspNetUserLogins]'
GO
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED  ([LoginProvider], [ProviderKey], [UserId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[dbConfig]'
GO
CREATE TABLE [dbo].[dbConfig]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Key] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Value] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbConfig] on [dbo].[dbConfig]'
GO
ALTER TABLE [dbo].[dbConfig] ADD CONSTRAINT [PK_dbConfig] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[dbConfig]'
GO
ALTER TABLE [dbo].[dbConfig] ADD CONSTRAINT [CK_dbConfig_Key] UNIQUE NONCLUSTERED  ([Key])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[AspNetUserRoles]'
GO
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetRoles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id])
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_AspNetUserRoles_AspNetUsers] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[AspNetUserPreferences]'
GO
ALTER TABLE [dbo].[AspNetUserPreferences] ADD CONSTRAINT [FK_AspNetUserPreferences1_AspNetUsers] FOREIGN KEY ([AspNetUserID]) REFERENCES [dbo].[AspNetUsers] ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[TokenCache]'
GO
ALTER TABLE [dbo].[TokenCache] ADD CONSTRAINT [FK_TokenCache_AspNetUsers] FOREIGN KEY ([UserName]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Глобальная конфигурация (базовые параметры)', 'SCHEMA', N'dbo', 'TABLE', N'dbConfig', NULL, NULL
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



--ALTER TABLE Catalog.[User] ADD AspNetUserID NVARCHAR(128) NULL
--GO



CREATE FUNCTION [DateTime2ToBigInt](@dt DATETIME2(7))
RETURNS BIGINT
WITH SCHEMABINDING AS
BEGIN
-- declare @dtBinary binary(9) = CAST(REVERSE(CONVERT(binary(9), @dt)) as binary(9));
-- declare @dtDateBytes binary(3) = SUBSTRING(@dtBinary, 1, 3);
-- declare @dtTimeBytes binary(5) = SUBSTRING(@dtBinary, 4, 5);
-- declare @dtPrecisionByte binary(1) = SUBSTRING(@dtBinary, 9, 1);

-- return (CONVERT(bigint, @dtDateBytes) * 864000000000) + CONVERT(bigint, @dtTimeBytes)

return DATEDIFF(SECOND, {d '1970-01-01'}, @dt)

END

GO


PRINT 'Creating Auto last changed datetime triggers...  --------------------------------------------------------------------'
DECLARE @colName NVARCHAR(100) = 'Timestamp';
DECLARE @script NVARCHAR(MAX), @tableName NVARCHAR(MAX);

DECLARE cursor_name CURSOR FAST_FORWARD READ_ONLY FOR
SELECT	'CREATE TRIGGER tr'+ tableName +'LastChangeDate ON ['+ schemaName + '].[' + tableName +'] FOR UPDATE AS BEGIN ' +
		'UPDATE ['+ schemaName + '].[' + tableName +'] SET [' + @colName + '] = dbo.DateTime2ToBigInt(GETDATE()) ' +  
		'FROM ['+ schemaName + '].[' + tableName +'] t INNER JOIN Inserted s ON t.Id = s.Id; END ' AS script,
		tableName AS tableName
FROM	(
			SELECT	t.name AS tableName, 
					SCHEMA_NAME(schema_id) AS schemaName
			FROM sys.tables AS t INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
			WHERE c.name = @colName
		) z
OPEN cursor_name
FETCH NEXT FROM cursor_name INTO @script, @tableName

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'for ' + @tableName
	EXEC(@script);
    FETCH NEXT FROM cursor_name INTO @script, @tableName
END

CLOSE cursor_name
DEALLOCATE cursor_name
PRINT 'Finished.'