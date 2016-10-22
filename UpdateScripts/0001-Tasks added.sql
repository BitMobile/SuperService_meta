/* 

You are recommended to back up your database before running this script 
 
Script created by SQL Compare version 12.0.30.3199 from Red Gate Software Ltd at 20.10.2016 14:15:37 
 
*/

IF EXISTS(SELECT *  FROM  [dbo].[dbConfig] WHERE [Key]='DBVersion' AND [Value]='3.1.3.0' )

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
FETCH NEXT FROM cursor_name INTO @script_update, @tableName

WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT 'FOR ' + @tableName;
  EXEC(@script_update);
  FETCH NEXT FROM cursor_name INTO @script_update, @tableName
END

CLOSE cursor_name  		
DEALLOCATE cursor_name	

IF @@ERROR <> 0 SET NOEXEC ON
GO





PRINT N'Renaming objects with TYPO - equipment';
GO

<<<<<<< HEAD
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
  [Event] [uniqueidentifier] NULL,
  CONSTRAINT [PK_Document_Task] PRIMARY KEY NONCLUSTERED 
  (
    [Id] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

=======
 --table
sp_rename 'Catalog.Equipment_Equiements', 'Equipment_Equipments';
>>>>>>> hotfix/3.1.3.1
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



--
-- END OF DELETION MARK AND EQUIPMENT TYPO BLOCK 
--











PRINT N'Dropping foreign keys from [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] DROP CONSTRAINT [FK_Catalog_Actions_ValueList_Catalog_Actions_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] DROP CONSTRAINT [FK_Catalog_ClientOptions_ListValues_Catalog_ClientOptions_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] DROP CONSTRAINT [FK_Catalog_Client_Contacts_Catalog_Client_EntityId]
GO
ALTER TABLE [Catalog].[Client_Contacts] DROP CONSTRAINT [FK_Catalog_Client__Contacts_Catalog_Contacts_Contact]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] DROP CONSTRAINT [FK_Catalog_Client_Files_Catalog_Client_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] DROP CONSTRAINT [FK_Catalog_Client_Parameters_Catalog_Client_EntityId]
GO
ALTER TABLE [Catalog].[Client_Parameters] DROP CONSTRAINT [FK_Catalog_Client__Parameters_Catalog_ClientOptions_Parameter]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] DROP CONSTRAINT [FK_Catalog_EquipmentOptions_ListValues_Catalog_EquipmentOptions_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] DROP CONSTRAINT [FK_Catalog_Equipment_Files_Catalog_Equipment_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] DROP CONSTRAINT [FK_Catalog_Equipment_Parameters_Catalog_Equipment_EntityId]
GO
ALTER TABLE [Catalog].[Equipment_Parameters] DROP CONSTRAINT [FK_Catalog_Equipment__Parameters_Catalog_EquipmentOptions_Parameter]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] DROP CONSTRAINT [FK_Catalog_EventOptions_ListValues_Catalog_EventOptions_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] DROP CONSTRAINT [FK_Catalog_User_Bag_Catalog_User_EntityId]
GO
ALTER TABLE [Catalog].[User_Bag] DROP CONSTRAINT [FK_Catalog_User__Bag_Catalog_RIM_Materials]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] DROP CONSTRAINT [FK_Catalog_User_RemainsNorms_Catalog_User_EntityId]
GO
ALTER TABLE [Catalog].[User_RemainsNorms] DROP CONSTRAINT [FK_Catalog_User__RemainsNorms_Catalog_RIM_Materials]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] DROP CONSTRAINT [FK_Document_CheckList_Actions_Document_CheckList_EntityId]
GO
ALTER TABLE [Document].[CheckList_Actions] DROP CONSTRAINT [FK_Document_CheckList__Actions_Catalog_Actions_Action]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] DROP CONSTRAINT [FK_Document_Event_CheckList_Document_Event_EntityId]
GO
ALTER TABLE [Document].[Event_CheckList] DROP CONSTRAINT [FK_Document_Event__CheckList_Catalog_Actions_Action]
GO
ALTER TABLE [Document].[Event_CheckList] DROP CONSTRAINT [FK_Document_Event__CheckList_Document_CheckList_CheckListRef]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] DROP CONSTRAINT [FK_Document_Event_Equipments_Document_Event_EntityId]
GO
ALTER TABLE [Document].[Event_Equipments] DROP CONSTRAINT [FK_Document_Event__Equipments_Catalog_Equipment_Equipment]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] DROP CONSTRAINT [FK_Document_Event_Files_Document_Event_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] DROP CONSTRAINT [FK_Document_Event_Parameters_Document_Event_EntityId]
GO
ALTER TABLE [Document].[Event_Parameters] DROP CONSTRAINT [FK_Document_Event__Parameters_Catalog_EventOptions_Parameter]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] DROP CONSTRAINT [FK_Document_Event_Photos_Document_Event_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] DROP CONSTRAINT [FK_Document_Event_ServicesMaterials_Document_Event_EntityId]
GO
ALTER TABLE [Document].[Event_ServicesMaterials] DROP CONSTRAINT [FK_Document_Event__ServicesMaterials_Catalog_RIM_SKU]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] DROP CONSTRAINT [FK_Document_Event_TypeDepartures_Document_Event_EntityId]
GO
ALTER TABLE [Document].[Event_TypeDepartures] DROP CONSTRAINT [FK_Document_Event__TypeDepartures_Catalog_TypesDepartures_TypeDeparture]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] DROP CONSTRAINT [FK_Document_NeedMat_Matireals_Document_NeedMat_EntityId]
GO
ALTER TABLE [Document].[NeedMat_Matireals] DROP CONSTRAINT [FK_Document_NeedMat__Matireals_Catalog_RIM_SKU]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] DROP CONSTRAINT [FK_Document_Reminder_Photo_Document_Reminder_EntityId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] DROP CONSTRAINT [PK_Catalog_Actions_ValueList]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] DROP CONSTRAINT [DF__Actions_Valu__Id__162F4418]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] DROP CONSTRAINT [PK_Catalog_ClientOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] DROP CONSTRAINT [DF__ClientOption__Id__19FFD4FC]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] DROP CONSTRAINT [PK_Catalog_Client_Contacts]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] DROP CONSTRAINT [DF__Client_Conta__Id__18178C8A]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] DROP CONSTRAINT [PK_Catalog_Client_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] DROP CONSTRAINT [DF__Client_Files__Id__17236851]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] DROP CONSTRAINT [PK_Catalog_Client_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] DROP CONSTRAINT [DF__Client_Param__Id__190BB0C3]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] DROP CONSTRAINT [PK_Catalog_EquipmentOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] DROP CONSTRAINT [DF__EquipmentOpt__Id__20ACD28B]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] DROP CONSTRAINT [PK_Catalog_Equipment_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] DROP CONSTRAINT [DF__Equipment_Fi__Id__1CDC41A7]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] DROP CONSTRAINT [PK_Catalog_Equipment_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] DROP CONSTRAINT [DF__Equipment_Pa__Id__1DD065E0]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] DROP CONSTRAINT [PK_Catalog_EventOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] DROP CONSTRAINT [DF__EventOptions__Id__21A0F6C4]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] DROP CONSTRAINT [PK_Catalog_User_Bag]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] DROP CONSTRAINT [DF__User_Bag__Id__1EC48A19]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] DROP CONSTRAINT [PK_Catalog_User_RemainsNorms]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] DROP CONSTRAINT [DF__User_Remains__Id__1FB8AE52]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] DROP CONSTRAINT [PK_Document_CheckList_Actions]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] DROP CONSTRAINT [DF__CheckList_Ac__Id__22951AFD]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] DROP CONSTRAINT [PK_Document_Event_CheckList]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] DROP CONSTRAINT [DF__Event_CheckL__Id__2759D01A]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] DROP CONSTRAINT [PK_Document_Event_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] DROP CONSTRAINT [DF__Event_Equipm__Id__247D636F]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] DROP CONSTRAINT [PK_Document_Event_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] DROP CONSTRAINT [DF__Event_Files__Id__23893F36]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] DROP CONSTRAINT [PK_Document_Event_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] DROP CONSTRAINT [DF__Event_Parame__Id__2665ABE1]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] DROP CONSTRAINT [PK_Document_Event_Photos]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] DROP CONSTRAINT [DF__Event_Photos__Id__257187A8]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] DROP CONSTRAINT [PK_Document_Event_ServicesMaterials]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] DROP CONSTRAINT [DF__Event_Servic__Id__2942188C]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] DROP CONSTRAINT [PK_Document_Event_TypeDepartures]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] DROP CONSTRAINT [DF__Event_TypeDe__Id__284DF453]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] DROP CONSTRAINT [PK_Document_NeedMat_Matireals]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] DROP CONSTRAINT [DF__NeedMat_Mati__Id__2A363CC5]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] DROP CONSTRAINT [PK_Document_Reminder_Photo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] DROP CONSTRAINT [DF__Reminder_Pho__Id__2B2A60FE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[AsyncUploadSession]'
GO
ALTER TABLE [admin].[AsyncUploadSession] DROP CONSTRAINT [PK__AsyncUpl__3214EC06428B8A08]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[DeletedObjects]'
GO
ALTER TABLE [admin].[DeletedObjects] DROP CONSTRAINT [PK__DeletedO__3214EC06016BC840]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[FileSystem]'
GO
ALTER TABLE [admin].[FileSystem] DROP CONSTRAINT [PK__FileSyst__77387D07559C4637]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[LastSyncTime]'
GO
ALTER TABLE [admin].[LastSyncTime] DROP CONSTRAINT [PK__LastSync__C96133CD8C4E7152]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[SyncSession]'
GO
ALTER TABLE [admin].[SyncSession] DROP CONSTRAINT [PK__SyncSess__3214EC06B55FB2FD]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [admin].[Telegram]'
GO
ALTER TABLE [admin].[Telegram] DROP CONSTRAINT [PK__Telegram__5C7E359E5CC811AB]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Actions_ValueList_Key] from [Catalog].[Actions_ValueList]'
GO
DROP INDEX [UQ_Catalog_Actions_ValueList_Key] ON [Catalog].[Actions_ValueList]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_ClientOptions_ListValues_Key] from [Catalog].[ClientOptions_ListValues]'
GO
DROP INDEX [UQ_Catalog_ClientOptions_ListValues_Key] ON [Catalog].[ClientOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Client_Contacts_Key] from [Catalog].[Client_Contacts]'
GO
DROP INDEX [UQ_Catalog_Client_Contacts_Key] ON [Catalog].[Client_Contacts]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Client_Files_Key] from [Catalog].[Client_Files]'
GO
DROP INDEX [UQ_Catalog_Client_Files_Key] ON [Catalog].[Client_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Client_Parameters_Key] from [Catalog].[Client_Parameters]'
GO
DROP INDEX [UQ_Catalog_Client_Parameters_Key] ON [Catalog].[Client_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_EquipmentOptions_ListValues_Key] from [Catalog].[EquipmentOptions_ListValues]'
GO
DROP INDEX [UQ_Catalog_EquipmentOptions_ListValues_Key] ON [Catalog].[EquipmentOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Equipment_Files_Key] from [Catalog].[Equipment_Files]'
GO
DROP INDEX [UQ_Catalog_Equipment_Files_Key] ON [Catalog].[Equipment_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Equipment_Parameters_Key] from [Catalog].[Equipment_Parameters]'
GO
DROP INDEX [UQ_Catalog_Equipment_Parameters_Key] ON [Catalog].[Equipment_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_EventOptions_ListValues_Key] from [Catalog].[EventOptions_ListValues]'
GO
DROP INDEX [UQ_Catalog_EventOptions_ListValues_Key] ON [Catalog].[EventOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_User_Bag_Key] from [Catalog].[User_Bag]'
GO
DROP INDEX [UQ_Catalog_User_Bag_Key] ON [Catalog].[User_Bag]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_User_RemainsNorms_Key] from [Catalog].[User_RemainsNorms]'
GO
DROP INDEX [UQ_Catalog_User_RemainsNorms_Key] ON [Catalog].[User_RemainsNorms]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_CheckList_Actions_Key] from [Document].[CheckList_Actions]'
GO
DROP INDEX [UQ_Document_CheckList_Actions_Key] ON [Document].[CheckList_Actions]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_CheckList_Key] from [Document].[Event_CheckList]'
GO
DROP INDEX [UQ_Document_Event_CheckList_Key] ON [Document].[Event_CheckList]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_Equipments_Key] from [Document].[Event_Equipments]'
GO
DROP INDEX [UQ_Document_Event_Equipments_Key] ON [Document].[Event_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_Files_Key] from [Document].[Event_Files]'
GO
DROP INDEX [UQ_Document_Event_Files_Key] ON [Document].[Event_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_Parameters_Key] from [Document].[Event_Parameters]'
GO
DROP INDEX [UQ_Document_Event_Parameters_Key] ON [Document].[Event_Parameters]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_Photos_Key] from [Document].[Event_Photos]'
GO
DROP INDEX [UQ_Document_Event_Photos_Key] ON [Document].[Event_Photos]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_ServicesMaterials_Key] from [Document].[Event_ServicesMaterials]'
GO
DROP INDEX [UQ_Document_Event_ServicesMaterials_Key] ON [Document].[Event_ServicesMaterials]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Event_TypeDepartures_Key] from [Document].[Event_TypeDepartures]'
GO
DROP INDEX [UQ_Document_Event_TypeDepartures_Key] ON [Document].[Event_TypeDepartures]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_NeedMat_Matireals_Key] from [Document].[NeedMat_Matireals]'
GO
DROP INDEX [UQ_Document_NeedMat_Matireals_Key] ON [Document].[NeedMat_Matireals]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Document_Reminder_Photo_Key] from [Document].[Reminder_Photo]'
GO
DROP INDEX [UQ_Document_Reminder_Photo_Key] ON [Document].[Reminder_Photo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Files_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[Equipment_Files_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_CheckList_adm_update_batch_all]'
GO
DROP PROCEDURE [Document].[Event_CheckList_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Files_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[Equipment_Files_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_CheckList_adm_insert_batch]'
GO
DROP PROCEDURE [Document].[Event_CheckList_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_Equipments_adm_update_batch_all]'
GO
DROP PROCEDURE [Document].[Event_Equipments_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_Equipments_adm_insert_batch]'
GO
DROP PROCEDURE [Document].[Event_Equipments_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_Files_adm_update_batch_all]'
GO
DROP PROCEDURE [Document].[Event_Files_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[ClientOptions_ListValues_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[ClientOptions_ListValues_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Document].[Event_Files_adm_insert_batch]'
GO
DROP PROCEDURE [Document].[Event_Files_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[ClientOptions_ListValues_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[ClientOptions_ListValues_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Client_Files_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[Client_Files_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Client_Files_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[Client_Files_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[EventOptions_ListValues_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[EventOptions_ListValues_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[EventOptions_ListValues_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[EventOptions_ListValues_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[EquipmentOptions_ListValues_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[EquipmentOptions_ListValues_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping types'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_ClientOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_Client_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_EquipmentOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_Equipment_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_EventOptions_ListValues]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Document].[T_Event_CheckList]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Document].[T_Event_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Document].[T_Event_Files]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating types'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_ClientOptions_ListValues] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
UNIQUE NONCLUSTERED  ([Val]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_Client_Files] AS TABLE 
( 
[LineNumber] [int] NULL, 
[FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[FileName] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([FullFileName], [FileName]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_EquipmentOptions_ListValues] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
UNIQUE NONCLUSTERED  ([Val]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_Equipment_Files] AS TABLE 
( 
[LineNumber] [int] NULL, 
[FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[FileName] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([FullFileName], [FileName]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_EventOptions_ListValues] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
UNIQUE NONCLUSTERED  ([Val]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Event_CheckList] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Action] [uniqueidentifier] NULL, 
[CheckListRef] [uniqueidentifier] NULL, 
[Result] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[ActionType] [uniqueidentifier] NULL, 
[Required] [bit] NULL, 
UNIQUE NONCLUSTERED  ([Action], [CheckListRef]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Event_Equipments] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Equipment] [uniqueidentifier] NULL, 
[Terget] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Result] [uniqueidentifier] NULL, 
[Comment] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[SID] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([Equipment], [SID]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Event_Files] AS TABLE 
( 
[LineNumber] [int] NULL, 
[FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[FileName] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([FullFileName], [FileName]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Task_Status] AS TABLE 
( 
[LineNumber] [int] NULL, 
[CommentContractor] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Status] [uniqueidentifier] NULL, 
[UserMA] [uniqueidentifier] NULL, 
[ActualEndDate] [datetime2] NULL, 
[CloseEvent] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([CommentContractor]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Document].[T_Task_Targets] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Description] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[IsDone] [bit] NULL, 
UNIQUE NONCLUSTERED  ([Description]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[StatusyEvents]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[StatusyEvents] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Files]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Files] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Files] ALTER COLUMN [FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_Files] on [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] ADD CONSTRAINT [PK_Document_Event_Files] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] ADD CONSTRAINT [UQ_Document_Event_Files_Key] UNIQUE NONCLUSTERED  ([Ref], [FullFileName], [FileName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_Files_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Event_Files_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_Files] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event_Files] SET 
				[LineNumber] = D.[LineNumber],				[FullFileName] = D.[FullFileName],				[FileName] = D.[FileName]			FROM [Document].[Event_Files] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[FullFileName] <> D.[FullFileName] OR T.[FileName] <> D.[FileName] ) 
 
	INSERT INTO [Document].[Event_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[FullFileName],D.[FileName]		FROM @Data D 
		LEFT JOIN [Document].[Event_Files] T ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Event_Files] 
	FROM [Document].[Event_Files] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND D.[FullFileName] IS NULL AND D.[FileName] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SKU]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SKU] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SKU] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SKU] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SKU_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[SKU_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[SKU]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Files_adm_delete]'
GO
 
ALTER PROCEDURE [Document].[Event_Files_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@FullFileName NVARCHAR(1000) 
		,@FileName UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Event_Files] 
	WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SKU_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[SKU_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[SKU] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [IsFolder] <> @IsFolder OR ([IsFolder] IS NULL AND NOT @IsFolder IS NULL) OR (NOT [IsFolder] IS NULL AND @IsFolder IS NULL)  OR [Parent] <> @Parent OR ([Parent] IS NULL AND NOT @Parent IS NULL) OR (NOT [Parent] IS NULL AND @Parent IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Equipments]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Equipments] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Equipments] ALTER COLUMN [Terget] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_Equipments] on [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] ADD CONSTRAINT [PK_Document_Event_Equipments] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] ADD CONSTRAINT [UQ_Document_Event_Equipments_Key] UNIQUE NONCLUSTERED  ([Ref], [Equipment], [SID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Equipments_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Document].[Event_Equipments_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Equipment UNIQUEIDENTIFIER,		@Terget NVARCHAR(1000),		@Result UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@SID UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_Equipments]( 
		[Ref],[LineNumber],[Equipment],[Terget],[Result],[Comment],[SID]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Equipment,@Terget,@Result,@Comment,@SID	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SKU_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[SKU_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[SKU] WHERE Id = @Id) 
	UPDATE [Catalog].[SKU] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[SKU] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.SKU',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_Equipments_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Event_Equipments_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_Equipments] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_Equipments]( 
		[Ref],[LineNumber],[Equipment],[Terget],[Result],[Comment],[SID]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Equipment],[Terget],[Result],[Comment],[SID]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[TypesDataParameters]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[TypesDataParameters] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Equipments_adm_update]'
GO
 
ALTER PROCEDURE [Document].[Event_Equipments_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Equipment UNIQUEIDENTIFIER,		@Terget NVARCHAR(1000),		@Result UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@SID UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event_Equipments] WHERE [Ref] = @Ref AND ([Equipment] = @Equipment OR ([Equipment] IS NULL AND @Equipment IS NULL)) AND ([SID] = @SID OR ([SID] IS NULL AND @SID IS NULL))) 
	UPDATE [Document].[Event_Equipments] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Equipment] = @Equipment,				[Terget] = @Terget,				[Result] = @Result,				[Comment] = @Comment,				[SID] = @SID			WHERE [Ref] = @Ref AND [Equipment] = @Equipment AND [SID] = @SID AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [Terget] <> @Terget OR [Result] <> @Result OR [Comment] <> @Comment ) 
	ELSE 
	INSERT INTO [Document].[Event_Equipments]( 
		[Ref],[LineNumber],[Equipment],[Terget],[Result],[Comment],[SID]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Equipment,@Terget,@Result,@Comment,@SID	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[Equipment_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@SKU UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[SKU]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@SKU			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_Equipments_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Event_Equipments_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_Equipments] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event_Equipments] SET 
				[LineNumber] = D.[LineNumber],				[Equipment] = D.[Equipment],				[Terget] = D.[Terget],				[Result] = D.[Result],				[Comment] = D.[Comment],				[SID] = D.[SID]			FROM [Document].[Event_Equipments] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL)) AND (T.[SID] = D.[SID] OR (T.[SID] IS NULL AND D.[SID] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Equipment] <> D.[Equipment] OR T.[Terget] <> D.[Terget] OR T.[Result] <> D.[Result] OR T.[Comment] <> D.[Comment] OR T.[SID] <> D.[SID] ) 
 
	INSERT INTO [Document].[Event_Equipments]( 
		[Ref],[LineNumber],[Equipment],[Terget],[Result],[Comment],[SID]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Equipment],D.[Terget],D.[Result],D.[Comment],D.[SID]		FROM @Data D 
		LEFT JOIN [Document].[Event_Equipments] T ON T.Ref = @Ref AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL)) AND (T.[SID] = D.[SID] OR (T.[SID] IS NULL AND D.[SID] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Event_Equipments] 
	FROM [Document].[Event_Equipments] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL)) AND (T.[SID] = D.[SID] OR (T.[SID] IS NULL AND D.[SID] IS NULL))	WHERE T.Ref = @Ref AND D.[Equipment] IS NULL AND D.[SID] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[Equipment_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@SKU UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Equipment] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[SKU] = @SKU			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [SKU] <> @SKU OR ([SKU] IS NULL AND NOT @SKU IS NULL) OR (NOT [SKU] IS NULL AND @SKU IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[Equipment_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@SKU UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Equipment] WHERE Id = @Id) 
	UPDATE [Catalog].[Equipment] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[SKU] = @SKU			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[Equipment] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[SKU]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@SKU			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.Equipment',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Photos]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Photos] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_Photos] on [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] ADD CONSTRAINT [PK_Document_Event_Photos] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] ADD CONSTRAINT [UQ_Document_Event_Photos_Key] UNIQUE NONCLUSTERED  ([Ref], [UIDPhoto])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[TypesEvents]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[TypesEvents] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[BusinessProcess]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[BusinessProcess] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Parameters]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_Parameters] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_Parameters] on [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] ADD CONSTRAINT [PK_Document_Event_Parameters] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] ADD CONSTRAINT [UQ_Document_Event_Parameters_Key] UNIQUE NONCLUSTERED  ([Ref], [Parameter])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Configuration]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Configuration] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_CheckList]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_CheckList] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_CheckList] ALTER COLUMN [Result] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_CheckList] on [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [PK_Document_Event_CheckList] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [UQ_Document_Event_CheckList_Key] UNIQUE NONCLUSTERED  ([Ref], [Action], [CheckListRef])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_CheckList_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Document].[Event_CheckList_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Action UNIQUEIDENTIFIER,		@CheckListRef UNIQUEIDENTIFIER,		@Result NVARCHAR(1000),		@ActionType UNIQUEIDENTIFIER,		@Required BIT	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_CheckList]( 
		[Ref],[LineNumber],[Action],[CheckListRef],[Result],[ActionType],[Required]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Action,@CheckListRef,@Result,@ActionType,@Required	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_CheckList_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Event_CheckList_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_CheckList] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_CheckList]( 
		[Ref],[LineNumber],[Action],[CheckListRef],[Result],[ActionType],[Required]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Action],[CheckListRef],[Result],[ActionType],[Required]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Files]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Files] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Files] ALTER COLUMN [FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Equipment_Files] on [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] ADD CONSTRAINT [PK_Catalog_Equipment_Files] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] ADD CONSTRAINT [UQ_Catalog_Equipment_Files_Key] UNIQUE NONCLUSTERED  ([Ref], [FullFileName], [FileName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Files_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[Equipment_Files_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_CheckList_adm_update]'
GO
 
ALTER PROCEDURE [Document].[Event_CheckList_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Action UNIQUEIDENTIFIER,		@CheckListRef UNIQUEIDENTIFIER,		@Result NVARCHAR(1000),		@ActionType UNIQUEIDENTIFIER,		@Required BIT	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event_CheckList] WHERE [Ref] = @Ref AND ([Action] = @Action OR ([Action] IS NULL AND @Action IS NULL)) AND ([CheckListRef] = @CheckListRef OR ([CheckListRef] IS NULL AND @CheckListRef IS NULL))) 
	UPDATE [Document].[Event_CheckList] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Action] = @Action,				[CheckListRef] = @CheckListRef,				[Result] = @Result,				[ActionType] = @ActionType,				[Required] = @Required			WHERE [Ref] = @Ref AND [Action] = @Action AND [CheckListRef] = @CheckListRef AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [Result] <> @Result OR [ActionType] <> @ActionType OR [Required] <> @Required ) 
	ELSE 
	INSERT INTO [Document].[Event_CheckList]( 
		[Ref],[LineNumber],[Action],[CheckListRef],[Result],[ActionType],[Required]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Action,@CheckListRef,@Result,@ActionType,@Required	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Files_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Files_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_Files] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,[LineNumber],[FullFileName],[FileName]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Image]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Image] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_CheckList_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Event_CheckList_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_CheckList] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event_CheckList] SET 
				[LineNumber] = D.[LineNumber],				[Action] = D.[Action],				[CheckListRef] = D.[CheckListRef],				[Result] = D.[Result],				[ActionType] = D.[ActionType],				[Required] = D.[Required]			FROM [Document].[Event_CheckList] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Action] = D.[Action] OR (T.[Action] IS NULL AND D.[Action] IS NULL)) AND (T.[CheckListRef] = D.[CheckListRef] OR (T.[CheckListRef] IS NULL AND D.[CheckListRef] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Action] <> D.[Action] OR T.[CheckListRef] <> D.[CheckListRef] OR T.[Result] <> D.[Result] OR T.[ActionType] <> D.[ActionType] OR T.[Required] <> D.[Required] ) 
 
	INSERT INTO [Document].[Event_CheckList]( 
		[Ref],[LineNumber],[Action],[CheckListRef],[Result],[ActionType],[Required]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Action],D.[CheckListRef],D.[Result],D.[ActionType],D.[Required]		FROM @Data D 
		LEFT JOIN [Document].[Event_CheckList] T ON T.Ref = @Ref AND (T.[Action] = D.[Action] OR (T.[Action] IS NULL AND D.[Action] IS NULL)) AND (T.[CheckListRef] = D.[CheckListRef] OR (T.[CheckListRef] IS NULL AND D.[CheckListRef] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Event_CheckList] 
	FROM [Document].[Event_CheckList] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Action] = D.[Action] OR (T.[Action] IS NULL AND D.[Action] IS NULL)) AND (T.[CheckListRef] = D.[CheckListRef] OR (T.[CheckListRef] IS NULL AND D.[CheckListRef] IS NULL))	WHERE T.Ref = @Ref AND D.[Action] IS NULL AND D.[CheckListRef] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_TypeDepartures]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_TypeDepartures] on [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD CONSTRAINT [PK_Document_Event_TypeDepartures] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD CONSTRAINT [UQ_Document_Event_TypeDepartures_Key] UNIQUE NONCLUSTERED  ([Ref], [TypeDeparture])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Files_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[Equipment_Files_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Equipment_Files] WHERE [Ref] = @Ref AND ([FullFileName] = @FullFileName OR ([FullFileName] IS NULL AND @FullFileName IS NULL)) AND ([FileName] = @FileName OR ([FileName] IS NULL AND @FileName IS NULL))) 
	UPDATE [Catalog].[Equipment_Files] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[FullFileName] = @FullFileName,				[FileName] = @FileName			WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Catalog].[Equipment_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [admin].[DeviceLog]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [admin].[DeviceLog] ADD 
[TimestampFrom] [bigint] NULL, 
[TimestampTo] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [admin].[DeviceLog] DROP 
COLUMN [Direction], 
COLUMN [Accept], 
COLUMN [AcceptEncoding]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [admin].[DeviceLog] ALTER COLUMN [FirstSync] [bit] NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [admin].[WriteLog]'
GO
 
ALTER PROCEDURE [admin].[WriteLog]  
	@StartTime DATETIME, 
	@EndTime DATETIME, 
	@FirstSync BIT, 
	@TimestampFrom BIGINT, 
	@TimestampTo BIGINT, 
	@DeviceId VARCHAR(150), 
	@Login VARCHAR(50), 
	@UserId UNIQUEIDENTIFIER, 
	@UserEMail VARCHAR(100), 
	@ContentLength INT, 
	@ContentType VARCHAR(100), 
	@Host VARCHAR(250), 
	@ConfigName VARCHAR(250), 
	@ConfigVersion VARCHAR(50), 
	@CoreVersion VARCHAR(50), 
	@ResourceVersion VARCHAR(50), 
	@OutputContentLength INT, 
	@StatusCode INT,			 
	@StatusDescription VARCHAR(MAX)	 
AS 
SET NOCOUNT ON 
INSERT INTO [admin].DeviceLog( 
	[StartTime], 
	[EndTime], 
	[FirstSync], 
	[TimestampFrom], 
	[TimestampTo], 
	[DeviceId], 
	[Login], 
	[UserId], 
	[UserEMail], 
	[ContentLength], 
	[ContentType], 
	[Host], 
	[ConfigName], 
	[ConfigVersion], 
	[CoreVersion], 
	[ResourceVersion], 
	[OutputContentLength], 
	[StatusCode],			 
	[StatusDescription] 
) 
VALUES( 
	@StartTime, 
	@EndTime, 
	@FirstSync, 
	@TimestampFrom, 
	@TimestampTo, 
	@DeviceId, 
	@Login, 
	@UserId, 
	@UserEMail, 
	@ContentLength, 
	@ContentType, 
	@Host, 
	@ConfigName, 
	@ConfigVersion, 
	@CoreVersion, 
	@ResourceVersion, 
	@OutputContentLength, 
	@StatusCode,			 
	@StatusDescription	 
)	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Files_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Files_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_Files] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Equipment_Files] SET 
				[LineNumber] = D.[LineNumber],				[FullFileName] = D.[FullFileName],				[FileName] = D.[FileName]			FROM [Catalog].[Equipment_Files] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[FullFileName] <> D.[FullFileName] OR T.[FileName] <> D.[FileName] ) 
 
	INSERT INTO [Catalog].[Equipment_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[FullFileName],D.[FileName]		FROM @Data D 
		LEFT JOIN [Catalog].[Equipment_Files] T ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[Equipment_Files] 
	FROM [Catalog].[Equipment_Files] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND D.[FullFileName] IS NULL AND D.[FileName] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Files_adm_delete]'
