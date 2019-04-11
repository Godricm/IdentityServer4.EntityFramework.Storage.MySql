  IF EXISTS(SELECT 1 FROM information_schema.tables 
  WHERE table_name = '
__EFMigrationsHistory' AND table_schema = DATABASE()) 
BEGIN
CREATE TABLE `__EFMigrationsHistory` (
    `MigrationId` varchar(150) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    PRIMARY KEY (`MigrationId`)
);

END;

CREATE TABLE `ApiResources` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Enabled` bit NOT NULL,
    `Name` varchar(200) NOT NULL,
    `DisplayName` varchar(200) NULL,
    `Description` varchar(1000) NULL,
    `Created` datetime NOT NULL,
    `Updated` datetime NULL,
    `LastAccessed` datetime NULL,
    `NonEditable` bit NOT NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `Clients` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Enabled` bit NOT NULL,
    `ClientId` varchar(200) NOT NULL,
    `ProtocolType` varchar(200) NOT NULL,
    `RequireClientSecret` bit NOT NULL,
    `ClientName` varchar(200) NULL,
    `Description` varchar(1000) NULL,
    `ClientUri` varchar(2000) NULL,
    `LogoUri` varchar(2000) NULL,
    `RequireConsent` bit NOT NULL,
    `AllowRememberConsent` bit NOT NULL,
    `AlwaysIncludeUserClaimsInIdToken` bit NOT NULL,
    `RequirePkce` bit NOT NULL,
    `AllowPlainTextPkce` bit NOT NULL,
    `AllowAccessTokensViaBrowser` bit NOT NULL,
    `FrontChannelLogoutUri` varchar(2000) NULL,
    `FrontChannelLogoutSessionRequired` bit NOT NULL,
    `BackChannelLogoutUri` varchar(2000) NULL,
    `BackChannelLogoutSessionRequired` bit NOT NULL,
    `AllowOfflineAccess` bit NOT NULL,
    `IdentityTokenLifetime` int NOT NULL,
    `AccessTokenLifetime` int NOT NULL,
    `AuthorizationCodeLifetime` int NOT NULL,
    `ConsentLifetime` int NULL,
    `AbsoluteRefreshTokenLifetime` int NOT NULL,
    `SlidingRefreshTokenLifetime` int NOT NULL,
    `RefreshTokenUsage` int NOT NULL,
    `UpdateAccessTokenClaimsOnRefresh` bit NOT NULL,
    `RefreshTokenExpiration` int NOT NULL,
    `AccessTokenType` int NOT NULL,
    `EnableLocalLogin` bit NOT NULL,
    `IncludeJwtId` bit NOT NULL,
    `AlwaysSendClientClaims` bit NOT NULL,
    `ClientClaimsPrefix` varchar(200) NULL,
    `PairWiseSubjectSalt` varchar(200) NULL,
    `Created` datetime NOT NULL,
    `Updated` datetime NULL,
    `LastAccessed` datetime NULL,
    `UserSsoLifetime` int NULL,
    `UserCodeType` varchar(100) NULL,
    `DeviceCodeLifetime` int NOT NULL,
    `NonEditable` bit NOT NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `IdentityResources` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Enabled` bit NOT NULL,
    `Name` varchar(200) NOT NULL,
    `DisplayName` varchar(200) NULL,
    `Description` varchar(1000) NULL,
    `Required` bit NOT NULL,
    `Emphasize` bit NOT NULL,
    `ShowInDiscoveryDocument` bit NOT NULL,
    `Created` datetime NOT NULL,
    `Updated` datetime NULL,
    `NonEditable` bit NOT NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `ApiClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` varchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiClaims_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    `ApiResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiProperties_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Name` varchar(200) NOT NULL,
    `DisplayName` varchar(200) NULL,
    `Description` varchar(1000) NULL,
    `Required` bit NOT NULL,
    `Emphasize` bit NOT NULL,
    `ShowInDiscoveryDocument` bit NOT NULL,
    `ApiResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopes_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` varchar(1000) NULL,
    `Value` varchar(4000) NOT NULL,
    `Expiration` datetime NULL,
    `Type` varchar(250) NOT NULL,
    `Created` datetime NOT NULL,
    `ApiResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiSecrets_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` varchar(250) NOT NULL,
    `Value` varchar(250) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientClaims_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientCorsOrigins` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Origin` varchar(150) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientCorsOrigins_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientGrantTypes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `GrantType` varchar(250) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientGrantTypes_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientIdPRestrictions` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Provider` varchar(200) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientIdPRestrictions_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientPostLogoutRedirectUris` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `PostLogoutRedirectUri` varchar(2000) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientPostLogoutRedirectUris_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientProperties_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientRedirectUris` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `RedirectUri` varchar(2000) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientRedirectUris_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Scope` varchar(200) NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientScopes_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ClientSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` varchar(2000) NULL,
    `Value` varchar(4000) NOT NULL,
    `Expiration` datetime NULL,
    `Type` varchar(250) NOT NULL,
    `Created` datetime NOT NULL,
    `ClientId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ClientSecrets_Clients_ClientId` FOREIGN KEY (`ClientId`) REFERENCES `Clients` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `IdentityClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` varchar(200) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityClaims_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `IdentityProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` varchar(250) NOT NULL,
    `Value` varchar(2000) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityProperties_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `ApiScopeClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` varchar(200) NOT NULL,
    `ApiScopeId` int NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ApiScopeId` FOREIGN KEY (`ApiScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiClaims_ApiResourceId` ON `ApiClaims` (`ApiResourceId`);

CREATE INDEX `IX_ApiProperties_ApiResourceId` ON `ApiProperties` (`ApiResourceId`);

CREATE UNIQUE INDEX `IX_ApiResources_Name` ON `ApiResources` (`Name`);

CREATE INDEX `IX_ApiScopeClaims_ApiScopeId` ON `ApiScopeClaims` (`ApiScopeId`);

CREATE INDEX `IX_ApiScopes_ApiResourceId` ON `ApiScopes` (`ApiResourceId`);

CREATE UNIQUE INDEX `IX_ApiScopes_Name` ON `ApiScopes` (`Name`);

CREATE INDEX `IX_ApiSecrets_ApiResourceId` ON `ApiSecrets` (`ApiResourceId`);

CREATE INDEX `IX_ClientClaims_ClientId` ON `ClientClaims` (`ClientId`);

CREATE INDEX `IX_ClientCorsOrigins_ClientId` ON `ClientCorsOrigins` (`ClientId`);

CREATE INDEX `IX_ClientGrantTypes_ClientId` ON `ClientGrantTypes` (`ClientId`);

CREATE INDEX `IX_ClientIdPRestrictions_ClientId` ON `ClientIdPRestrictions` (`ClientId`);

CREATE INDEX `IX_ClientPostLogoutRedirectUris_ClientId` ON `ClientPostLogoutRedirectUris` (`ClientId`);

CREATE INDEX `IX_ClientProperties_ClientId` ON `ClientProperties` (`ClientId`);

CREATE INDEX `IX_ClientRedirectUris_ClientId` ON `ClientRedirectUris` (`ClientId`);

CREATE UNIQUE INDEX `IX_Clients_ClientId` ON `Clients` (`ClientId`);

CREATE INDEX `IX_ClientScopes_ClientId` ON `ClientScopes` (`ClientId`);

CREATE INDEX `IX_ClientSecrets_ClientId` ON `ClientSecrets` (`ClientId`);

CREATE INDEX `IX_IdentityClaims_IdentityResourceId` ON `IdentityClaims` (`IdentityResourceId`);

CREATE INDEX `IX_IdentityProperties_IdentityResourceId` ON `IdentityProperties` (`IdentityResourceId`);

CREATE UNIQUE INDEX `IX_IdentityResources_Name` ON `IdentityResources` (`Name`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190411030935_Config', '2.1.8-servicing-32085');

