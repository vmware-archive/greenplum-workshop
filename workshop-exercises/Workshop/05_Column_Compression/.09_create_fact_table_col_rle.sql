\set tblname faa.otp_rle

drop table if exists :tblname;
CREATE TABLE :tblname  (
   Flt_Year              SMALLINT,
   Flt_Quarter           SMALLINT,
   Flt_Month             SMALLINT,
   Flt_DayofMonth        SMALLINT,
   Flt_DayOfWeek         SMALLINT,
   FlightDate            DATE ENCODING (compresstype=RLE_TYPE),
   UniqueCarrier         TEXT,
   AirlineID             INTEGER ENCODING (compresstype=RLE_TYPE),
   Carrier               TEXT,
   FlightNum             TEXT,
   Origin                TEXT,
   OriginCityName        TEXT,
   OriginState           TEXT,
   OriginStateName       TEXT,
   Dest                  TEXT,
   DestCityName          TEXT,
   DestState             TEXT,
   DestStateName         TEXT,
   CRSDepTime            TEXT,
   DepTime               INTEGER,
   DepDelay              FLOAT8,
   DepDelayMinutes       FLOAT8,
   DepartureDelayGroups  SMALLINT,
   TaxiOut               SMALLINT,
   WheelsOff             TEXT,
   WheelsOn              TEXT,
   TaxiIn                SMALLINT,
   CRSArrTime            TEXT,
   ArrTime               TEXT,
   ArrDelay              FLOAT8,
   ArrDelayMinutes       FLOAT8,
   ArrivalDelayGroups    SMALLINT,
   Cancelled             SMALLINT,
   CancellationCode      TEXT,
   Diverted              SMALLINT,
   CRSElapsedTime        INTEGER,
   ActualElapsedTime     FLOAT8,
   AirTime               FLOAT8,
   Flights               SMALLINT,
   Distance              FLOAT8,
   DistanceGroup         SMALLINT,
   CarrierDelay          SMALLINT,
   WeatherDelay          SMALLINT,
   NASDelay              SMALLINT,
   SecurityDelay         SMALLINT,
   LateAircraftDelay     SMALLINT,
   DEFAULT COLUMN ENCODING (compresstype=zlib,
                            compresslevel=5,
                            blocksize=65536)
)
WITH (APPENDONLY=true, ORIENTATION=column)
DISTRIBUTED BY (AirlineID)
;

insert into :tblname select * from otp_r;