GO
 
ALTER PROCEDURE [Catalog].[Equipment_Files_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@FullFileName NVARCHAR(1000) 
		,@FileName UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Equipment_Files] 
	WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Parameters]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Equipment_Parameters] on [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD CONSTRAINT [PK_Catalog_Equipment_Parameters] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD CONSTRAINT [UQ_Catalog_Equipment_Parameters_Key] UNIQUE NONCLUSTERED  ([Ref], [Parameter])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Screen]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Screen] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_ServicesMaterials]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Event_ServicesMaterials] on [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD CONSTRAINT [PK_Document_Event_ServicesMaterials] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD CONSTRAINT [UQ_Document_Event_ServicesMaterials_Key] UNIQUE NONCLUSTERED  ([Ref], [SKU])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Script]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Script] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ServiceAgreement]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ServiceAgreement] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ServiceAgreement] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ServiceAgreement] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ServiceAgreement_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[ServiceAgreement_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Client UNIQUEIDENTIFIER,		@Organization NVARCHAR(500),		@DateStart DATETIME2,		@DateEnd DATETIME2	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[ServiceAgreement]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Client],				[Organization],				[DateStart],				[DateEnd]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Client,				@Organization,				@DateStart,				@DateEnd			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ServiceAgreement_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[ServiceAgreement_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Client UNIQUEIDENTIFIER,		@Organization NVARCHAR(500),		@DateStart DATETIME2,		@DateEnd DATETIME2	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[ServiceAgreement] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Client] = @Client,				[Organization] = @Organization,				[DateStart] = @DateStart,				[DateEnd] = @DateEnd			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [Client] <> @Client OR ([Client] IS NULL AND NOT @Client IS NULL) OR (NOT [Client] IS NULL AND @Client IS NULL)  OR [Organization] <> @Organization OR ([Organization] IS NULL AND NOT @Organization IS NULL) OR (NOT [Organization] IS NULL AND @Organization IS NULL)  OR [DateStart] <> @DateStart OR ([DateStart] IS NULL AND NOT @DateStart IS NULL) OR (NOT [DateStart] IS NULL AND @DateStart IS NULL)  OR [DateEnd] <> @DateEnd OR ([DateEnd] IS NULL AND NOT @DateEnd IS NULL) OR (NOT [DateEnd] IS NULL AND @DateEnd IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ServiceAgreement_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[ServiceAgreement_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Client UNIQUEIDENTIFIER,		@Organization NVARCHAR(500),		@DateStart DATETIME2,		@DateEnd DATETIME2	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[ServiceAgreement] WHERE Id = @Id) 
	UPDATE [Catalog].[ServiceAgreement] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Client] = @Client,				[Organization] = @Organization,				[DateStart] = @DateStart,				[DateEnd] = @DateEnd			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[ServiceAgreement] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Client],				[Organization],				[DateStart],				[DateEnd]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Client,				@Organization,				@DateStart,				@DateEnd			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.ServiceAgreement',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[NeedMat]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[NeedMat] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[NeedMat] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Style]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Style] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [Password] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [EMail] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User] ALTER COLUMN [Phone] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[User_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role NVARCHAR(500),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[User]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[UserName],				[Password],				[UserDB],				[EMail],				[UserID],				[Phone],				[Role],				[AspNetUserID]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@UserName,				@Password,				@UserDB,				@EMail,				@UserID,				@Phone,				@Role,				@AspNetUserID			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[User_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role NVARCHAR(500),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[User] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[UserName] = @UserName,				[Password] = @Password,				[UserDB] = @UserDB,				[EMail] = @EMail,				[UserID] = @UserID,				[Phone] = @Phone,				[Role] = @Role,				[AspNetUserID] = @AspNetUserID			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [UserName] <> @UserName OR ([UserName] IS NULL AND NOT @UserName IS NULL) OR (NOT [UserName] IS NULL AND @UserName IS NULL)  OR [Password] <> @Password OR ([Password] IS NULL AND NOT @Password IS NULL) OR (NOT [Password] IS NULL AND @Password IS NULL)  OR [UserDB] <> @UserDB OR ([UserDB] IS NULL AND NOT @UserDB IS NULL) OR (NOT [UserDB] IS NULL AND @UserDB IS NULL)  OR [EMail] <> @EMail OR ([EMail] IS NULL AND NOT @EMail IS NULL) OR (NOT [EMail] IS NULL AND @EMail IS NULL)  OR [UserID] <> @UserID OR ([UserID] IS NULL AND NOT @UserID IS NULL) OR (NOT [UserID] IS NULL AND @UserID IS NULL)  OR [Phone] <> @Phone OR ([Phone] IS NULL AND NOT @Phone IS NULL) OR (NOT [Phone] IS NULL AND @Phone IS NULL)  OR [Role] <> @Role OR ([Role] IS NULL AND NOT @Role IS NULL) OR (NOT [Role] IS NULL AND @Role IS NULL)  OR [AspNetUserID] <> @AspNetUserID OR ([AspNetUserID] IS NULL AND NOT @AspNetUserID IS NULL) OR (NOT [AspNetUserID] IS NULL AND @AspNetUserID IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[User_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@UserName NVARCHAR(100),		@Password NVARCHAR(100),		@UserDB NVARCHAR(500),		@EMail NVARCHAR(100),		@UserID UNIQUEIDENTIFIER,		@Phone NVARCHAR(100),		@Role NVARCHAR(500),		@AspNetUserID NVARCHAR(128)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[User] WHERE Id = @Id) 
	UPDATE [Catalog].[User] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[UserName] = @UserName,				[Password] = @Password,				[UserDB] = @UserDB,				[EMail] = @EMail,				[UserID] = @UserID,				[Phone] = @Phone,				[Role] = @Role,				[AspNetUserID] = @AspNetUserID			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[User] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[UserName],				[Password],				[UserDB],				[EMail],				[UserID],				[Phone],				[Role],				[AspNetUserID]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@UserName,				@Password,				@UserDB,				@EMail,				@UserID,				@Phone,				@Role,				@AspNetUserID			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.User',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[NeedMat_Matireals]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_NeedMat_Matireals] on [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD CONSTRAINT [PK_Document_NeedMat_Matireals] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD CONSTRAINT [UQ_Document_NeedMat_Matireals_Key] UNIQUE NONCLUSTERED  ([Ref], [SKU])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [resource].[Translation]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [resource].[Translation] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_Bag]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User_Bag] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_User_Bag] on [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] ADD CONSTRAINT [PK_Catalog_User_Bag] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] ADD CONSTRAINT [UQ_Catalog_User_Bag_Key] UNIQUE NONCLUSTERED  ([Ref], [Materials])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [admin].[GetDeviceLog]'
