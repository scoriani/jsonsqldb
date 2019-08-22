DROP TABLE jsontable

-- Generate JSON documents with random timestamp and assetid
WITH GENERATE_JSON_CTE (json_column)  
AS 
(
	SELECT TOP 100000
	JSON_MODIFY(JSON_MODIFY('{"TimeStamp":"2019-04-23T18:25:43.511Z","AssetId":"25896321A","RPM":1000,"Pwr":100,"PF":1,"Gfrq":50,"Vg1":11000,"Vg2":10987,"Vg3":10785,"Vg12":0,"Vg23":0,"Vg31":0,"Ig1":0,"Ig2":0,"Ig3":0,"Mfrq":50,"Vm1":227,"Vm2":228,"Vm3":229,"Vm12":393,"Vm23":396,"Vm31":395,"MPF":0,"SRO":0,"VRO":50,"CPUT":33.6,"Unknown1":0,"GasP":0.01,"Mode":"AUT","kWhour":13188243,"Runhrs":28187,"Numstr":3312,"Unknown2":122113663,"Unknown3":0,"OilLev":103,"OilT":45,"ThrPos":null,"CCPres":-0.01,"AirInT":29,"RecAT":36,"Unknown4":100,"ActPwr":0,"ActDem":0,"ActPfi":0,"CylA1":51,"CylA2":51,"CylA3":51,"CylA4":51,"CylA5":51,"CylA6":50,"CylB1":53,"CylB2":53,"CylB3":53,"CylB4":53,"CylB5":52,"CylB6":53,"JWTin":50,"JWTout":50,"JWGKin":36,"Unknown5":8211,"Unknown6":2,"CH4":0,"BIN":"1010001111000001"}','$.AssetId',REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 8), ' ' , '0')+'A'),'$.TimeStamp',CONVERT(varchar(255),RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME),127)+'Z') as json_column
	FROM syscolumns sc1
	CROSS JOIN syscolumns sc2
 	CROSS JOIN syscolumns sc3
)
SELECT IDENTITY(INT,1,1) as id, json_column INTO jsontable FROM GENERATE_JSON_CTE;


DROP TABLE schematizedjsontable

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
SELECT IDENTITY(INT,1,1) as id, t.*
INTO
	schematizedjsontable
FROM GENERATE_JSON_CTE
CROSS APPLY 
	 OPENJSON(GENERATE_JSON_CTE.json_column) WITH 
	 (
        TimeStamp   varchar(255)  '$.TimeStamp',  
        AssetId     varchar(255)  '$.AssetId',  
        RPM int                   '$.RPM',  
        Pwr int                   '$.Pwr',  
        Runhrs int                '$.Runhrs',
		PF decimal				  '$.PF',
		Gfrq decimal			  '$.Gfrq',
		Vg1	int					  '$.Vg1',
		Vg2 int					  '$.Vg2',
		Vg3 int					  '$.Vg3',
		Vg12	int				  '$.Vg12',
		Vg23 int				  '$.Vg23',
		Vg31 int				  '$.Vg31',
		Ig1	int					  '$.Ig1',
		Ig2 int					  '$.Ig2',
		Ig3 int					  '$.Ig3',
		Mfrq decimal			  '$.Mfrq',
		Vm1	int					  '$.Vm1',
		Vm2 int					  '$.Vm2',
		Vm3 int					  '$.Vm3',
		Vm12 int				  '$.Vm12',
		Vm23 int				  '$.Vm23',
		Vm31 int				  '$.Vm31',
		MPF decimal				  '$.MPF',
		SRO decimal				  '$.SRO',
		VRO decimal				  '$.VRO',
		CPUT decimal			  '$.CPUT',
		Unknown1 int			  '$.Unknown1',
		GasP decimal			  '$.GasP',
		Mode varchar(3)			  '$.Mode',
		kWhour int				  '$.kWhour',
		Numstr int				  '$.Numstr',
		Unknown2 int			  '$.Unknown2',
		Unknown3 decimal		  '$.Unknown3',
		OilLev int				  '$.OilLev',
		OilT int				  '$.OilT',
		ThrPos int				  '$.ThrPos',
		CCPres decimal			  '$.CCPres',
		AirInT int				  '$.AirInT',
		RecAT int				  '$.RecAT',
		Unknown4 int			  '$.Unknown4',
		ActPwr int				  '$.ActPwr',
		ActDem int				  '$.ActDem',
		ActPfi int				  '$.ActPfi',
		CylA1 int				  '$.CylA1',
		CylA2 int				  '$.CylA2',
		CylA3 int				  '$.CylA3',
		CylA4 int				  '$.CylA4',
		CylA5 int				  '$.CylA5',
		CylA6 int				  '$.CylA6',
		CylB1 int				  '$.CylB1',
		CylB2 int				  '$.CylB2',
		CylB3 int				  '$.CylB3',
		CylB4 int				  '$.CylB4',
		CylB5 int				  '$.CylB5',
		CylB6 int				  '$.CylB6',
		JWTin int				  '$.JWTin',
		JWTout int				  '$.JWTout',
		JWGKin int				  '$.JWGKin',
		Unknown5 int			  '$.Unknown5',
		Unknown6 int			  '$.Unknown6',
		CH4 int					  '$.CH4',
		BIN varchar(16)			  '$.BIN'
	 ) as t
