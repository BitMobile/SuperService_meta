IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.8.0' )

  SET NOEXEC ON


IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.8.3' )

  SET NOEXEC ON

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
if not exists (select * from sysobjects where name='LicensesSolution' and xtype='U')
	BEGIN
		PRINT N'Creating [admin].[LicensesSolution]'
		
		CREATE TABLE [admin].[LicensesSolution]
		(
		[LicensesCount] [int] NULL
		)
		
		CREATE PROCEDURE [admin].[SetLicenses] @LicensesCount INT
		AS
		IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'admin' AND TABLE_NAME = 'LicensesSolution') 
			CREATE TABLE [admin].[LicensesSolution]([LicensesCount] INT)
		IF NOT EXISTS(SELECT 1 FROM [admin].[LicensesSolution])
			INSERT INTO [admin].[LicensesSolution]([LicensesCount]) VALUES(@LicensesCount)
		ELSE
			UPDATE [admin].[LicensesSolution] SET [LicensesCount] = @LicensesCount
	END
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [admin].[ChatHistory]'
GO
if not exists (select * from sysobjects where name='ChatHistory' and xtype='U')
	BEGIN
		CREATE TABLE [admin].[ChatHistory]
		(
		[Id] [uniqueidentifier] NOT NULL,
		[GroupName] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
		[UserId] [uniqueidentifier] NOT NULL,
		[UserName] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL,
		[ConnectionId] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL,
		[Message] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL,
		[AdditionalInfo] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL,
		[CreationDateTime] [datetime] NOT NULL,
		[Timestamp] [bigint] NOT NULL
		)

		ALTER TABLE [admin].[ChatHistory] ADD CONSTRAINT [PK_Admin_ChatHistory] PRIMARY KEY NONCLUSTERED  ([Id])
	END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [admin].[Configuration]'
GO
if not exists (select * from sysobjects where name='Configuration' and xtype='U')
	BEGIN
		CREATE TABLE [admin].[Configuration]
		(
		[Key] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL,
		[Value] [varchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL
		)

		ALTER TABLE [admin].[Configuration] ADD CONSTRAINT [UQ_Configuration] UNIQUE NONCLUSTERED  ([Key])
	END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Insert into catalog.SettingMobileApplication LoggingLevel'

Insert into catalog.SettingMobileApplication([IsDeleted],[Id],[Predefined],[DeletionMark],[Description],[Code],[LogicValue],[NumericValue]) Values(0,Newid(),1,0,'LoggingLevel','000000016',1,1)

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Set DBVersion = 3.1.8.3'
IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.8.3'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.8.3');
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