GO
 
ALTER PROCEDURE [admin].[GetDeviceLog] 
	@UserId UNIQUEIDENTIFIER = NULL, @StartTime datetime = NULL, @EndTime datetime = NULL 
	AS 
	SET NOCOUNT ON 
 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'' AS [Root!1], 
	NULL AS [Row!2!StartTime], 
	NULL AS [Row!2!EndTime], 
	NULL AS [Row!2!FirstSync], 
	NULL AS [Row!2!DeviceId], 
	NULL AS [Row!2!Login], 
	NULL AS [Row!2!UserId], 
	NULL AS [Row!2!UserEMail], 
	NULL AS [Row!2!ContentLength], 
	NULL AS [Row!2!OutputContentLength], 
	NULL AS [Row!2!ConfigName], 
	NULL AS [Row!2!ConfigVersion], 
	NULL AS [Row!2!CoreVersion], 
	NULL AS [Row!2!ResourceVersion], 
	NULL AS [Row!2!StatusCode], 
	NULL AS [Row!2!StatusDescription] 
 
	UNION ALL 
 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Root!1], 
		[StartTime] AS [Row!2!StartTime], 
		[EndTime] AS [Row!2!EndTime], 
		[FirstSync] AS [Row!2!FirstSync], 
		[DeviceId] AS [Row!2!DeviceId], 
		[Login] AS [Row!2!Login], 
		[UserId] AS [Row!2!UserId], 
		[UserEMail] AS [Row!2!UserEMail], 
		[ContentLength] AS [Row!2!ContentLength], 
		[OutputContentLength] AS [Row!2!OutputContentLength], 
		[ConfigName] AS [Row!2!ConfigName], 
		[ConfigVersion] AS [Row!2!ConfigVersion], 
		[CoreVersion] AS [Row!2!CoreVersion], 
		[ResourceVersion] AS [Row!2!ResourceVersion], 
		[StatusCode] AS [Row!2!StatusCode], 
		[StatusDescription] AS [Row!2!StatusDescription] 
	FROM [admin].DeviceLog 
	WHERE [UserId] = ISNULL(@UserId, [UserId]) 
	AND [StartTime] >= ISNULL(@StartTime, [StartTime]) 
	AND [EndTime] <= ISNULL(@EndTime, [EndTime]) 
 
	ORDER BY 4,2,1 
 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Reminder]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Reminder] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Reminder] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [admin].[Entity]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [admin].[Entity] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[User_RemainsNorms]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_User_RemainsNorms] on [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD CONSTRAINT [PK_Catalog_User_RemainsNorms] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD CONSTRAINT [UQ_Catalog_User_RemainsNorms_Key] UNIQUE NONCLUSTERED  ([Ref], [Materials])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Accounts]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Accounts] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Accounts] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Actions_ValueList]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Actions_ValueList] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Actions_ValueList] on [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] ADD CONSTRAINT [PK_Catalog_Actions_ValueList] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] ADD CONSTRAINT [UQ_Catalog_Actions_ValueList_Key] UNIQUE NONCLUSTERED  ([Ref], [Val])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Actions]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Actions] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Actions] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Parameters]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Client_Parameters] on [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD CONSTRAINT [PK_Catalog_Client_Parameters] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD CONSTRAINT [UQ_Catalog_Client_Parameters_Key] UNIQUE NONCLUSTERED  ([Ref], [Parameter])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Files]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client_Files] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client_Files] ALTER COLUMN [FullFileName] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Client_Files] on [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] ADD CONSTRAINT [PK_Catalog_Client_Files] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] ADD CONSTRAINT [UQ_Catalog_Client_Files_Key] UNIQUE NONCLUSTERED  ([Ref], [FullFileName], [FileName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Contacts]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Client_Contacts] on [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD CONSTRAINT [PK_Catalog_Client_Contacts] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD CONSTRAINT [UQ_Catalog_Client_Contacts_Key] UNIQUE NONCLUSTERED  ([Ref], [Contact])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Client] ALTER COLUMN [Address] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Contacts]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Contacts] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Contacts] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Contacts] ALTER COLUMN [Tel] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Reminder_Photo]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Reminder_Photo] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Reminder_Photo] on [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] ADD CONSTRAINT [PK_Document_Reminder_Photo] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] ADD CONSTRAINT [UQ_Document_Reminder_Photo_Key] UNIQUE NONCLUSTERED  ([Ref], [IDPhoto])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ClientOptions_ListValues]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ALTER COLUMN [Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_ClientOptions_ListValues] on [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ADD CONSTRAINT [PK_Catalog_ClientOptions_ListValues] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ADD CONSTRAINT [UQ_Catalog_ClientOptions_ListValues_Key] UNIQUE NONCLUSTERED  ([Ref], [Val])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ClientOptions]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ClientOptions] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[ClientOptions] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_adm_getchanges]'
GO
 
 
ALTER PROCEDURE [Catalog].[Equipment_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Catalog].[Equipment] E 
	JOIN [Catalog].[Equipment_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[Equipment_Equipments] E 
	JOIN [Catalog].[Equipment_Equipments_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[Equipment_EquipmentsHistory] E 
	JOIN [Catalog].[Equipment_EquipmentsHistory_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[Equipment_Files] E 
	JOIN [Catalog].[Equipment_Files_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Catalog].[Equipment_Parameters] E 
	JOIN [Catalog].[Equipment_Parameters_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Catalog.Equipment' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]						,NULL AS [Equipments!11] 
						,NULL AS [EquipmentsHistory!21] 
						,NULL AS [Files!31] 
						,NULL AS [Parameters!41] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Period] 
					,NULL AS [Row!12!Clients] 
					,NULL AS [Row!12!StatusEquipment] 
					,NULL AS [Row!12!ContractSale] 
					,NULL AS [Row!12!CantractService] 
					,NULL AS [Row!12!ContactForEquipment] 
					,NULL AS [Row!12!Info] 
					,NULL AS [Row!12!Equipment] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Period] 
					,NULL AS [Row!22!Client] 
					,NULL AS [Row!22!Equipments] 
					,NULL AS [Row!22!Target] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!ObjectGet] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!Executor] 
												,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!FullFileName] 
					,NULL AS [Row!32!FileName] 
												,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
			 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Predefined] AS [Row!2!Predefined],H.[DeletionMark] AS [Row!2!DeletionMark],H.[Description] AS [Row!2!Description],H.[Code] AS [Row!2!Code],H.[SKU] AS [Row!2!SKU]						,NULL AS [Equipments!11] 
						,NULL AS [EquipmentsHistory!21] 
						,NULL AS [Files!31] 
						,NULL AS [Parameters!41] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Period] 
					,NULL AS [Row!12!Clients] 
					,NULL AS [Row!12!StatusEquipment] 
					,NULL AS [Row!12!ContractSale] 
					,NULL AS [Row!12!CantractService] 
					,NULL AS [Row!12!ContactForEquipment] 
					,NULL AS [Row!12!Info] 
					,NULL AS [Row!12!Equipment] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Period] 
					,NULL AS [Row!22!Client] 
					,NULL AS [Row!22!Equipments] 
					,NULL AS [Row!22!Target] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!ObjectGet] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!Executor] 
												,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!FullFileName] 
					,NULL AS [Row!32!FileName] 
												,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
				FROM [Catalog].[Equipment] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
			 
	UNION ALL 
 
	SELECT 
	11 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!11] 
				,NULL AS [EquipmentsHistory!11] 
				,NULL AS [Files!11] 
				,NULL AS [Parameters!11] 
										,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Period] 
					,NULL AS [Row!12!Clients] 
					,NULL AS [Row!12!StatusEquipment] 
					,NULL AS [Row!12!ContractSale] 
					,NULL AS [Row!12!CantractService] 
					,NULL AS [Row!12!ContactForEquipment] 
					,NULL AS [Row!12!Info] 
					,NULL AS [Row!12!Equipment] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Period] 
					,NULL AS [Row!12!Client] 
					,NULL AS [Row!12!Equipments] 
					,NULL AS [Row!12!Target] 
					,NULL AS [Row!12!Result] 
					,NULL AS [Row!12!ObjectGet] 
					,NULL AS [Row!12!Comment] 
					,NULL AS [Row!12!Executor] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!FullFileName] 
					,NULL AS [Row!12!FileName] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Parameter] 
					,NULL AS [Row!12!Val] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	12 AS Tag, 11 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!11] 
				,NULL AS [EquipmentsHistory!11] 
				,NULL AS [Files!11] 
				,NULL AS [Parameters!11] 
										 ,T.[Id] AS [Row!12!Id]								 ,T.[Ref] AS [Row!12!Ref]								 ,T.[LineNumber] AS [Row!12!LineNumber]								 ,T.[Period] AS [Row!12!Period]								 ,T.[Clients] AS [Row!12!Clients]								 ,T.[StatusEquipment] AS [Row!12!StatusEquipment]								 ,T.[ContractSale] AS [Row!12!ContractSale]								 ,T.[CantractService] AS [Row!12!CantractService]								 ,T.[ContactForEquipment] AS [Row!12!ContactForEquipment]								 ,T.[Info] AS [Row!12!Info]								 ,T.[Equipment] AS [Row!12!Equipment]															 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Period]								 ,NULL AS [Row!12!Client]								 ,NULL AS [Row!12!Equipments]								 ,NULL AS [Row!12!Target]								 ,NULL AS [Row!12!Result]								 ,NULL AS [Row!12!ObjectGet]								 ,NULL AS [Row!12!Comment]								 ,NULL AS [Row!12!Executor]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!FullFileName]								 ,NULL AS [Row!12!FileName]												 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!Parameter]								 ,NULL AS [Row!12!Val]				FROM @Ids Ids 
	JOIN [Catalog].[Equipment_Equipments] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	21 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!21] 
				,NULL AS [EquipmentsHistory!21] 
				,NULL AS [Files!21] 
				,NULL AS [Parameters!21] 
										,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Period] 
					,NULL AS [Row!22!Clients] 
					,NULL AS [Row!22!StatusEquipment] 
					,NULL AS [Row!22!ContractSale] 
					,NULL AS [Row!22!CantractService] 
					,NULL AS [Row!22!ContactForEquipment] 
					,NULL AS [Row!22!Info] 
					,NULL AS [Row!22!Equipment] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Period] 
					,NULL AS [Row!22!Client] 
					,NULL AS [Row!22!Equipments] 
					,NULL AS [Row!22!Target] 
					,NULL AS [Row!22!Result] 
					,NULL AS [Row!22!ObjectGet] 
					,NULL AS [Row!22!Comment] 
					,NULL AS [Row!22!Executor] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!FullFileName] 
					,NULL AS [Row!22!FileName] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Parameter] 
					,NULL AS [Row!22!Val] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	22 AS Tag, 21 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!21] 
				,NULL AS [EquipmentsHistory!21] 
				,NULL AS [Files!21] 
				,NULL AS [Parameters!21] 
													 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Period]								 ,NULL AS [Row!22!Clients]								 ,NULL AS [Row!22!StatusEquipment]								 ,NULL AS [Row!22!ContractSale]								 ,NULL AS [Row!22!CantractService]								 ,NULL AS [Row!22!ContactForEquipment]								 ,NULL AS [Row!22!Info]								 ,NULL AS [Row!22!Equipment]									 ,T.[Id] AS [Row!22!Id]								 ,T.[Ref] AS [Row!22!Ref]								 ,T.[LineNumber] AS [Row!22!LineNumber]								 ,T.[Period] AS [Row!22!Period]								 ,T.[Client] AS [Row!22!Client]								 ,T.[Equipments] AS [Row!22!Equipments]								 ,T.[Target] AS [Row!22!Target]								 ,T.[Result] AS [Row!22!Result]								 ,T.[ObjectGet] AS [Row!22!ObjectGet]								 ,T.[Comment] AS [Row!22!Comment]								 ,T.[Executor] AS [Row!22!Executor]															 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!FullFileName]								 ,NULL AS [Row!22!FileName]												 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Parameter]								 ,NULL AS [Row!22!Val]				FROM @Ids Ids 
	JOIN [Catalog].[Equipment_EquipmentsHistory] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	31 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!31] 
				,NULL AS [EquipmentsHistory!31] 
				,NULL AS [Files!31] 
				,NULL AS [Parameters!31] 
										,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Period] 
					,NULL AS [Row!32!Clients] 
					,NULL AS [Row!32!StatusEquipment] 
					,NULL AS [Row!32!ContractSale] 
					,NULL AS [Row!32!CantractService] 
					,NULL AS [Row!32!ContactForEquipment] 
					,NULL AS [Row!32!Info] 
					,NULL AS [Row!32!Equipment] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Period] 
					,NULL AS [Row!32!Client] 
					,NULL AS [Row!32!Equipments] 
					,NULL AS [Row!32!Target] 
					,NULL AS [Row!32!Result] 
					,NULL AS [Row!32!ObjectGet] 
					,NULL AS [Row!32!Comment] 
					,NULL AS [Row!32!Executor] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!FullFileName] 
					,NULL AS [Row!32!FileName] 
									,NULL AS [Row!32!Id] 
					,NULL AS [Row!32!Ref] 
					,NULL AS [Row!32!LineNumber] 
					,NULL AS [Row!32!Parameter] 
					,NULL AS [Row!32!Val] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	32 AS Tag, 31 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!31] 
				,NULL AS [EquipmentsHistory!31] 
				,NULL AS [Files!31] 
				,NULL AS [Parameters!31] 
													 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Period]								 ,NULL AS [Row!32!Clients]								 ,NULL AS [Row!32!StatusEquipment]								 ,NULL AS [Row!32!ContractSale]								 ,NULL AS [Row!32!CantractService]								 ,NULL AS [Row!32!ContactForEquipment]								 ,NULL AS [Row!32!Info]								 ,NULL AS [Row!32!Equipment]												 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Period]								 ,NULL AS [Row!32!Client]								 ,NULL AS [Row!32!Equipments]								 ,NULL AS [Row!32!Target]								 ,NULL AS [Row!32!Result]								 ,NULL AS [Row!32!ObjectGet]								 ,NULL AS [Row!32!Comment]								 ,NULL AS [Row!32!Executor]									 ,T.[Id] AS [Row!32!Id]								 ,T.[Ref] AS [Row!32!Ref]								 ,T.[LineNumber] AS [Row!32!LineNumber]								 ,T.[FullFileName] AS [Row!32!FullFileName]								 ,T.[FileName] AS [Row!32!FileName]															 ,NULL AS [Row!32!Id]								 ,NULL AS [Row!32!Ref]								 ,NULL AS [Row!32!LineNumber]								 ,NULL AS [Row!32!Parameter]								 ,NULL AS [Row!32!Val]				FROM @Ids Ids 
	JOIN [Catalog].[Equipment_Files] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	41 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!41] 
				,NULL AS [EquipmentsHistory!41] 
				,NULL AS [Files!41] 
				,NULL AS [Parameters!41] 
										,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Period] 
					,NULL AS [Row!42!Clients] 
					,NULL AS [Row!42!StatusEquipment] 
					,NULL AS [Row!42!ContractSale] 
					,NULL AS [Row!42!CantractService] 
					,NULL AS [Row!42!ContactForEquipment] 
					,NULL AS [Row!42!Info] 
					,NULL AS [Row!42!Equipment] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Period] 
					,NULL AS [Row!42!Client] 
					,NULL AS [Row!42!Equipments] 
					,NULL AS [Row!42!Target] 
					,NULL AS [Row!42!Result] 
					,NULL AS [Row!42!ObjectGet] 
					,NULL AS [Row!42!Comment] 
					,NULL AS [Row!42!Executor] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!FullFileName] 
					,NULL AS [Row!42!FileName] 
									,NULL AS [Row!42!Id] 
					,NULL AS [Row!42!Ref] 
					,NULL AS [Row!42!LineNumber] 
					,NULL AS [Row!42!Parameter] 
					,NULL AS [Row!42!Val] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	42 AS Tag, 41 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!Predefined],NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Description],NULL AS [Row!2!Code],NULL AS [Row!2!SKU]			,NULL AS [Equipments!41] 
				,NULL AS [EquipmentsHistory!41] 
				,NULL AS [Files!41] 
				,NULL AS [Parameters!41] 
													 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!Period]								 ,NULL AS [Row!42!Clients]								 ,NULL AS [Row!42!StatusEquipment]								 ,NULL AS [Row!42!ContractSale]								 ,NULL AS [Row!42!CantractService]								 ,NULL AS [Row!42!ContactForEquipment]								 ,NULL AS [Row!42!Info]								 ,NULL AS [Row!42!Equipment]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!Period]								 ,NULL AS [Row!42!Client]								 ,NULL AS [Row!42!Equipments]								 ,NULL AS [Row!42!Target]								 ,NULL AS [Row!42!Result]								 ,NULL AS [Row!42!ObjectGet]								 ,NULL AS [Row!42!Comment]								 ,NULL AS [Row!42!Executor]												 ,NULL AS [Row!42!Id]								 ,NULL AS [Row!42!Ref]								 ,NULL AS [Row!42!LineNumber]								 ,NULL AS [Row!42!FullFileName]								 ,NULL AS [Row!42!FileName]									 ,T.[Id] AS [Row!42!Id]								 ,T.[Ref] AS [Row!42!Ref]								 ,T.[LineNumber] AS [Row!42!LineNumber]								 ,T.[Parameter] AS [Row!42!Parameter]								 ,T.[Val] AS [Row!42!Val]							FROM @Ids Ids 
	JOIN [Catalog].[Equipment_Parameters] T ON T.Ref = Ids.Id 
 
	 
	ORDER BY [Row!2!Id], Tag ,[Row!12!LineNumber],[Row!22!LineNumber],[Row!32!LineNumber],[Row!42!LineNumber] 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EquipmentOptions]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EquipmentOptions] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EquipmentOptions] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EquipmentOptions_ListValues]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ALTER COLUMN [Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_EquipmentOptions_ListValues] on [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ADD CONSTRAINT [PK_Catalog_EquipmentOptions_ListValues] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ADD CONSTRAINT [UQ_Catalog_EquipmentOptions_ListValues_Key] UNIQUE NONCLUSTERED  ([Ref], [Val])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EventOptions_ListValues]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ALTER COLUMN [Val] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_EventOptions_ListValues] on [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ADD CONSTRAINT [PK_Catalog_EventOptions_ListValues] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ADD CONSTRAINT [UQ_Catalog_EventOptions_ListValues_Key] UNIQUE NONCLUSTERED  ([Ref], [Val])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EventOptions]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EventOptions] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[EventOptions] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task]'
