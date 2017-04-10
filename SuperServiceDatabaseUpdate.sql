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

CREATE TABLE [dbo].[ReportQuery](
    [Name] [nvarchar](50) NOT NULL,
    [Query] [nvarchar](max) NOT NULL,
    [Number] [int] IDENTITY(1,1) PRIMARY KEY
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

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
When Total.MeterDiffGPsEnd Is Null then null
When Total.MeterDiffGPsEnd <= 300 Then ''''dist_ok'''' 
When Total.MeterDiffGPsEnd>300 And Total.MeterDiffGPsEnd <= 600 Then ''''dist_half''''
When Total.MeterDiffGPsEnd>600 Then ''''dist_big''''
End As ''''IconStatusGpsEnd'''',
Case 
When Total.MeterDiffGPsStart Is Null then null
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
Case 
	When  CatalogClient.Latitude IS NULL OR CatalogClient.Longitude IS NULL Then
		0
	Else 
		1
END as ''''IsClientCoordinates'''',
Case 
	When  DocumentEvent.LatitudeStart IS NULL OR DocumentEvent.LongitudeStart IS NULL Then
		0
	Else 
		1
END as ''''IsEventStartCoordinates'''',

Case 
	When  DocumentEvent.LatitudeEnd IS NULL OR DocumentEvent.LongitudeEnd IS NULL Then
		0
	Else 
		1
END as ''''IsEventEndCoordinates'''',
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


IF @@ERROR <> 0 SET NOEXEC ON
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

PRINT N'Updates all code in string'
Go
UPDATE Catalog.Accounts Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.Actions Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.Client Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.ClientOptions Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.Contacts Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.Equipment Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.EquipmentOptions Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.EventOptions Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.RIM Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.ServiceAgreement Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.SettingMobileApplication Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.SKU Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.TypesDepartures Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Catalog.[User] Set Code = RIGHT('000000000' + Code,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Document.[Event] Set Number = RIGHT('000000000' + Number,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Document.NeedMat Set Number = RIGHT('000000000' + Number,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Document.Reminder Set Number = RIGHT('000000000' + Number,9)

IF @@ERROR <> 0 SET NOEXEC ON
GO

UPDATE Document.Task Set Number = RIGHT('000000000' + Number,9)

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
	[Value] [varchar] (500) COLLATE Cyrillic_General_CI_AS NOT NULL
)
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

INSERT INTO [dbo].[dbConfig]
           ([Key]
           ,[Value])
     VALUES
           ('DBVersion'
           ,N'3.1.7.0');
GO

IF @@ERROR <> 0 SET NOEXEC ON
GO

INSERT INTO [dbo].[dbConfig]
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

PRINT N'Creating [dbo].[PicturePaths]...';
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

PRINT N'Creating unnamed constraint on [dbo].[PicturePaths]...';
GO

ALTER TABLE [dbo].[PicturePaths]
    ADD DEFAULT (newsequentialid()) FOR [Id];
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



-- CREATE FUNCTION [DateTime2ToBigInt](@dt DATETIME2(7))
-- RETURNS BIGINT
-- WITH SCHEMABINDING AS
-- BEGIN
-- declare @dtBinary binary(9) = CAST(REVERSE(CONVERT(binary(9), @dt)) as binary(9));
-- declare @dtDateBytes binary(3) = SUBSTRING(@dtBinary, 1, 3);
-- declare @dtTimeBytes binary(5) = SUBSTRING(@dtBinary, 4, 5);
-- declare @dtPrecisionByte binary(1) = SUBSTRING(@dtBinary, 9, 1);

-- return (CONVERT(bigint, @dtDateBytes) * 864000000000) + CONVERT(bigint, @dtTimeBytes)

-- return DATEDIFF(SECOND, {d '1970-01-01'}, @dt)

-- END

-- GO


-- PRINT 'Creating Auto last changed datetime triggers...  --------------------------------------------------------------------'
-- DECLARE @colName NVARCHAR(100) = 'Timestamp';
-- DECLARE @script NVARCHAR(MAX), @tableName NVARCHAR(MAX);

-- DECLARE cursor_name CURSOR FAST_FORWARD READ_ONLY FOR
-- SELECT	'CREATE TRIGGER tr'+ tableName +'LastChangeDate ON ['+ schemaName + '].[' + tableName +'] FOR UPDATE AS BEGIN ' +
-- 		'UPDATE ['+ schemaName + '].[' + tableName +'] SET [' + @colName + '] = dbo.DateTime2ToBigInt(GETDATE()) ' +  
-- 		'FROM ['+ schemaName + '].[' + tableName +'] t INNER JOIN Inserted s ON t.Id = s.Id; END ' AS script,
-- 		tableName AS tableName
-- FROM	(
-- 			SELECT	t.name AS tableName, 
-- 					SCHEMA_NAME(schema_id) AS schemaName
-- 			FROM sys.tables AS t INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
-- 			WHERE c.name = @colName
-- 		) z
-- OPEN cursor_name
-- FETCH NEXT FROM cursor_name INTO @script, @tableName

-- WHILE @@FETCH_STATUS = 0
-- BEGIN
-- 	PRINT 'for ' + @tableName
-- 	EXEC(@script);
--     FETCH NEXT FROM cursor_name INTO @script, @tableName
-- END

-- CLOSE cursor_name
-- DEALLOCATE cursor_name

PRINT 'Finished.'