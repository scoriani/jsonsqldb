
DECLARE @json varchar(max)
SET @json ='{
   "TimeStamp":"2019-04-23T18:25:43.511Z",
   "AssetId":"25896321A",
   "RPM":1000,
   "Pwr":100,
   "PF":1.00,
   "Gfrq":50.0,
   "Vg1":11000,
   "Vg2":10987,
   "Vg3":10785,
   "Vg12":0,
   "Vg23":0,
   "Vg31":0,
   "Ig1":0,
   "Ig2":0,
   "Ig3":0,
   "Mfrq":50.0,
   "Vm1":227,
   "Vm2":228,
   "Vm3":229,
   "Vm12":393,
   "Vm23":396,
   "Vm31":395,
   "MPF":0.00,
   "SRO":0.000,
   "VRO":50.0,
   "CPUT":33.6,
   "Unknown1":0,
   "GasP":0.01,
   "Mode":"AUT",
   "kWhour":13188243,
   "Runhrs":28187,
   "Numstr":3312,
   "Unknown2":122113663,
   "Unknown3":0.00,
   "OilLev":103,
   "OilT":45,
   "ThrPos":null,
   "CCPres":-0.01,
   "AirInT":29,
   "RecAT":36,
   "Unknown4":100,
   "ActPwr":0,
   "ActDem":0,
   "ActPfi":0,
   "CylA1":51,
   "CylA2":51,
   "CylA3":51,
   "CylA4":51,
   "CylA5":51,
   "CylA6":50,
   "CylB1":53,
   "CylB2":53,
   "CylB3":53,
   "CylB4":53,
   "CylB5":52,
   "CylB6":53,
   "JWTin":50,
   "JWTout":50,
   "JWGKin":36,
   "Unknown5":8211,
   "Unknown6":2,
   "CH4":0,
   "BIN":"1010001111000001"
}'

SELECT ISJSON(@json)
SELECT LEN(@json)

SELECT * 
    FROM OPENJSON(@json) WITH (
                TimeStamp   varchar(255)  '$.TimeStamp',  
                AssetId     varchar(255)  '$.AssetId',  
                RPM int                   '$.RPM',  
                Pwr int                   '$.Pwr',  
                Runhrs int                '$.Runhrs'
            )



SELECT TOP 25000 
--IDENTITY(INT,1,1)  AS Id,
ROW_NUMBER() OVER(ORDER BY sc1.id ASC)  AS Id,
RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME) AS randomDate,
REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 30000)), 10), ' ' , '0') AS code,
'{\"20190404000000000100000000010000000001\": [{\"canale\": \"SDP\", \"objcods\": [{\"code\": \"149206769258\"}, {\"code\": \"149206769269\"}, {\"code\": \"149206769281\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 1, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374375162, \"numeroOperazione\": 1}], \"20190404000000000100000000010000000002\": [{\"canale\": \"OMP\", \"objcods\": [{\"code\": \"149206769258\"}, {\"code\": \"149206769269\"}, {\"code\": \"149206769281\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374382497, \"numeroOperazione\": 2}, {\"canale\": \"OMP\", \"objcods\": [{\"code\": \"149206769258\"}, {\"code\": \"149206769269\"}, {\"code\": \"149206769281\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374409363, \"numeroOperazione\": 0}]}' AS obj_codes_by
FROM syscolumns sc1, syscolumns sc2, syscolumns sc3