GO
CREATE TABLE [Document].[Task] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL, 
[DeletionMark] [bit] NOT NULL, 
[Posted] [bit] NULL, 
[Date] [datetime2] NOT NULL, 
[Number] [nvarchar] (9) COLLATE Cyrillic_General_CI_AS NULL, 
[Description] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Client] [uniqueidentifier] NOT NULL, 
[Equipment] [uniqueidentifier] NULL, 
[Event] [uniqueidentifier] NULL, 
[TaskType] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Task] on [Document].[Task]'
GO
ALTER TABLE [Document].[Task] ADD CONSTRAINT [PK_Document_Task] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_insert]'
GO
 
 
 
 
CREATE PROCEDURE [Document].[Task_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Posted BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(1000),		@Client UNIQUEIDENTIFIER,		@Equipment UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@TaskType NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Task]( 
		[Timestamp], [IsDeleted], 
				[Id],				[DeletionMark],				[Posted],				[Date],				[Number],				[Description],				[Client],				[Equipment],				[Event],				[TaskType]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@DeletionMark,				@Posted,				@Date,				@Number,				@Description,				@Client,				@Equipment,				@Event,				@TaskType			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[RIM] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[RIM] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[RIM] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_update]'
GO
 
CREATE PROCEDURE [Document].[Task_adm_update] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Posted BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(1000),		@Client UNIQUEIDENTIFIER,		@Equipment UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@TaskType NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Task] SET 
				[Id] = @Id,				[DeletionMark] = @DeletionMark,				[Posted] = @Posted,				[Date] = @Date,				[Number] = @Number,				[Description] = @Description,				[Client] = @Client,				[Equipment] = @Equipment,				[Event] = @Event,				[TaskType] = @TaskType			WHERE Id = @Id AND 
	( 1=0 OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Posted] <> @Posted OR ([Posted] IS NULL AND NOT @Posted IS NULL) OR (NOT [Posted] IS NULL AND @Posted IS NULL)  OR [Date] <> @Date OR ([Date] IS NULL AND NOT @Date IS NULL) OR (NOT [Date] IS NULL AND @Date IS NULL)  OR [Number] <> @Number OR ([Number] IS NULL AND NOT @Number IS NULL) OR (NOT [Number] IS NULL AND @Number IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Client] <> @Client OR ([Client] IS NULL AND NOT @Client IS NULL) OR (NOT [Client] IS NULL AND @Client IS NULL)  OR [Equipment] <> @Equipment OR ([Equipment] IS NULL AND NOT @Equipment IS NULL) OR (NOT [Equipment] IS NULL AND @Equipment IS NULL)  OR [Event] <> @Event OR ([Event] IS NULL AND NOT @Event IS NULL) OR (NOT [Event] IS NULL AND @Event IS NULL)  OR [TaskType] <> @TaskType OR ([TaskType] IS NULL AND NOT @TaskType IS NULL) OR (NOT [TaskType] IS NULL AND @TaskType IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SettingMobileApplication]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SettingMobileApplication] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SettingMobileApplication] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[SettingMobileApplication] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_markdelete]'
GO
 
CREATE PROCEDURE [Document].[Task_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@DeletionMark BIT,		@Posted BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(1000),		@Client UNIQUEIDENTIFIER,		@Equipment UNIQUEIDENTIFIER,		@Event UNIQUEIDENTIFIER,		@TaskType NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Task] WHERE Id = @Id) 
	UPDATE [Document].[Task] SET 
				[Id] = @Id,				[DeletionMark] = @DeletionMark,				[Posted] = @Posted,				[Date] = @Date,				[Number] = @Number,				[Description] = @Description,				[Client] = @Client,				[Equipment] = @Equipment,				[Event] = @Event,				[TaskType] = @TaskType			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Document].[Task] 
	( 
				[Id],				[DeletionMark],				[Posted],				[Date],				[Number],				[Description],				[Client],				[Equipment],				[Event],				[TaskType]			) 
	VALUES 
	( 
				@Id,				@DeletionMark,				@Posted,				@Date,				@Number,				@Description,				@Client,				@Equipment,				@Event,				@TaskType			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Document.Task',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EquipmentOptions_ListValues_adm_insert]'
GO
 
 
ALTER PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[EquipmentOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[TypesDepartures]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[TypesDepartures] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[TypesDepartures] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[TypesDepartures] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_delete]'
GO
 
CREATE PROCEDURE [Document].[Task_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Document].[Task] WHERE Id = @Id 
	UPDATE [Document].[Task_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[EquipmentOptions_ListValues_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_EquipmentOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[EquipmentOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Val]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[CheckList_Actions]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[CheckList_Actions] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_CheckList_Actions] on [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] ADD CONSTRAINT [PK_Document_CheckList_Actions] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] ADD CONSTRAINT [UQ_Document_CheckList_Actions_Key] UNIQUE NONCLUSTERED  ([Ref], [Action])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[CheckList]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[CheckList] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[CheckList] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[CheckList] ALTER COLUMN [Description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_exists]'
GO
 
CREATE PROCEDURE [Document].[Task_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Document].[Task] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [DeletionMark] [bit] NOT NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [DetailedDescription] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [TargInteractions] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Document].[Event] ALTER COLUMN [ResultInteractions] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Document].[Task_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Document.Task' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Document].[Task] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets]'
GO
CREATE TABLE [Document].[Task_Targets] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Task_Targets__Id__71BCD978] DEFAULT (newsequentialid()), 
[Ref] [uniqueidentifier] NOT NULL, 
[LineNumber] [int] NULL, 
[Description] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[IsDone] [bit] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Task_Targets] on [Document].[Task_Targets]'
GO
ALTER TABLE [Document].[Task_Targets] ADD CONSTRAINT [PK_Document_Task_Targets] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Task_Targets]'
GO
ALTER TABLE [Document].[Task_Targets] ADD CONSTRAINT [UQ_Document_Task_Targets_Key] UNIQUE NONCLUSTERED  ([Ref], [Description])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_insert]'
GO
 
 
CREATE PROCEDURE [Document].[Task_Targets_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Description NVARCHAR(1000),		@IsDone BIT	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Task_Targets]( 
		[Ref],[LineNumber],[Description],[IsDone]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Description,@IsDone	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EquipmentOptions_ListValues_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[EquipmentOptions_ListValues] WHERE [Ref] = @Ref AND ([Val] = @Val OR ([Val] IS NULL AND @Val IS NULL))) 
	UPDATE [Catalog].[EquipmentOptions_ListValues] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Val] = @Val			WHERE [Ref] = @Ref AND [Val] = @Val AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Catalog].[EquipmentOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Task_Targets_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Task_Targets] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Task_Targets]( 
		[Ref],[LineNumber],[Description],[IsDone]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Description],[IsDone]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[EquipmentOptions_ListValues_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_EquipmentOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[EquipmentOptions_ListValues] SET 
				[LineNumber] = D.[LineNumber],				[Val] = D.[Val]			FROM [Catalog].[EquipmentOptions_ListValues] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Val] <> D.[Val] ) 
 
	INSERT INTO [Catalog].[EquipmentOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Val]		FROM @Data D 
		LEFT JOIN [Catalog].[EquipmentOptions_ListValues] T ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[EquipmentOptions_ListValues] 
	FROM [Catalog].[EquipmentOptions_ListValues] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND D.[Val] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status]'
GO
CREATE TABLE [Document].[Task_Status] 
( 
[Timestamp] [bigint] NULL, 
[IsDeleted] [bit] NULL, 
[KeyFieldTimestamp] [bigint] NULL, 
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Task_Status__Id__72B0FDB1] DEFAULT (newsequentialid()), 
[Ref] [uniqueidentifier] NOT NULL, 
[LineNumber] [int] NULL, 
[CommentContractor] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Status] [uniqueidentifier] NULL, 
[UserMA] [uniqueidentifier] NULL, 
[ActualEndDate] [datetime2] NULL, 
[CloseEvent] [uniqueidentifier] NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Document_Task_Status] on [Document].[Task_Status]'
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [PK_Document_Task_Status] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Task_Status]'
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [UQ_Document_Task_Status_Key] UNIQUE NONCLUSTERED  ([Ref], [CommentContractor])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Document].[Task_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Document].[Task] E 
	JOIN [Document].[Task_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Task_Targets] E 
	JOIN [Document].[Task_Targets_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
		UNION 
	SELECT E.Ref  
	FROM [Document].[Task_Status] E 
	JOIN [Document].[Task_Status_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/)	 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Document.Task' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Posted],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!Description],NULL AS [Row!2!Client],NULL AS [Row!2!Equipment],NULL AS [Row!2!Event],NULL AS [Row!2!TaskType]						,NULL AS [Targets!11] 
						,NULL AS [Status!21] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Description] 
					,NULL AS [Row!12!IsDone] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!CommentContractor] 
					,NULL AS [Row!22!Status] 
					,NULL AS [Row!22!UserMA] 
					,NULL AS [Row!22!ActualEndDate] 
					,NULL AS [Row!22!CloseEvent] 
			 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[DeletionMark] AS [Row!2!DeletionMark],H.[Posted] AS [Row!2!Posted],H.[Date] AS [Row!2!Date],H.[Number] AS [Row!2!Number],H.[Description] AS [Row!2!Description],H.[Client] AS [Row!2!Client],H.[Equipment] AS [Row!2!Equipment],H.[Event] AS [Row!2!Event],H.[TaskType] AS [Row!2!TaskType]						,NULL AS [Targets!11] 
						,NULL AS [Status!21] 
															,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Description] 
					,NULL AS [Row!12!IsDone] 
												,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!CommentContractor] 
					,NULL AS [Row!22!Status] 
					,NULL AS [Row!22!UserMA] 
					,NULL AS [Row!22!ActualEndDate] 
					,NULL AS [Row!22!CloseEvent] 
				FROM [Document].[Task] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
			 
	UNION ALL 
 
	SELECT 
	11 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Posted],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!Description],NULL AS [Row!2!Client],NULL AS [Row!2!Equipment],NULL AS [Row!2!Event],NULL AS [Row!2!TaskType]			,NULL AS [Targets!11] 
				,NULL AS [Status!11] 
										,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!Description] 
					,NULL AS [Row!12!IsDone] 
									,NULL AS [Row!12!Id] 
					,NULL AS [Row!12!Ref] 
					,NULL AS [Row!12!LineNumber] 
					,NULL AS [Row!12!CommentContractor] 
					,NULL AS [Row!12!Status] 
					,NULL AS [Row!12!UserMA] 
					,NULL AS [Row!12!ActualEndDate] 
					,NULL AS [Row!12!CloseEvent] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	12 AS Tag, 11 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Posted],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!Description],NULL AS [Row!2!Client],NULL AS [Row!2!Equipment],NULL AS [Row!2!Event],NULL AS [Row!2!TaskType]			,NULL AS [Targets!11] 
				,NULL AS [Status!11] 
										 ,T.[Id] AS [Row!12!Id]								 ,T.[Ref] AS [Row!12!Ref]								 ,T.[LineNumber] AS [Row!12!LineNumber]								 ,T.[Description] AS [Row!12!Description]								 ,T.[IsDone] AS [Row!12!IsDone]															 ,NULL AS [Row!12!Id]								 ,NULL AS [Row!12!Ref]								 ,NULL AS [Row!12!LineNumber]								 ,NULL AS [Row!12!CommentContractor]								 ,NULL AS [Row!12!Status]								 ,NULL AS [Row!12!UserMA]								 ,NULL AS [Row!12!ActualEndDate]								 ,NULL AS [Row!12!CloseEvent]				FROM @Ids Ids 
	JOIN [Document].[Task_Targets] T ON T.Ref = Ids.Id 
 
		 
	UNION ALL 
 
	SELECT 
	21 AS Tag, 2 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Posted],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!Description],NULL AS [Row!2!Client],NULL AS [Row!2!Equipment],NULL AS [Row!2!Event],NULL AS [Row!2!TaskType]			,NULL AS [Targets!21] 
				,NULL AS [Status!21] 
										,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!Description] 
					,NULL AS [Row!22!IsDone] 
									,NULL AS [Row!22!Id] 
					,NULL AS [Row!22!Ref] 
					,NULL AS [Row!22!LineNumber] 
					,NULL AS [Row!22!CommentContractor] 
					,NULL AS [Row!22!Status] 
					,NULL AS [Row!22!UserMA] 
					,NULL AS [Row!22!ActualEndDate] 
					,NULL AS [Row!22!CloseEvent] 
				FROM @Ids Ids 
 
	UNION ALL 
 
	SELECT 
	22 AS Tag, 21 AS Parent, 
	NULL AS [Entity!1!Name], 
	Ids.Id AS [Row!2!Id], 
	NULL AS [Row!2!DeletionMark],NULL AS [Row!2!Posted],NULL AS [Row!2!Date],NULL AS [Row!2!Number],NULL AS [Row!2!Description],NULL AS [Row!2!Client],NULL AS [Row!2!Equipment],NULL AS [Row!2!Event],NULL AS [Row!2!TaskType]			,NULL AS [Targets!21] 
				,NULL AS [Status!21] 
													 ,NULL AS [Row!22!Id]								 ,NULL AS [Row!22!Ref]								 ,NULL AS [Row!22!LineNumber]								 ,NULL AS [Row!22!Description]								 ,NULL AS [Row!22!IsDone]									 ,T.[Id] AS [Row!22!Id]								 ,T.[Ref] AS [Row!22!Ref]								 ,T.[LineNumber] AS [Row!22!LineNumber]								 ,T.[CommentContractor] AS [Row!22!CommentContractor]								 ,T.[Status] AS [Row!22!Status]								 ,T.[UserMA] AS [Row!22!UserMA]								 ,T.[ActualEndDate] AS [Row!22!ActualEndDate]								 ,T.[CloseEvent] AS [Row!22!CloseEvent]							FROM @Ids Ids 
	JOIN [Document].[Task_Status] T ON T.Ref = Ids.Id 
 
	 
	ORDER BY [Row!2!Id], Tag ,[Row!12!LineNumber],[Row!22!LineNumber] 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_clear]'
