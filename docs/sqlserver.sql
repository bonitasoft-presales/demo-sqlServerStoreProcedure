use master;
GO
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'bonita')
BEGIN
  CREATE DATABASE bonita;
END;
GO
USE bonita;
GO
IF OBJECT_ID('dossier', 'U') IS NOT NULL
begin
	drop table dbo.dossier;
end;
GO
IF OBJECT_ID('dossier', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.dossier
  (
    Id   INT PRIMARY KEY IDENTITY(1, 1),
    seqValue int,
    Name VARCHAR(100)
  );
END;
GO
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = 'DossierSequence')
BEGIN
	CREATE SEQUENCE dbo.DossierSequence
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	NO MAXVALUE
	CACHE 10;
END;
GO
IF OBJECT_ID('GetNextDossierNumber', 'P') IS NOT NULL
begin
	drop PROCEDURE dbo.GetNextDossierNumber 
end;
GO
IF OBJECT_ID('GetNextDossierNumber', 'P') IS NULL
BEGIN
	EXEC('CREATE PROCEDURE dbo.GetNextDossierNumber
		@clientId int 
	AS
	BEGIN
	    SET NOCOUNT ON;
	    DECLARE @NextDossierNumber INT;
	    SELECT @NextDossierNumber = NEXT VALUE FOR DossierSequence;
		insert into dossier(seqValue,name) values( @NextDossierNumber,@clientId	);
	    SELECT @NextDossierNumber AS NextDossierNumber;
		
	END;
');
END;
GO
BEGIN
	EXEC dbo.GetNextDossierNumber 456;
END;
GO
select * from dbo.dossier d; 	
