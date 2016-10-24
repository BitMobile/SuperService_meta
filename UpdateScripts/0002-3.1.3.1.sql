/* 

You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.30.3199 from Red Gate Software Ltd at 20.10.2016 14:15:37 
 
*/

--
-- DO NOT START SCRIPT FOR INCORRECT VERSION
-- 


IF NOT EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.3.0' )

  RETURN

--
-- DO NOT START SCRIPT FOR CURRENT VERSION
-- 

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.3.1' )

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
-- BEGIN OF DELETION MARK AND EQUIPMENT TYPO BLOCK 
--

PRINT 'Update dbConfig Value lenght'
GO

ALTER TABLE [dbo].[dbConfig] ALTER COLUMN [Value] varchar(500) COLLATE Cyrillic_General_CI_AS NOT NULL
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--
-- END OF DATA MODIFICATION 
--

--
-- BEGIN DATABASE VERSION SETUP 
--

PRINT N'Set DBVersion = 3.1.3.0'

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion')
    UPDATE [dbo].[dbConfig]  
      SET [Value]='3.1.3.1'  
      WHERE [Key]='DBVersion'; 
  ELSE
    INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
       VALUES
           ('DBVersion'
           ,N'3.1.3.1');
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

--
-- END DATABASE VERSION SETUP 
--


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