GO
 
CREATE PROCEDURE [Document].[Task_Targets_adm_clear] @Ref UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Task_Targets] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EquipmentOptions_ListValues_adm_delete]'
GO
 
ALTER PROCEDURE [Catalog].[EquipmentOptions_ListValues_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Val NVARCHAR(100) 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[EquipmentOptions_ListValues] 
	WHERE [Ref] = @Ref AND [Val] = @Val	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[CheckListStatus]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[CheckListStatus] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_selectkeys]'
GO
 
 
CREATE PROCEDURE [Document].[Task_Targets_adm_selectkeys] @Ref UNIQUEIDENTIFIER AS 
	SELECT [Ref],[LineNumber],[Description],[IsDone]	FROM [Document].[Task_Targets] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[FoReminders]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[FoReminders] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_update]'
GO
 
CREATE PROCEDURE [Document].[Task_Targets_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Description NVARCHAR(1000),		@IsDone BIT	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Task_Targets] WHERE [Ref] = @Ref AND ([Description] = @Description OR ([Description] IS NULL AND @Description IS NULL))) 
	UPDATE [Document].[Task_Targets] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Description] = @Description,				[IsDone] = @IsDone			WHERE [Ref] = @Ref AND [Description] = @Description AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [IsDone] <> @IsDone ) 
	ELSE 
	INSERT INTO [Document].[Task_Targets]( 
		[Ref],[LineNumber],[Description],[IsDone]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Description,@IsDone	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[ResultEvent]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[ResultEvent] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Task_Targets_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Task_Targets] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Task_Targets] SET 
				[LineNumber] = D.[LineNumber],				[Description] = D.[Description],				[IsDone] = D.[IsDone]			FROM [Document].[Task_Targets] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Description] = D.[Description] OR (T.[Description] IS NULL AND D.[Description] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Description] <> D.[Description] OR T.[IsDone] <> D.[IsDone] ) 
 
	INSERT INTO [Document].[Task_Targets]( 
		[Ref],[LineNumber],[Description],[IsDone]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Description],D.[IsDone]		FROM @Data D 
		LEFT JOIN [Document].[Task_Targets] T ON T.Ref = @Ref AND (T.[Description] = D.[Description] OR (T.[Description] IS NULL AND D.[Description] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Task_Targets] 
	FROM [Document].[Task_Targets] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Description] = D.[Description] OR (T.[Description] IS NULL AND D.[Description] IS NULL))	WHERE T.Ref = @Ref AND D.[Description] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[StatsNeedNum]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[StatsNeedNum] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Targets_adm_delete]'
GO
 
CREATE PROCEDURE [Document].[Task_Targets_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Description NVARCHAR(1000) 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Task_Targets] 
	WHERE [Ref] = @Ref AND [Description] = @Description	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[StatusEquipment]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[StatusEquipment] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Document].[Task_Status_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@CommentContractor NVARCHAR(1000),		@Status UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@ActualEndDate DATETIME2,		@CloseEvent UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Task_Status]( 
		[Ref],[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@CommentContractor,@Status,@UserMA,@ActualEndDate,@CloseEvent	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Enum].[StatusImportance]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Enum].[StatusImportance] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Task_Status_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Task_Status] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Task_Status]( 
		[Ref],[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]	) 
	SELECT  
		@Ref 
		,[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks]'
GO
CREATE TABLE [Enum].[StatusTasks] 
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
PRINT N'Creating primary key [PK_Enum_StatusTasks] on [Enum].[StatusTasks]'
GO
ALTER TABLE [Enum].[StatusTasks] ADD CONSTRAINT [PK_Enum_StatusTasks] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_getchanges]'
GO
 
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_getchanges] @SessionId UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DECLARE @DateFrom DATETIME, @DateTo DATETIME 
	SELECT @DateFrom = LastTime FROM [admin].LastSyncTime 
	SELECT @DateTo = StartTime FROM [admin].SyncSession WHERE [Id] = @SessionId 
	IF @DateFrom IS NULL OR @DateTo IS NULL 
	  RAISERROR('Invalid interval', 16, 1) 
 
	DECLARE @Ids TABLE(Id UNIQUEIDENTIFIER) 
	INSERT @Ids  
	SELECT E.[Id]  
	FROM [Enum].[StatusTasks] E 
	JOIN [Enum].[StatusTasks_tracking] T ON T.[Id] = E.[Id] 
	WHERE T.[last_change_datetime] BETWEEN @DateFrom AND @DateTo AND (NOT T.update_scope_local_id IS NULL/* OR NOT T.create_scope_local_id IS NULL*/) 
	 
	SELECT 
	1 AS Tag, NULL AS Parent, 
	'Enum.StatusTasks' AS [Entity!1!Name], 
	NULL AS [Row!2!Id], 
	NULL AS [Row!2!Name],NULL AS [Row!2!Description]						 
	UNION ALL 
 
	SELECT 
	2 AS Tag, 1 AS Parent, 
	NULL AS [Entity!1!Name], 
	H.[Id] AS [Row!2!Id], 
	H.[Name] AS [Row!2!Name],H.[Description] AS [Row!2!Description]							FROM [Enum].[StatusTasks] H 
	JOIN @Ids Ids ON Ids.Id = H.Id 
 
		 
	ORDER BY [Row!2!Id], Tag  
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_clear]'
GO
 
CREATE PROCEDURE [Document].[Task_Status_adm_clear] @Ref UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Task_Status] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EventOptions_ListValues_adm_insert]'
GO
 
 
ALTER PROCEDURE [Catalog].[EventOptions_ListValues_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[EventOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_selectkeys]'
GO
 
 
CREATE PROCEDURE [Document].[Task_Status_adm_selectkeys] @Ref UNIQUEIDENTIFIER AS 
	SELECT [Ref],[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]	FROM [Document].[Task_Status] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[EventOptions_ListValues_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[EventOptions_ListValues_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_EventOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[EventOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Val]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_update]'
GO
 
CREATE PROCEDURE [Document].[Task_Status_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@CommentContractor NVARCHAR(1000),		@Status UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@ActualEndDate DATETIME2,		@CloseEvent UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Task_Status] WHERE [Ref] = @Ref AND ([CommentContractor] = @CommentContractor OR ([CommentContractor] IS NULL AND @CommentContractor IS NULL))) 
	UPDATE [Document].[Task_Status] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[CommentContractor] = @CommentContractor,				[Status] = @Status,				[UserMA] = @UserMA,				[ActualEndDate] = @ActualEndDate,				[CloseEvent] = @CloseEvent			WHERE [Ref] = @Ref AND [CommentContractor] = @CommentContractor AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [Status] <> @Status OR [UserMA] <> @UserMA OR [ActualEndDate] <> @ActualEndDate OR [CloseEvent] <> @CloseEvent ) 
	ELSE 
	INSERT INTO [Document].[Task_Status]( 
		[Ref],[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@CommentContractor,@Status,@UserMA,@ActualEndDate,@CloseEvent	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Document].[Task_Status_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Task_Status] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Task_Status] SET 
				[LineNumber] = D.[LineNumber],				[CommentContractor] = D.[CommentContractor],				[Status] = D.[Status],				[UserMA] = D.[UserMA],				[ActualEndDate] = D.[ActualEndDate],				[CloseEvent] = D.[CloseEvent]			FROM [Document].[Task_Status] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[CommentContractor] = D.[CommentContractor] OR (T.[CommentContractor] IS NULL AND D.[CommentContractor] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[CommentContractor] <> D.[CommentContractor] OR T.[Status] <> D.[Status] OR T.[UserMA] <> D.[UserMA] OR T.[ActualEndDate] <> D.[ActualEndDate] OR T.[CloseEvent] <> D.[CloseEvent] ) 
 
	INSERT INTO [Document].[Task_Status]( 
		[Ref],[LineNumber],[CommentContractor],[Status],[UserMA],[ActualEndDate],[CloseEvent]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[CommentContractor],D.[Status],D.[UserMA],D.[ActualEndDate],D.[CloseEvent]		FROM @Data D 
		LEFT JOIN [Document].[Task_Status] T ON T.Ref = @Ref AND (T.[CommentContractor] = D.[CommentContractor] OR (T.[CommentContractor] IS NULL AND D.[CommentContractor] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Document].[Task_Status] 
	FROM [Document].[Task_Status] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[CommentContractor] = D.[CommentContractor] OR (T.[CommentContractor] IS NULL AND D.[CommentContractor] IS NULL))	WHERE T.Ref = @Ref AND D.[CommentContractor] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[Client_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@Address NVARCHAR(1000),		@Contractor UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Client]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Latitude],				[Longitude],				[Address],				[Contractor]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Latitude,				@Longitude,				@Address,				@Contractor			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Task_Status_adm_delete]'
GO
 
CREATE PROCEDURE [Document].[Task_Status_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@CommentContractor NVARCHAR(1000) 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Document].[Task_Status] 
	WHERE [Ref] = @Ref AND [CommentContractor] = @CommentContractor	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EventOptions_ListValues_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[EventOptions_ListValues_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[EventOptions_ListValues] WHERE [Ref] = @Ref AND ([Val] = @Val OR ([Val] IS NULL AND @Val IS NULL))) 
	UPDATE [Catalog].[EventOptions_ListValues] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Val] = @Val			WHERE [Ref] = @Ref AND [Val] = @Val AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Catalog].[EventOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[Client_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@Address NVARCHAR(1000),		@Contractor UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Client] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Latitude] = @Latitude,				[Longitude] = @Longitude,				[Address] = @Address,				[Contractor] = @Contractor			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [Latitude] <> @Latitude OR ([Latitude] IS NULL AND NOT @Latitude IS NULL) OR (NOT [Latitude] IS NULL AND @Latitude IS NULL)  OR [Longitude] <> @Longitude OR ([Longitude] IS NULL AND NOT @Longitude IS NULL) OR (NOT [Longitude] IS NULL AND @Longitude IS NULL)  OR [Address] <> @Address OR ([Address] IS NULL AND NOT @Address IS NULL) OR (NOT [Address] IS NULL AND @Address IS NULL)  OR [Contractor] <> @Contractor OR ([Contractor] IS NULL AND NOT @Contractor IS NULL) OR (NOT [Contractor] IS NULL AND @Contractor IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[EventOptions_ListValues_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[EventOptions_ListValues_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_EventOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[EventOptions_ListValues] SET 
				[LineNumber] = D.[LineNumber],				[Val] = D.[Val]			FROM [Catalog].[EventOptions_ListValues] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Val] <> D.[Val] ) 
 
	INSERT INTO [Catalog].[EventOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Val]		FROM @Data D 
		LEFT JOIN [Catalog].[EventOptions_ListValues] T ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[EventOptions_ListValues] 
	FROM [Catalog].[EventOptions_ListValues] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND D.[Val] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[Client_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@Address NVARCHAR(1000),		@Contractor UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Client] WHERE Id = @Id) 
	UPDATE [Catalog].[Client] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Latitude] = @Latitude,				[Longitude] = @Longitude,				[Address] = @Address,				[Contractor] = @Contractor			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[Client] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Latitude],				[Longitude],				[Address],				[Contractor]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Latitude,				@Longitude,				@Address,				@Contractor			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.Client',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[EventOptions_ListValues_adm_delete]'
GO
 
