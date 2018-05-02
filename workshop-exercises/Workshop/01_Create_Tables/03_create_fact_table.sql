drop table if exists faa.otp_r;
CREATE TABLE faa.otp_r  (
   Flt_Year              SMALLINT,
   Flt_Quarter           SMALLINT,
   Flt_Month             SMALLINT,
   Flt_DayofMonth        SMALLINT,
   Flt_DayOfWeek         SMALLINT,
   FlightDate            DATE,
   UniqueCarrier         TEXT,
   AirlineID             INTEGER,  -- FK to d_airlines
   Carrier               TEXT,
   FlightNum             TEXT,
   Origin                TEXT,     -- airport code, FK to d_airports
   OriginCityName        TEXT,
   OriginState           TEXT,
   OriginStateName       TEXT,
   Dest                  TEXT,     -- airport code, FK to d_airports
   DestCityName          TEXT,
   DestState             TEXT,
   DestStateName         TEXT,
   CRSDepTime            time,
   DepTime               time,
   DepDelay              FLOAT8,   -- cast from numeric
   DepDelayMinutes       FLOAT8,   -- cast from numeric
   DepartureDelayGroups  SMALLINT, --FK to d_delay_groups
   TaxiOut               SMALLINT, -- cast from numeric
   WheelsOff             time,
   WheelsOn              time,
   TaxiIn                SMALLINT, -- cast from numeric
   CRSArrTime            time,
   ArrTime               time,
   ArrDelay              FLOAT8,   -- cast from numeric
   ArrDelayMinutes       FLOAT8,   -- cast from numeric
   ArrivalDelayGroups    SMALLINT, -- FK to d_delay_groups
   Cancelled             boolean, -- cast from numeric
   CancellationCode      TEXT,     -- FK to d_cancellation_codes
   Diverted              boolean,
   CRSElapsedTime        INTEGER,  -- cast from numeric
   ActualElapsedTime     FLOAT8,   -- cast from numeric
   AirTime               FLOAT8,   -- cast from numeric
   Flights               SMALLINT, -- cast from numeric, always one
   Distance              FLOAT8,   -- cast from numeric
   DistanceGroup         SMALLINT, -- FK to d_distance_groups
   CarrierDelay          SMALLINT, -- cast from numeric
   WeatherDelay          SMALLINT, -- cast from numeric
   NASDelay              SMALLINT, -- cast from numeric
   SecurityDelay         SMALLINT, -- cast from numeric
   LateAircraftDelay     SMALLINT  -- cast from numeric
) 
DISTRIBUTED BY (AirlineID);

