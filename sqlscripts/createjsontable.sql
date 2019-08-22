/****** Object:  Table [dbo].[jsontable]    Script Date: 8/22/2019 1:51:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[jsontable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[json_column] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create B-tree index
CREATE CLUSTERED INDEX clJsontable ON jsontable (id)

-- Create CCI index
CREATE CLUSTERED COLUMNSTORE INDEX cciJsontable ON jsontable

-- Generate JSON documents with random timestamp and assetid
WITH GENERATE_JSON_CTE (json_column)  
AS 
(
	SELECT TOP 3145728
	JSON_MODIFY(JSON_MODIFY('{"TimeStamp":"2019-04-23T18:25:43.511Z","AssetId":"25896321A","RPM":1000,"Pwr":100,"PF":1,"Gfrq":50,"Vg1":11000,"Vg2":10987,"Vg3":10785,"Vg12":0,"Vg23":0,"Vg31":0,"Ig1":0,"Ig2":0,"Ig3":0,"Mfrq":50,"Vm1":227,"Vm2":228,"Vm3":229,"Vm12":393,"Vm23":396,"Vm31":395,"MPF":0,"SRO":0,"VRO":50,"CPUT":33.6,"Unknown1":0,"GasP":0.01,"Mode":"AUT","kWhour":13188243,"Runhrs":28187,"Numstr":3312,"Unknown2":122113663,"Unknown3":0,"OilLev":103,"OilT":45,"ThrPos":null,"CCPres":-0.01,"AirInT":29,"RecAT":36,"Unknown4":100,"ActPwr":0,"ActDem":0,"ActPfi":0,"CylA1":51,"CylA2":51,"CylA3":51,"CylA4":51,"CylA5":51,"CylA6":50,"CylB1":53,"CylB2":53,"CylB3":53,"CylB4":53,"CylB5":52,"CylB6":53,"JWTin":50,"JWTout":50,"JWGKin":36,"Unknown5":8211,"Unknown6":2,"CH4":0,"BIN":"1010001111000001"}','$.AssetId',REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 8), ' ' , '0')+'A'),'$.TimeStamp',CONVERT(varchar(255),RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME),127)+'Z') as json_column
	FROM syscolumns sc1
	CROSS JOIN syscolumns sc2
 	CROSS JOIN syscolumns sc3
)
INSERT INTO jsontable SELECT json_column FROM GENERATE_JSON_CTE;

SELECT TOP 10 * FROM jsontable