ALTER PROCEDURE [Catalog].[EventOptions_ListValues_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Val NVARCHAR(100) 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[EventOptions_ListValues] 
	WHERE [Ref] = @Ref AND [Val] = @Val	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[RIM_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[RIM]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code],				[Price],				[Service],				[SKU],				[Unit]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code,				@Price,				@Service,				@SKU,				@Unit			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[RIM_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[RIM] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code,				[Price] = @Price,				[Service] = @Service,				[SKU] = @SKU,				[Unit] = @Unit			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [IsFolder] <> @IsFolder OR ([IsFolder] IS NULL AND NOT @IsFolder IS NULL) OR (NOT [IsFolder] IS NULL AND @IsFolder IS NULL)  OR [Parent] <> @Parent OR ([Parent] IS NULL AND NOT @Parent IS NULL) OR (NOT [Parent] IS NULL AND @Parent IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [Price] <> @Price OR ([Price] IS NULL AND NOT @Price IS NULL) OR (NOT [Price] IS NULL AND @Price IS NULL)  OR [Service] <> @Service OR ([Service] IS NULL AND NOT @Service IS NULL) OR (NOT [Service] IS NULL AND @Service IS NULL)  OR [SKU] <> @SKU OR ([SKU] IS NULL AND NOT @SKU IS NULL) OR (NOT [SKU] IS NULL AND @SKU IS NULL)  OR [Unit] <> @Unit OR ([Unit] IS NULL AND NOT @Unit IS NULL) OR (NOT [Unit] IS NULL AND @Unit IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[RIM_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[RIM_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@IsFolder BIT,		@Parent UNIQUEIDENTIFIER,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Price DECIMAL(15,2),		@Service BIT,		@SKU UNIQUEIDENTIFIER,		@Unit NVARCHAR(5)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[RIM] WHERE Id = @Id) 
	UPDATE [Catalog].[RIM] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[IsFolder] = @IsFolder,				[Parent] = @Parent,				[Description] = @Description,				[Code] = @Code,				[Price] = @Price,				[Service] = @Service,				[SKU] = @SKU,				[Unit] = @Unit			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[RIM] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[IsFolder],				[Parent],				[Description],				[Code],				[Price],				[Service],				[SKU],				[Unit]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@IsFolder,				@Parent,				@Description,				@Code,				@Price,				@Service,				@SKU,				@Unit			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.RIM',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Files_adm_insert]'
GO
 
 
ALTER PROCEDURE [Catalog].[Client_Files_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Client_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Client_Files_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[Client_Files_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Client_Files] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Client_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,[LineNumber],[FullFileName],[FileName]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SettingMobileApplication_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[SettingMobileApplication_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@DataType UNIQUEIDENTIFIER,		@LogicValue BIT,		@NumericValue INT	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[SettingMobileApplication]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[DataType],				[LogicValue],				[NumericValue]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@DataType,				@LogicValue,				@NumericValue			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Files_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[Client_Files_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Client_Files] WHERE [Ref] = @Ref AND ([FullFileName] = @FullFileName OR ([FullFileName] IS NULL AND @FullFileName IS NULL)) AND ([FileName] = @FileName OR ([FileName] IS NULL AND @FileName IS NULL))) 
	UPDATE [Catalog].[Client_Files] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[FullFileName] = @FullFileName,				[FileName] = @FileName			WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Catalog].[Client_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SettingMobileApplication_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[SettingMobileApplication_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@DataType UNIQUEIDENTIFIER,		@LogicValue BIT,		@NumericValue INT	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[SettingMobileApplication] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[DataType] = @DataType,				[LogicValue] = @LogicValue,				[NumericValue] = @NumericValue			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [DataType] <> @DataType OR ([DataType] IS NULL AND NOT @DataType IS NULL) OR (NOT [DataType] IS NULL AND @DataType IS NULL)  OR [LogicValue] <> @LogicValue OR ([LogicValue] IS NULL AND NOT @LogicValue IS NULL) OR (NOT [LogicValue] IS NULL AND @LogicValue IS NULL)  OR [NumericValue] <> @NumericValue OR ([NumericValue] IS NULL AND NOT @NumericValue IS NULL) OR (NOT [NumericValue] IS NULL AND @NumericValue IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Client_Files_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[Client_Files_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Client_Files] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Client_Files] SET 
				[LineNumber] = D.[LineNumber],				[FullFileName] = D.[FullFileName],				[FileName] = D.[FileName]			FROM [Catalog].[Client_Files] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[FullFileName] <> D.[FullFileName] OR T.[FileName] <> D.[FileName] ) 
 
	INSERT INTO [Catalog].[Client_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[FullFileName],D.[FileName]		FROM @Data D 
		LEFT JOIN [Catalog].[Client_Files] T ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[Client_Files] 
	FROM [Catalog].[Client_Files] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[FullFileName] = D.[FullFileName] OR (T.[FullFileName] IS NULL AND D.[FullFileName] IS NULL)) AND (T.[FileName] = D.[FileName] OR (T.[FileName] IS NULL AND D.[FileName] IS NULL))	WHERE T.Ref = @Ref AND D.[FullFileName] IS NULL AND D.[FileName] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[SettingMobileApplication_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[SettingMobileApplication_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@DataType UNIQUEIDENTIFIER,		@LogicValue BIT,		@NumericValue INT	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[SettingMobileApplication] WHERE Id = @Id) 
	UPDATE [Catalog].[SettingMobileApplication] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[DataType] = @DataType,				[LogicValue] = @LogicValue,				[NumericValue] = @NumericValue			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[SettingMobileApplication] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[DataType],				[LogicValue],				[NumericValue]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@DataType,				@LogicValue,				@NumericValue			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.SettingMobileApplication',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Client_Files_adm_delete]'
GO
 
ALTER PROCEDURE [Catalog].[Client_Files_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@FullFileName NVARCHAR(1000) 
		,@FileName UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Client_Files] 
	WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[TypesDepartures_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Catalog].[TypesDepartures_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[TypesDepartures]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[TypesDepartures_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[TypesDepartures_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[TypesDepartures] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[TypesDepartures_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[TypesDepartures_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[TypesDepartures] WHERE Id = @Id) 
	UPDATE [Catalog].[TypesDepartures] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[TypesDepartures] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.TypesDepartures',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[CheckList_adm_insert]'
GO
 
 
 
ALTER PROCEDURE [Document].[CheckList_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(100),		@Project NVARCHAR(500),		@Status UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[CheckList]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[Description],				[Project],				[Status]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@Description,				@Project,				@Status			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[CheckList_adm_update]'
GO
 
ALTER PROCEDURE [Document].[CheckList_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(100),		@Project NVARCHAR(500),		@Status UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Document].[CheckList] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[Description] = @Description,				[Project] = @Project,				[Status] = @Status			WHERE Id = @Id AND 
	( 1=0 OR [Posted] <> @Posted OR ([Posted] IS NULL AND NOT @Posted IS NULL) OR (NOT [Posted] IS NULL AND @Posted IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Date] <> @Date OR ([Date] IS NULL AND NOT @Date IS NULL) OR (NOT [Date] IS NULL AND @Date IS NULL)  OR [Number] <> @Number OR ([Number] IS NULL AND NOT @Number IS NULL) OR (NOT [Number] IS NULL AND @Number IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Project] <> @Project OR ([Project] IS NULL AND NOT @Project IS NULL) OR (NOT [Project] IS NULL AND @Project IS NULL)  OR [Status] <> @Status OR ([Status] IS NULL AND NOT @Status IS NULL) OR (NOT [Status] IS NULL AND @Status IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[CheckList_adm_markdelete]'
GO
 
ALTER PROCEDURE [Document].[CheckList_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@Description NVARCHAR(100),		@Project NVARCHAR(500),		@Status UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[CheckList] WHERE Id = @Id) 
	UPDATE [Document].[CheckList] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[Description] = @Description,				[Project] = @Project,				[Status] = @Status			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Document].[CheckList] 
	( 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[Description],				[Project],				[Status]			) 
	VALUES 
	( 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@Description,				@Project,				@Status			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Document.CheckList',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Contacts_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Catalog].[Contacts_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Position NVARCHAR(100),		@Tel NVARCHAR(100),		@EMail NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Contacts]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Position],				[Tel],				[EMail]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Position,				@Tel,				@EMail			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Contacts_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[Contacts_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Position NVARCHAR(100),		@Tel NVARCHAR(100),		@EMail NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Contacts] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Position] = @Position,				[Tel] = @Tel,				[EMail] = @EMail			WHERE Id = @Id AND 
	( 1=0 OR [Predefined] <> @Predefined OR ([Predefined] IS NULL AND NOT @Predefined IS NULL) OR (NOT [Predefined] IS NULL AND @Predefined IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  OR [Code] <> @Code OR ([Code] IS NULL AND NOT @Code IS NULL) OR (NOT [Code] IS NULL AND @Code IS NULL)  OR [Position] <> @Position OR ([Position] IS NULL AND NOT @Position IS NULL) OR (NOT [Position] IS NULL AND @Position IS NULL)  OR [Tel] <> @Tel OR ([Tel] IS NULL AND NOT @Tel IS NULL) OR (NOT [Tel] IS NULL AND @Tel IS NULL)  OR [EMail] <> @EMail OR ([EMail] IS NULL AND NOT @EMail IS NULL) OR (NOT [EMail] IS NULL AND @EMail IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Contacts_adm_markdelete]'
GO
 
ALTER PROCEDURE [Catalog].[Contacts_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Predefined BIT,		@DeletionMark BIT,		@Description NVARCHAR(100),		@Code NVARCHAR(9),		@Position NVARCHAR(100),		@Tel NVARCHAR(100),		@EMail NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Contacts] WHERE Id = @Id) 
	UPDATE [Catalog].[Contacts] SET 
				[Id] = @Id,				[Predefined] = @Predefined,				[DeletionMark] = @DeletionMark,				[Description] = @Description,				[Code] = @Code,				[Position] = @Position,				[Tel] = @Tel,				[EMail] = @EMail			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Catalog].[Contacts] 
	( 
				[Id],				[Predefined],				[DeletionMark],				[Description],				[Code],				[Position],				[Tel],				[EMail]			) 
	VALUES 
	( 
				@Id,				@Predefined,				@DeletionMark,				@Description,				@Code,				@Position,				@Tel,				@EMail			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Catalog.Contacts',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_insert]'
GO
 
 
 
 
ALTER PROCEDURE [Document].[Event_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[ApplicationJustification],				[Client],				[DivisionSource],				[KindEvent],				[AnySale],				[AnyProblem],				[StartDatePlan],				[EndDatePlan],				[ActualStartDate],				[ActualEndDate],				[Author],				[UserMA],				[Comment],				[DetailedDescription],				[CommentContractor],				[TargInteractions],				[ResultInteractions],				[Status],				[Latitude],				[Longitude],				[GPSTime],				[ContactVisiting],				[TypesDepartures],				[Importance]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@ApplicationJustification,				@Client,				@DivisionSource,				@KindEvent,				@AnySale,				@AnyProblem,				@StartDatePlan,				@EndDatePlan,				@ActualStartDate,				@ActualEndDate,				@Author,				@UserMA,				@Comment,				@DetailedDescription,				@CommentContractor,				@TargInteractions,				@ResultInteractions,				@Status,				@Latitude,				@Longitude,				@GPSTime,				@ContactVisiting,				@TypesDepartures,				@Importance			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_update]'
GO
 
ALTER PROCEDURE [Document].[Event_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	UPDATE [Document].[Event] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[ApplicationJustification] = @ApplicationJustification,				[Client] = @Client,				[DivisionSource] = @DivisionSource,				[KindEvent] = @KindEvent,				[AnySale] = @AnySale,				[AnyProblem] = @AnyProblem,				[StartDatePlan] = @StartDatePlan,				[EndDatePlan] = @EndDatePlan,				[ActualStartDate] = @ActualStartDate,				[ActualEndDate] = @ActualEndDate,				[Author] = @Author,				[UserMA] = @UserMA,				[Comment] = @Comment,				[DetailedDescription] = @DetailedDescription,				[CommentContractor] = @CommentContractor,				[TargInteractions] = @TargInteractions,				[ResultInteractions] = @ResultInteractions,				[Status] = @Status,				[Latitude] = @Latitude,				[Longitude] = @Longitude,				[GPSTime] = @GPSTime,				[ContactVisiting] = @ContactVisiting,				[TypesDepartures] = @TypesDepartures,				[Importance] = @Importance			WHERE Id = @Id AND 
	( 1=0 OR [Posted] <> @Posted OR ([Posted] IS NULL AND NOT @Posted IS NULL) OR (NOT [Posted] IS NULL AND @Posted IS NULL)  OR [DeletionMark] <> @DeletionMark OR ([DeletionMark] IS NULL AND NOT @DeletionMark IS NULL) OR (NOT [DeletionMark] IS NULL AND @DeletionMark IS NULL)  OR [Date] <> @Date OR ([Date] IS NULL AND NOT @Date IS NULL) OR (NOT [Date] IS NULL AND @Date IS NULL)  OR [Number] <> @Number OR ([Number] IS NULL AND NOT @Number IS NULL) OR (NOT [Number] IS NULL AND @Number IS NULL)  OR [ApplicationJustification] <> @ApplicationJustification OR ([ApplicationJustification] IS NULL AND NOT @ApplicationJustification IS NULL) OR (NOT [ApplicationJustification] IS NULL AND @ApplicationJustification IS NULL)  OR [Client] <> @Client OR ([Client] IS NULL AND NOT @Client IS NULL) OR (NOT [Client] IS NULL AND @Client IS NULL)  OR [DivisionSource] <> @DivisionSource OR ([DivisionSource] IS NULL AND NOT @DivisionSource IS NULL) OR (NOT [DivisionSource] IS NULL AND @DivisionSource IS NULL)  OR [KindEvent] <> @KindEvent OR ([KindEvent] IS NULL AND NOT @KindEvent IS NULL) OR (NOT [KindEvent] IS NULL AND @KindEvent IS NULL)  OR [AnySale] <> @AnySale OR ([AnySale] IS NULL AND NOT @AnySale IS NULL) OR (NOT [AnySale] IS NULL AND @AnySale IS NULL)  OR [AnyProblem] <> @AnyProblem OR ([AnyProblem] IS NULL AND NOT @AnyProblem IS NULL) OR (NOT [AnyProblem] IS NULL AND @AnyProblem IS NULL)  OR [StartDatePlan] <> @StartDatePlan OR ([StartDatePlan] IS NULL AND NOT @StartDatePlan IS NULL) OR (NOT [StartDatePlan] IS NULL AND @StartDatePlan IS NULL)  OR [EndDatePlan] <> @EndDatePlan OR ([EndDatePlan] IS NULL AND NOT @EndDatePlan IS NULL) OR (NOT [EndDatePlan] IS NULL AND @EndDatePlan IS NULL)  OR [ActualStartDate] <> @ActualStartDate OR ([ActualStartDate] IS NULL AND NOT @ActualStartDate IS NULL) OR (NOT [ActualStartDate] IS NULL AND @ActualStartDate IS NULL)  OR [ActualEndDate] <> @ActualEndDate OR ([ActualEndDate] IS NULL AND NOT @ActualEndDate IS NULL) OR (NOT [ActualEndDate] IS NULL AND @ActualEndDate IS NULL)  OR [Author] <> @Author OR ([Author] IS NULL AND NOT @Author IS NULL) OR (NOT [Author] IS NULL AND @Author IS NULL)  OR [UserMA] <> @UserMA OR ([UserMA] IS NULL AND NOT @UserMA IS NULL) OR (NOT [UserMA] IS NULL AND @UserMA IS NULL)  OR [Comment] <> @Comment OR ([Comment] IS NULL AND NOT @Comment IS NULL) OR (NOT [Comment] IS NULL AND @Comment IS NULL)  OR [DetailedDescription] <> @DetailedDescription OR ([DetailedDescription] IS NULL AND NOT @DetailedDescription IS NULL) OR (NOT [DetailedDescription] IS NULL AND @DetailedDescription IS NULL)  OR [CommentContractor] <> @CommentContractor OR ([CommentContractor] IS NULL AND NOT @CommentContractor IS NULL) OR (NOT [CommentContractor] IS NULL AND @CommentContractor IS NULL)  OR [TargInteractions] <> @TargInteractions OR ([TargInteractions] IS NULL AND NOT @TargInteractions IS NULL) OR (NOT [TargInteractions] IS NULL AND @TargInteractions IS NULL)  OR [ResultInteractions] <> @ResultInteractions OR ([ResultInteractions] IS NULL AND NOT @ResultInteractions IS NULL) OR (NOT [ResultInteractions] IS NULL AND @ResultInteractions IS NULL)  OR [Status] <> @Status OR ([Status] IS NULL AND NOT @Status IS NULL) OR (NOT [Status] IS NULL AND @Status IS NULL)  OR [Latitude] <> @Latitude OR ([Latitude] IS NULL AND NOT @Latitude IS NULL) OR (NOT [Latitude] IS NULL AND @Latitude IS NULL)  OR [Longitude] <> @Longitude OR ([Longitude] IS NULL AND NOT @Longitude IS NULL) OR (NOT [Longitude] IS NULL AND @Longitude IS NULL)  OR [GPSTime] <> @GPSTime OR ([GPSTime] IS NULL AND NOT @GPSTime IS NULL) OR (NOT [GPSTime] IS NULL AND @GPSTime IS NULL)  OR [ContactVisiting] <> @ContactVisiting OR ([ContactVisiting] IS NULL AND NOT @ContactVisiting IS NULL) OR (NOT [ContactVisiting] IS NULL AND @ContactVisiting IS NULL)  OR [TypesDepartures] <> @TypesDepartures OR ([TypesDepartures] IS NULL AND NOT @TypesDepartures IS NULL) OR (NOT [TypesDepartures] IS NULL AND @TypesDepartures IS NULL)  OR [Importance] <> @Importance OR ([Importance] IS NULL AND NOT @Importance IS NULL) OR (NOT [Importance] IS NULL AND @Importance IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_adm_markdelete]'
GO
 
ALTER PROCEDURE [Document].[Event_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Posted BIT,		@DeletionMark BIT,		@Date DATETIME2,		@Number NVARCHAR(9),		@ApplicationJustification NVARCHAR(500),		@Client UNIQUEIDENTIFIER,		@DivisionSource NVARCHAR(500),		@KindEvent UNIQUEIDENTIFIER,		@AnySale BIT,		@AnyProblem BIT,		@StartDatePlan DATETIME2,		@EndDatePlan DATETIME2,		@ActualStartDate DATETIME2,		@ActualEndDate DATETIME2,		@Author UNIQUEIDENTIFIER,		@UserMA UNIQUEIDENTIFIER,		@Comment NVARCHAR(1000),		@DetailedDescription NVARCHAR(1000),		@CommentContractor NVARCHAR(1000),		@TargInteractions NVARCHAR(100),		@ResultInteractions NVARCHAR(100),		@Status UNIQUEIDENTIFIER,		@Latitude DECIMAL(12,8),		@Longitude DECIMAL(12,8),		@GPSTime DATETIME2,		@ContactVisiting UNIQUEIDENTIFIER,		@TypesDepartures UNIQUEIDENTIFIER,		@Importance UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event] WHERE Id = @Id) 
	UPDATE [Document].[Event] SET 
				[Id] = @Id,				[Posted] = @Posted,				[DeletionMark] = @DeletionMark,				[Date] = @Date,				[Number] = @Number,				[ApplicationJustification] = @ApplicationJustification,				[Client] = @Client,				[DivisionSource] = @DivisionSource,				[KindEvent] = @KindEvent,				[AnySale] = @AnySale,				[AnyProblem] = @AnyProblem,				[StartDatePlan] = @StartDatePlan,				[EndDatePlan] = @EndDatePlan,				[ActualStartDate] = @ActualStartDate,				[ActualEndDate] = @ActualEndDate,				[Author] = @Author,				[UserMA] = @UserMA,				[Comment] = @Comment,				[DetailedDescription] = @DetailedDescription,				[CommentContractor] = @CommentContractor,				[TargInteractions] = @TargInteractions,				[ResultInteractions] = @ResultInteractions,				[Status] = @Status,				[Latitude] = @Latitude,				[Longitude] = @Longitude,				[GPSTime] = @GPSTime,				[ContactVisiting] = @ContactVisiting,				[TypesDepartures] = @TypesDepartures,				[Importance] = @Importance			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Document].[Event] 
	( 
				[Id],				[Posted],				[DeletionMark],				[Date],				[Number],				[ApplicationJustification],				[Client],				[DivisionSource],				[KindEvent],				[AnySale],				[AnyProblem],				[StartDatePlan],				[EndDatePlan],				[ActualStartDate],				[ActualEndDate],				[Author],				[UserMA],				[Comment],				[DetailedDescription],				[CommentContractor],				[TargInteractions],				[ResultInteractions],				[Status],				[Latitude],				[Longitude],				[GPSTime],				[ContactVisiting],				[TypesDepartures],				[Importance]			) 
	VALUES 
	( 
				@Id,				@Posted,				@DeletionMark,				@Date,				@Number,				@ApplicationJustification,				@Client,				@DivisionSource,				@KindEvent,				@AnySale,				@AnyProblem,				@StartDatePlan,				@EndDatePlan,				@ActualStartDate,				@ActualEndDate,				@Author,				@UserMA,				@Comment,				@DetailedDescription,				@CommentContractor,				@TargInteractions,				@ResultInteractions,				@Status,				@Latitude,				@Longitude,				@GPSTime,				@ContactVisiting,				@TypesDepartures,				@Importance			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Document.Event',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_insert] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Enum].[StatusTasks]( 
		[Timestamp], [IsDeleted], 
				[Id],				[Name],				[Description]			)  
	VALUES 
	( 
		1, 0, 
				@Id,				@Name,				@Description			)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_update]'
GO
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_update] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	UPDATE [Enum].[StatusTasks] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id AND 
	( 1=0 OR [Name] <> @Name OR ([Name] IS NULL AND NOT @Name IS NULL) OR (NOT [Name] IS NULL AND @Name IS NULL)  OR [Description] <> @Description OR ([Description] IS NULL AND NOT @Description IS NULL) OR (NOT [Description] IS NULL AND @Description IS NULL)  ) 
	DELETE FROM [admin].[DeletedObjects] WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ClientOptions_ListValues_adm_insert]'
GO
 
 
ALTER PROCEDURE [Catalog].[ClientOptions_ListValues_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[ClientOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_markdelete]'
GO
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_markdelete] 
		@Id UNIQUEIDENTIFIER,		@Name NVARCHAR(100),		@Description NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Enum].[StatusTasks] WHERE Id = @Id) 
	UPDATE [Enum].[StatusTasks] SET 
				[Id] = @Id,				[Name] = @Name,				[Description] = @Description			WHERE Id = @Id 
	ELSE 
	INSERT INTO [Enum].[StatusTasks] 
	( 
				[Id],				[Name],				[Description]			) 
	VALUES 
	( 
				@Id,				@Name,				@Description			) 
	IF NOT EXISTS(SELECT * FROM [admin].[DeletedObjects] WHERE [Id] = @Id) 
		INSERT INTO [admin].[DeletedObjects]([Id],[Entity],[CreationDate]) VALUES (@Id,'Enum.StatusTasks',GETDATE())
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[ClientOptions_ListValues_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[ClientOptions_ListValues_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_ClientOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[ClientOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Val]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_delete]'
GO
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_delete] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
--	DELETE FROM [Enum].[StatusTasks] WHERE Id = @Id 
	UPDATE [Enum].[StatusTasks_tracking] SET 
		[sync_row_is_tombstone] = 1,  
		[local_update_peer_key] = 0,  
		[update_scope_local_id] = NULL,  
		[last_change_datetime] = GETDATE()  
	WHERE Id = @Id 
	UPDATE [admin].[DeletedObjects] SET [DeletionDate] = GETDATE() WHERE [Id] = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Files_adm_insert]'
GO
 
 
ALTER PROCEDURE [Document].[Event_Files_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_exists]'
GO
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_exists] @Id UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	SELECT Id FROM [Enum].[StatusTasks] WHERE Id = @Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Document].[Event_Files_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Document].[Event_Files_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Document].[T_Event_Files] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Document].[Event_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	) 
	SELECT  
		@Ref 
		,[LineNumber],[FullFileName],[FileName]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Enum].[StatusTasks_adm_getnotexisting]'
GO
 
CREATE PROCEDURE [Enum].[StatusTasks_adm_getnotexisting] @Xml XML AS 
	SET NOCOUNT ON 
	SELECT  
	1 AS Tag,  
	NULL AS Parent, 
	'Enum.StatusTasks' AS [Entity!1!Name], 
	NULL AS [Row!2!Id] 
	UNION ALL 
	SELECT  
		2 AS Tag,  
		1 AS Parent, 
		NULL AS [Entity!1Name], 
		T1.c.value('@Id','UNIQUEIDENTIFIER') AS [Row!2!Id] 
	FROM @Xml.nodes('//Row') T1(c) 
	LEFT JOIN [Enum].[StatusTasks] T2 ON T2.Id = T1.c.value('@Id','UNIQUEIDENTIFIER') 
	WHERE T2.Id IS NULL 
	ORDER BY 2,1 
	FOR XML EXPLICIT
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ClientOptions_ListValues_adm_update]'
GO
 
ALTER PROCEDURE [Catalog].[ClientOptions_ListValues_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Val NVARCHAR(100)	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[ClientOptions_ListValues] WHERE [Ref] = @Ref AND ([Val] = @Val OR ([Val] IS NULL AND @Val IS NULL))) 
	UPDATE [Catalog].[ClientOptions_ListValues] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Val] = @Val			WHERE [Ref] = @Ref AND [Val] = @Val AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Catalog].[ClientOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Val	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[ClientOptions_ListValues_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[ClientOptions_ListValues_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_ClientOptions_ListValues] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[ClientOptions_ListValues] SET 
				[LineNumber] = D.[LineNumber],				[Val] = D.[Val]			FROM [Catalog].[ClientOptions_ListValues] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Val] <> D.[Val] ) 
 
	INSERT INTO [Catalog].[ClientOptions_ListValues]( 
		[Ref],[LineNumber],[Val]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Val]		FROM @Data D 
		LEFT JOIN [Catalog].[ClientOptions_ListValues] T ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[ClientOptions_ListValues] 
	FROM [Catalog].[ClientOptions_ListValues] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Val] = D.[Val] OR (T.[Val] IS NULL AND D.[Val] IS NULL))	WHERE T.Ref = @Ref AND D.[Val] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Document].[Event_Files_adm_update]'
