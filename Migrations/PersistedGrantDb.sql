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

CREATE TABLE `DeviceCodes` (
    `DeviceCode` varchar(200) NOT NULL,
    `UserCode` varchar(200) NOT NULL,
    `SubjectId` varchar(200) NULL,
    `ClientId` varchar(200) NOT NULL,
    `CreationTime` datetime NOT NULL,
    `Expiration` datetime NOT NULL,
    `Data` varchar(50000) NOT NULL,
    PRIMARY KEY (`UserCode`)
);

CREATE TABLE `PersistedGrants` (
    `Key` varchar(200) NOT NULL,
    `Type` varchar(50) NOT NULL,
    `SubjectId` varchar(200) NULL,
    `ClientId` varchar(200) NOT NULL,
    `CreationTime` datetime NOT NULL,
    `Expiration` datetime NULL,
    `Data` varchar(50000) NOT NULL,
    PRIMARY KEY (`Key`)
);

CREATE UNIQUE INDEX `IX_DeviceCodes_DeviceCode` ON `DeviceCodes` (`DeviceCode`);

CREATE INDEX `IX_PersistedGrants_SubjectId_ClientId_Type` ON `PersistedGrants` (`SubjectId`, `ClientId`, `Type`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20190411030908_Grants', '2.1.8-servicing-32085');