GO
 
ALTER PROCEDURE [Document].[Event_Files_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@FullFileName NVARCHAR(1000),		@FileName UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Document].[Event_Files] WHERE [Ref] = @Ref AND ([FullFileName] = @FullFileName OR ([FullFileName] IS NULL AND @FullFileName IS NULL)) AND ([FileName] = @FileName OR ([FileName] IS NULL AND @FileName IS NULL))) 
	UPDATE [Document].[Event_Files] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[FullFileName] = @FullFileName,				[FileName] = @FileName			WHERE [Ref] = @Ref AND [FullFileName] = @FullFileName AND [FileName] = @FileName AND  
	( 1=0 OR [LineNumber] <> @LineNumber ) 
	ELSE 
	INSERT INTO [Document].[Event_Files]( 
		[Ref],[LineNumber],[FullFileName],[FileName]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@FullFileName,@FileName	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[ClientOptions_ListValues_adm_delete]'
GO
 
ALTER PROCEDURE [Catalog].[ClientOptions_ListValues_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Val NVARCHAR(100) 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[ClientOptions_ListValues] 
	WHERE [Ref] = @Ref AND [Val] = @Val	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[PicturePaths]'
GO
CREATE TABLE [dbo].[PicturePaths] 
( 
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__PicturePaths__Id__1411F17C] DEFAULT (newsequentialid()), 
[Name] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL, 
[PrivatePath] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL, 
[SharedPath] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_PicturePaths] on [dbo].[PicturePaths]'
GO
ALTER TABLE [dbo].[PicturePaths] ADD CONSTRAINT [PK_PicturePaths] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [Name_ASC_Unclustered_Unique] on [dbo].[PicturePaths]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [Name_ASC_Unclustered_Unique] ON [dbo].[PicturePaths] ([Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[PicturePaths]'
GO
ALTER TABLE [dbo].[PicturePaths] ADD CONSTRAINT [UQ_PicturePaths_Name] UNIQUE NONCLUSTERED  ([Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__AsyncUpl__3214EC06835E520D] on [admin].[AsyncUploadSession]'
GO
ALTER TABLE [admin].[AsyncUploadSession] ADD CONSTRAINT [PK__AsyncUpl__3214EC06835E520D] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__DeletedO__3214EC0692135ADC] on [admin].[DeletedObjects]'
GO
ALTER TABLE [admin].[DeletedObjects] ADD CONSTRAINT [PK__DeletedO__3214EC0692135ADC] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__FileSyst__77387D07CD0ED4F8] on [admin].[FileSystem]'
GO
ALTER TABLE [admin].[FileSystem] ADD CONSTRAINT [PK__FileSyst__77387D07CD0ED4F8] PRIMARY KEY NONCLUSTERED  ([Date])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__LastSync__C96133CDCEA4EEC4] on [admin].[LastSyncTime]'
GO
ALTER TABLE [admin].[LastSyncTime] ADD CONSTRAINT [PK__LastSync__C96133CDCEA4EEC4] PRIMARY KEY NONCLUSTERED  ([LastTime])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__SyncSess__3214EC0627948A64] on [admin].[SyncSession]'
GO
ALTER TABLE [admin].[SyncSession] ADD CONSTRAINT [PK__SyncSess__3214EC0627948A64] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK__Telegram__5C7E359E5A20C0BD] on [admin].[Telegram]'
GO
ALTER TABLE [admin].[Telegram] ADD CONSTRAINT [PK__Telegram__5C7E359E5A20C0BD] PRIMARY KEY NONCLUSTERED  ([Phone])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] ADD CONSTRAINT [DF__Actions_Valu__Id__5BCD9859] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ADD CONSTRAINT [DF__ClientOption__Id__5F9E293D] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD CONSTRAINT [DF__Client_Conta__Id__5DB5E0CB] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] ADD CONSTRAINT [DF__Client_Files__Id__5CC1BC92] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD CONSTRAINT [DF__Client_Param__Id__5EAA0504] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ADD CONSTRAINT [DF__EquipmentOpt__Id__664B26CC] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] ADD CONSTRAINT [DF__Equipment_Fi__Id__627A95E8] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD CONSTRAINT [DF__Equipment_Pa__Id__636EBA21] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ADD CONSTRAINT [DF__EventOptions__Id__673F4B05] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] ADD CONSTRAINT [DF__User_Bag__Id__6462DE5A] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD CONSTRAINT [DF__User_Remains__Id__65570293] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] ADD CONSTRAINT [DF__CheckList_Ac__Id__68336F3E] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [DF__Event_CheckL__Id__6CF8245B] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] ADD CONSTRAINT [DF__Event_Equipm__Id__6A1BB7B0] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] ADD CONSTRAINT [DF__Event_Files__Id__69279377] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] ADD CONSTRAINT [DF__Event_Parame__Id__6C040022] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] ADD CONSTRAINT [DF__Event_Photos__Id__6B0FDBE9] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD CONSTRAINT [DF__Event_Servic__Id__6EE06CCD] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD CONSTRAINT [DF__Event_TypeDe__Id__6DEC4894] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD CONSTRAINT [DF__NeedMat_Mati__Id__6FD49106] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] ADD CONSTRAINT [DF__Reminder_Pho__Id__70C8B53F] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Task_Status]'
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [FK_Document_Task_Status_Document_Task_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Task] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [FK_Document_Task__Status_Enum_StatusTasks_Status] FOREIGN KEY ([Status]) REFERENCES [Enum].[StatusTasks] ([Id]) 
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [FK_Document_Task__Status_Catalog_User_UserMA] FOREIGN KEY ([UserMA]) REFERENCES [Catalog].[User] ([Id]) 
GO
ALTER TABLE [Document].[Task_Status] ADD CONSTRAINT [FK_Document_Task__Status_Document_Event_CloseEvent] FOREIGN KEY ([CloseEvent]) REFERENCES [Document].[Event] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Task_Targets]'
GO
ALTER TABLE [Document].[Task_Targets] ADD CONSTRAINT [FK_Document_Task_Targets_Document_Task_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Task] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Task]'
GO
ALTER TABLE [Document].[Task] ADD CONSTRAINT [FK_Document_Task_Catalog_Client_Client] FOREIGN KEY ([Client]) REFERENCES [Catalog].[Client] ([Id]) 
GO
ALTER TABLE [Document].[Task] ADD CONSTRAINT [FK_Document_Task_Catalog_Equipment_Equipment] FOREIGN KEY ([Equipment]) REFERENCES [Catalog].[Equipment] ([Id]) 
GO
ALTER TABLE [Document].[Task] ADD CONSTRAINT [FK_Document_Task_Document_Event_Event] FOREIGN KEY ([Event]) REFERENCES [Document].[Event] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Actions_ValueList]'
GO
ALTER TABLE [Catalog].[Actions_ValueList] ADD CONSTRAINT [FK_Catalog_Actions_ValueList_Catalog_Actions_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Actions] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[ClientOptions_ListValues]'
GO
ALTER TABLE [Catalog].[ClientOptions_ListValues] ADD CONSTRAINT [FK_Catalog_ClientOptions_ListValues_Catalog_ClientOptions_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[ClientOptions] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Client_Contacts]'
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD CONSTRAINT [FK_Catalog_Client_Contacts_Catalog_Client_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Client] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[Client_Contacts] ADD CONSTRAINT [FK_Catalog_Client__Contacts_Catalog_Contacts_Contact] FOREIGN KEY ([Contact]) REFERENCES [Catalog].[Contacts] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Client_Files]'
GO
ALTER TABLE [Catalog].[Client_Files] ADD CONSTRAINT [FK_Catalog_Client_Files_Catalog_Client_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Client] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Client_Parameters]'
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD CONSTRAINT [FK_Catalog_Client_Parameters_Catalog_Client_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Client] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[Client_Parameters] ADD CONSTRAINT [FK_Catalog_Client__Parameters_Catalog_ClientOptions_Parameter] FOREIGN KEY ([Parameter]) REFERENCES [Catalog].[ClientOptions] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[EquipmentOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EquipmentOptions_ListValues] ADD CONSTRAINT [FK_Catalog_EquipmentOptions_ListValues_Catalog_EquipmentOptions_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[EquipmentOptions] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Equipment_Files]'
GO
ALTER TABLE [Catalog].[Equipment_Files] ADD CONSTRAINT [FK_Catalog_Equipment_Files_Catalog_Equipment_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Equipment] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Equipment_Parameters]'
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD CONSTRAINT [FK_Catalog_Equipment_Parameters_Catalog_Equipment_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Equipment] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[Equipment_Parameters] ADD CONSTRAINT [FK_Catalog_Equipment__Parameters_Catalog_EquipmentOptions_Parameter] FOREIGN KEY ([Parameter]) REFERENCES [Catalog].[EquipmentOptions] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[EventOptions_ListValues]'
GO
ALTER TABLE [Catalog].[EventOptions_ListValues] ADD CONSTRAINT [FK_Catalog_EventOptions_ListValues_Catalog_EventOptions_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[EventOptions] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[User_Bag]'
GO
ALTER TABLE [Catalog].[User_Bag] ADD CONSTRAINT [FK_Catalog_User_Bag_Catalog_User_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[User] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[User_Bag] ADD CONSTRAINT [FK_Catalog_User__Bag_Catalog_RIM_Materials] FOREIGN KEY ([Materials]) REFERENCES [Catalog].[RIM] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[User_RemainsNorms]'
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD CONSTRAINT [FK_Catalog_User_RemainsNorms_Catalog_User_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[User] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[User_RemainsNorms] ADD CONSTRAINT [FK_Catalog_User__RemainsNorms_Catalog_RIM_Materials] FOREIGN KEY ([Materials]) REFERENCES [Catalog].[RIM] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[CheckList_Actions]'
GO
ALTER TABLE [Document].[CheckList_Actions] ADD CONSTRAINT [FK_Document_CheckList_Actions_Document_CheckList_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[CheckList] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[CheckList_Actions] ADD CONSTRAINT [FK_Document_CheckList__Actions_Catalog_Actions_Action] FOREIGN KEY ([Action]) REFERENCES [Catalog].[Actions] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_CheckList]'
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [FK_Document_Event_CheckList_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [FK_Document_Event__CheckList_Catalog_Actions_Action] FOREIGN KEY ([Action]) REFERENCES [Catalog].[Actions] ([Id]) 
GO
ALTER TABLE [Document].[Event_CheckList] ADD CONSTRAINT [FK_Document_Event__CheckList_Document_CheckList_CheckListRef] FOREIGN KEY ([CheckListRef]) REFERENCES [Document].[CheckList] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_Equipments]'
GO
ALTER TABLE [Document].[Event_Equipments] ADD CONSTRAINT [FK_Document_Event_Equipments_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_Equipments] ADD CONSTRAINT [FK_Document_Event__Equipments_Catalog_Equipment_Equipment] FOREIGN KEY ([Equipment]) REFERENCES [Catalog].[Equipment] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_Files]'
GO
ALTER TABLE [Document].[Event_Files] ADD CONSTRAINT [FK_Document_Event_Files_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_Parameters]'
GO
ALTER TABLE [Document].[Event_Parameters] ADD CONSTRAINT [FK_Document_Event_Parameters_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_Parameters] ADD CONSTRAINT [FK_Document_Event__Parameters_Catalog_EventOptions_Parameter] FOREIGN KEY ([Parameter]) REFERENCES [Catalog].[EventOptions] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_Photos]'
GO
ALTER TABLE [Document].[Event_Photos] ADD CONSTRAINT [FK_Document_Event_Photos_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_ServicesMaterials]'
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD CONSTRAINT [FK_Document_Event_ServicesMaterials_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_ServicesMaterials] ADD CONSTRAINT [FK_Document_Event__ServicesMaterials_Catalog_RIM_SKU] FOREIGN KEY ([SKU]) REFERENCES [Catalog].[RIM] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Event_TypeDepartures]'
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD CONSTRAINT [FK_Document_Event_TypeDepartures_Document_Event_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Event] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[Event_TypeDepartures] ADD CONSTRAINT [FK_Document_Event__TypeDepartures_Catalog_TypesDepartures_TypeDeparture] FOREIGN KEY ([TypeDeparture]) REFERENCES [Catalog].[TypesDepartures] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[NeedMat_Matireals]'
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD CONSTRAINT [FK_Document_NeedMat_Matireals_Document_NeedMat_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[NeedMat] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Document].[NeedMat_Matireals] ADD CONSTRAINT [FK_Document_NeedMat__Matireals_Catalog_RIM_SKU] FOREIGN KEY ([SKU]) REFERENCES [Catalog].[RIM] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Document].[Reminder_Photo]'
GO
ALTER TABLE [Document].[Reminder_Photo] ADD CONSTRAINT [FK_Document_Reminder_Photo_Document_Reminder_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Document].[Reminder] ([Id]) ON DELETE CASCADE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering extended properties'
GO
EXEC sp_updateextendedproperty N'MS_Description', N'Глобальная конфигурация (базовые параметры)', 'SCHEMA', N'dbo', 'TABLE', N'dbConfig', NULL, NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO











PRINT N'Dropping foreign keys from [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] DROP CONSTRAINT [FK_Catalog_Equipment_EquipmentsHistory_Catalog_Equipment_EntityId]
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] DROP CONSTRAINT [FK_Catalog_Equipment__EquipmentsHistory_Catalog_Client_Client]
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] DROP CONSTRAINT [FK_Catalog_Equipment__EquipmentsHistory_Catalog_Equipment_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] DROP CONSTRAINT [FK_Catalog_Equipment_Equipments_Catalog_Equipment_EntityId]
GO
ALTER TABLE [Catalog].[Equipment_Equipments] DROP CONSTRAINT [FK_Catalog_Equipment__Equipments_Catalog_Client_Clients]
GO
ALTER TABLE [Catalog].[Equipment_Equipments] DROP CONSTRAINT [FK_Catalog_Equipment__Equipments_Catalog_Equipment_Equipment]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] DROP CONSTRAINT [PK_Catalog_Equipment_EquipmentsHistory]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] DROP CONSTRAINT [DF__Equipment_Eq__Id__1BE81D6E]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] DROP CONSTRAINT [PK_Catalog_Equipment_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] DROP CONSTRAINT [DF__Equipment_Eq__Id__1AF3F935]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Equipment_EquipmentsHistory_Key] from [Catalog].[Equipment_EquipmentsHistory]'
GO
DROP INDEX [UQ_Catalog_Equipment_EquipmentsHistory_Key] ON [Catalog].[Equipment_EquipmentsHistory]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping index [UQ_Catalog_Equipment_Equipments_Key] from [Catalog].[Equipment_Equipments]'
GO
DROP INDEX [UQ_Catalog_Equipment_Equipments_Key] ON [Catalog].[Equipment_Equipments]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_update]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_update]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_selectkeys]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_selectkeys]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_insert]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_insert]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_delete]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_delete]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_clear]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_clear]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_update]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_update]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_selectkeys]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_selectkeys]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_insert]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_insert]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_delete]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_delete]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_clear]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_clear]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_EquiementsHistory_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[Equipment_EquiementsHistory_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_update_batch_all]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_update_batch_all]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping [Catalog].[Equipment_Equiements_adm_insert_batch]'
GO
DROP PROCEDURE [Catalog].[Equipment_Equiements_adm_insert_batch]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping types'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_Equipment_EquiementsHistory]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DROP TYPE [Catalog].[T_Equipment_Equiements]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating types'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_Equipment_EquipmentsHistory] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Period] [datetime2] NULL, 
[Client] [uniqueidentifier] NULL, 
[Equipments] [uniqueidentifier] NULL, 
[Target] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
[Result] [uniqueidentifier] NULL, 
[ObjectGet] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Comment] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Executor] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([Period], [Client], [Equipments]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
CREATE TYPE [Catalog].[T_Equipment_Equipments] AS TABLE 
( 
[LineNumber] [int] NULL, 
[Period] [datetime2] NULL, 
[Clients] [uniqueidentifier] NULL, 
[StatusEquipment] [uniqueidentifier] NULL, 
[ContractSale] [uniqueidentifier] NULL, 
[CantractService] [uniqueidentifier] NULL, 
[ContactForEquipment] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL, 
[Info] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL, 
[Equipment] [uniqueidentifier] NULL, 
UNIQUE NONCLUSTERED  ([Period], [Clients], [Equipment]) 
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_Equipments]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ALTER COLUMN [ContactForEquipment] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ALTER COLUMN [Info] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Equipment_Equipments] on [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [PK_Catalog_Equipment_Equipments] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [UQ_Catalog_Equipment_Equipments_Key] UNIQUE NONCLUSTERED  ([Ref], [Period], [Clients], [Equipment])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_insert]'
GO
 
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Period DATETIME2,		@Clients UNIQUEIDENTIFIER,		@StatusEquipment UNIQUEIDENTIFIER,		@ContractSale UNIQUEIDENTIFIER,		@CantractService UNIQUEIDENTIFIER,		@ContactForEquipment NVARCHAR(100),		@Info NVARCHAR(1000),		@Equipment UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_Equipments]( 
		[Ref],[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Period,@Clients,@StatusEquipment,@ContractSale,@CantractService,@ContactForEquipment,@Info,@Equipment	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_Equipments] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_Equipments]( 
		[Ref],[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_clear]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_clear] @Ref UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Equipment_Equipments] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_selectkeys]'
GO
 
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_selectkeys] @Ref UNIQUEIDENTIFIER AS 
	SELECT [Ref],[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]	FROM [Catalog].[Equipment_Equipments] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_update]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Period DATETIME2,		@Clients UNIQUEIDENTIFIER,		@StatusEquipment UNIQUEIDENTIFIER,		@ContractSale UNIQUEIDENTIFIER,		@CantractService UNIQUEIDENTIFIER,		@ContactForEquipment NVARCHAR(100),		@Info NVARCHAR(1000),		@Equipment UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Equipment_Equipments] WHERE [Ref] = @Ref AND ([Period] = @Period OR ([Period] IS NULL AND @Period IS NULL)) AND ([Clients] = @Clients OR ([Clients] IS NULL AND @Clients IS NULL)) AND ([Equipment] = @Equipment OR ([Equipment] IS NULL AND @Equipment IS NULL))) 
	UPDATE [Catalog].[Equipment_Equipments] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Period] = @Period,				[Clients] = @Clients,				[StatusEquipment] = @StatusEquipment,				[ContractSale] = @ContractSale,				[CantractService] = @CantractService,				[ContactForEquipment] = @ContactForEquipment,				[Info] = @Info,				[Equipment] = @Equipment			WHERE [Ref] = @Ref AND [Period] = @Period AND [Clients] = @Clients AND [Equipment] = @Equipment AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [StatusEquipment] <> @StatusEquipment OR [ContractSale] <> @ContractSale OR [CantractService] <> @CantractService OR [ContactForEquipment] <> @ContactForEquipment OR [Info] <> @Info ) 
	ELSE 
	INSERT INTO [Catalog].[Equipment_Equipments]( 
		[Ref],[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Period,@Clients,@StatusEquipment,@ContractSale,@CantractService,@ContactForEquipment,@Info,@Equipment	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_Equipments] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Equipment_Equipments] SET 
				[LineNumber] = D.[LineNumber],				[Period] = D.[Period],				[Clients] = D.[Clients],				[StatusEquipment] = D.[StatusEquipment],				[ContractSale] = D.[ContractSale],				[CantractService] = D.[CantractService],				[ContactForEquipment] = D.[ContactForEquipment],				[Info] = D.[Info],				[Equipment] = D.[Equipment]			FROM [Catalog].[Equipment_Equipments] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Clients] = D.[Clients] OR (T.[Clients] IS NULL AND D.[Clients] IS NULL)) AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Period] <> D.[Period] OR T.[Clients] <> D.[Clients] OR T.[StatusEquipment] <> D.[StatusEquipment] OR T.[ContractSale] <> D.[ContractSale] OR T.[CantractService] <> D.[CantractService] OR T.[ContactForEquipment] <> D.[ContactForEquipment] OR T.[Info] <> D.[Info] OR T.[Equipment] <> D.[Equipment] ) 
 
	INSERT INTO [Catalog].[Equipment_Equipments]( 
		[Ref],[LineNumber],[Period],[Clients],[StatusEquipment],[ContractSale],[CantractService],[ContactForEquipment],[Info],[Equipment]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Period],D.[Clients],D.[StatusEquipment],D.[ContractSale],D.[CantractService],D.[ContactForEquipment],D.[Info],D.[Equipment]		FROM @Data D 
		LEFT JOIN [Catalog].[Equipment_Equipments] T ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Clients] = D.[Clients] OR (T.[Clients] IS NULL AND D.[Clients] IS NULL)) AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[Equipment_Equipments] 
	FROM [Catalog].[Equipment_Equipments] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Clients] = D.[Clients] OR (T.[Clients] IS NULL AND D.[Clients] IS NULL)) AND (T.[Equipment] = D.[Equipment] OR (T.[Equipment] IS NULL AND D.[Equipment] IS NULL))	WHERE T.Ref = @Ref AND D.[Period] IS NULL AND D.[Clients] IS NULL AND D.[Equipment] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_Equipments_adm_delete]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_Equipments_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Period DATETIME2 
		,@Clients UNIQUEIDENTIFIER 
		,@Equipment UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Equipment_Equipments] 
	WHERE [Ref] = @Ref AND [Period] = @Period AND [Clients] = @Clients AND [Equipment] = @Equipment	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [Catalog].[Equipment_EquipmentsHistory]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD 
[KeyFieldTimestamp] [bigint] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ALTER COLUMN [ObjectGet] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ALTER COLUMN [Comment] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NULL 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Catalog_Equipment_EquipmentsHistory] on [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [PK_Catalog_Equipment_EquipmentsHistory] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [UQ_Catalog_Equipment_EquipmentsHistory_Key] UNIQUE NONCLUSTERED  ([Ref], [Period], [Client], [Equipments])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_insert]'
GO
 
 
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_insert] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Period DATETIME2,		@Client UNIQUEIDENTIFIER,		@Equipments UNIQUEIDENTIFIER,		@Target NVARCHAR(100),		@Result UNIQUEIDENTIFIER,		@ObjectGet NVARCHAR(1000),		@Comment NVARCHAR(1000),		@Executor UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_EquipmentsHistory]( 
		[Ref],[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Period,@Client,@Equipments,@Target,@Result,@ObjectGet,@Comment,@Executor	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_insert_batch]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_insert_batch] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_EquipmentsHistory] READONLY 
AS 
	SET NOCOUNT ON 
	INSERT INTO [Catalog].[Equipment_EquipmentsHistory]( 
		[Ref],[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]	) 
	SELECT  
		@Ref 
		,[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]		FROM @Data
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_clear]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_clear] @Ref UNIQUEIDENTIFIER AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Equipment_EquipmentsHistory] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_selectkeys]'
GO
 
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_selectkeys] @Ref UNIQUEIDENTIFIER AS 
	SELECT [Ref],[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]	FROM [Catalog].[Equipment_EquipmentsHistory] WHERE [Ref] = @Ref
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_update]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_update] 
		@Ref UNIQUEIDENTIFIER,		@LineNumber INT,		@Period DATETIME2,		@Client UNIQUEIDENTIFIER,		@Equipments UNIQUEIDENTIFIER,		@Target NVARCHAR(100),		@Result UNIQUEIDENTIFIER,		@ObjectGet NVARCHAR(1000),		@Comment NVARCHAR(1000),		@Executor UNIQUEIDENTIFIER	AS 
	SET NOCOUNT ON 
	IF EXISTS(SELECT * FROM [Catalog].[Equipment_EquipmentsHistory] WHERE [Ref] = @Ref AND ([Period] = @Period OR ([Period] IS NULL AND @Period IS NULL)) AND ([Client] = @Client OR ([Client] IS NULL AND @Client IS NULL)) AND ([Equipments] = @Equipments OR ([Equipments] IS NULL AND @Equipments IS NULL))) 
	UPDATE [Catalog].[Equipment_EquipmentsHistory] SET 
				[Ref] = @Ref,				[LineNumber] = @LineNumber,				[Period] = @Period,				[Client] = @Client,				[Equipments] = @Equipments,				[Target] = @Target,				[Result] = @Result,				[ObjectGet] = @ObjectGet,				[Comment] = @Comment,				[Executor] = @Executor			WHERE [Ref] = @Ref AND [Period] = @Period AND [Client] = @Client AND [Equipments] = @Equipments AND  
	( 1=0 OR [LineNumber] <> @LineNumber OR [Target] <> @Target OR [Result] <> @Result OR [ObjectGet] <> @ObjectGet OR [Comment] <> @Comment OR [Executor] <> @Executor ) 
	ELSE 
	INSERT INTO [Catalog].[Equipment_EquipmentsHistory]( 
		[Ref],[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]	)  
	VALUES 
	( 
		@Ref,@LineNumber,@Period,@Client,@Equipments,@Target,@Result,@ObjectGet,@Comment,@Executor	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_update_batch_all]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_update_batch_all] @Ref UNIQUEIDENTIFIER, @Data [Catalog].[T_Equipment_EquipmentsHistory] READONLY 
AS 
	SET NOCOUNT ON 
	UPDATE [Catalog].[Equipment_EquipmentsHistory] SET 
				[LineNumber] = D.[LineNumber],				[Period] = D.[Period],				[Client] = D.[Client],				[Equipments] = D.[Equipments],				[Target] = D.[Target],				[Result] = D.[Result],				[ObjectGet] = D.[ObjectGet],				[Comment] = D.[Comment],				[Executor] = D.[Executor]			FROM [Catalog].[Equipment_EquipmentsHistory] T 
	JOIN @Data D ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Client] = D.[Client] OR (T.[Client] IS NULL AND D.[Client] IS NULL)) AND (T.[Equipments] = D.[Equipments] OR (T.[Equipments] IS NULL AND D.[Equipments] IS NULL))	WHERE T.Ref = @Ref AND 
	( 1=0 OR T.[LineNumber] <> D.[LineNumber] OR T.[Period] <> D.[Period] OR T.[Client] <> D.[Client] OR T.[Equipments] <> D.[Equipments] OR T.[Target] <> D.[Target] OR T.[Result] <> D.[Result] OR T.[ObjectGet] <> D.[ObjectGet] OR T.[Comment] <> D.[Comment] OR T.[Executor] <> D.[Executor] ) 
 
	INSERT INTO [Catalog].[Equipment_EquipmentsHistory]( 
		[Ref],[LineNumber],[Period],[Client],[Equipments],[Target],[Result],[ObjectGet],[Comment],[Executor]	) 
	SELECT  
		@Ref 
		,D.[LineNumber],D.[Period],D.[Client],D.[Equipments],D.[Target],D.[Result],D.[ObjectGet],D.[Comment],D.[Executor]		FROM @Data D 
		LEFT JOIN [Catalog].[Equipment_EquipmentsHistory] T ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Client] = D.[Client] OR (T.[Client] IS NULL AND D.[Client] IS NULL)) AND (T.[Equipments] = D.[Equipments] OR (T.[Equipments] IS NULL AND D.[Equipments] IS NULL))	WHERE T.[Id] IS NULL 
 
	DELETE FROM [Catalog].[Equipment_EquipmentsHistory] 
	FROM [Catalog].[Equipment_EquipmentsHistory] T 
	LEFT JOIN @Data D ON T.Ref = @Ref AND (T.[Period] = D.[Period] OR (T.[Period] IS NULL AND D.[Period] IS NULL)) AND (T.[Client] = D.[Client] OR (T.[Client] IS NULL AND D.[Client] IS NULL)) AND (T.[Equipments] = D.[Equipments] OR (T.[Equipments] IS NULL AND D.[Equipments] IS NULL))	WHERE T.Ref = @Ref AND D.[Period] IS NULL AND D.[Client] IS NULL AND D.[Equipments] IS NULL	 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [Catalog].[Equipment_EquipmentsHistory_adm_delete]'
GO
 
CREATE PROCEDURE [Catalog].[Equipment_EquipmentsHistory_adm_delete] @Ref UNIQUEIDENTIFIER 
		,@Period DATETIME2 
		,@Client UNIQUEIDENTIFIER 
		,@Equipments UNIQUEIDENTIFIER 
	AS 
	SET NOCOUNT ON 
	DELETE FROM [Catalog].[Equipment_EquipmentsHistory] 
	WHERE [Ref] = @Ref AND [Period] = @Period AND [Client] = @Client AND [Equipments] = @Equipments	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [DF__Equipment_Eq__Id__618671AF] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [DF__Equipment_Eq__Id__60924D76] DEFAULT (newsequentialid()) FOR [Id]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Equipment_EquipmentsHistory]'
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [FK_Catalog_Equipment_EquipmentsHistory_Catalog_Equipment_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Equipment] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [FK_Catalog_Equipment__EquipmentsHistory_Catalog_Client_Client] FOREIGN KEY ([Client]) REFERENCES [Catalog].[Client] ([Id]) 
GO
ALTER TABLE [Catalog].[Equipment_EquipmentsHistory] ADD CONSTRAINT [FK_Catalog_Equipment__EquipmentsHistory_Catalog_Equipment_Equipments] FOREIGN KEY ([Equipments]) REFERENCES [Catalog].[Equipment] ([Id]) 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [Catalog].[Equipment_Equipments]'
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [FK_Catalog_Equipment_Equipments_Catalog_Equipment_EntityId] FOREIGN KEY ([Ref]) REFERENCES [Catalog].[Equipment] ([Id]) ON DELETE CASCADE 
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [FK_Catalog_Equipment__Equipments_Catalog_Client_Clients] FOREIGN KEY ([Clients]) REFERENCES [Catalog].[Client] ([Id]) 
GO
ALTER TABLE [Catalog].[Equipment_Equipments] ADD CONSTRAINT [FK_Catalog_Equipment__Equipments_Catalog_Equipment_Equipment] FOREIGN KEY ([Equipment]) REFERENCES [Catalog].[Equipment] ([Id]) 
GO


--
-- BEGIN OF DATA MODIFICATION 
--

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

<<<<<<< HEAD
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
=======
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
>>>>>>> hotfix/3.1.3.1

IF @@ERROR <> 0 SET NOEXEC ON
GO

<<<<<<< HEAD
=======
--
-- END OF DATA MODIFICATION 
--

--
-- BEGIN DATABASE VERSION SETUP 
--

>>>>>>> hotfix/3.1.3.1
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

<<<<<<< HEAD
=======
--
-- END DATABASE VERSION SETUP 
--


>>>>>>> hotfix/3.1.3.1
COMMIT TRANSACTION
GO

IF @@ERROR <> 0 SET NOEXEC ON
<<<<<<< HEAD
GO

DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
  IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
  PRINT 'The database update failed'
END
=======
>>>>>>> hotfix/3.1.3.1
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
