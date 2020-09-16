CREATE TABLE IF NOT EXISTS PacketSessionData (
   ID                         uuid DEFAULT uuid_generate_v4 (),
   PacketHeader_ID            uuid NOT NULL,
   Weather                    INT NOT NULL,
   TrackTemperature           INT NOT NULL,
   AirTemperature             INT NOT NULL,
   TotalLaps                  INT NOT NULL,
   TrackLength                INT NOT NULL,
   SessionType                INT NOT NULL,
   TrackID                    INT NOT NULL,
   Formula                    INT NOT NULL,
   SessionTimeLeft            INT NOT NULL,
   SessionDuration            INT NOT NULL,
   PitSpeedLimit              INT NOT NULL,
   GamePaused                 INT NOT NULL,
   IsSpectating               INT NOT NULL,
   SpectatorCarIndex          INT NOT NULL,
   SliProNativeSupport        INT NOT NULL,
   NumMarshalZones            INT NOT NULL,
   SafetyCarStatus            INT NOT NULL,
   NetworkGame                INT NOT NULL,
   CreatedOn                  TIMESTAMPTZ DEFAULT NOW(),

   PRIMARY KEY (ID),
   FOREIGN KEY (PacketHeader_ID)
      REFERENCES PacketHeader (ID)
);

CREATE TABLE IF NOT EXISTS MarshalZone (
   ID                         uuid DEFAULT uuid_generate_v4 (),
   PacketSessionData_ID       uuid NOT NULL,
   ZoneStart                  FLOAT NOT NULL,
   ZoneFlag                   FLOAT NOT NULL,
   CreatedOn                  TIMESTAMPTZ DEFAULT NOW(),

   PRIMARY KEY (ID),
   FOREIGN KEY (PacketSessionData_ID)
      REFERENCES PacketSessionData (ID)
);

CREATE TABLE IF NOT EXISTS WeatherForecastSample (
   ID                         uuid DEFAULT uuid_generate_v4 (),
   PacketSessionData_ID       uuid NOT NULL,
   SessionType                INT NOT NULL,
   TimeOffset                 INT NOT NULL,
   Weather                    INT NOT NULL,
   TrackTemperature           INT NOT NULL,
   AirTemperature             INT NOT NULL,
   CreatedOn                  TIMESTAMPTZ DEFAULT NOW(),

   PRIMARY KEY (ID),
   FOREIGN KEY (PacketSessionData_ID)
      REFERENCES PacketSessionData (ID)
);

CREATE OR REPLACE PROCEDURE insert_packet_session_data("ID" uuid, "PacketHeader_ID" uuid)
LANGUAGE 'plpgsql'
AS $BODY$
	BEGIN
		INSERT INTO PacketSessionData 
		VALUES ("ID", "PacketHeader_ID");
	END;
$BODY$;

CREATE OR REPLACE PROCEDURE insert_marshal_zone("ID" uuid, "PacketSessionData_ID" uuid)
LANGUAGE 'plpgsql'
AS $BODY$
	BEGIN
		INSERT INTO MarshalZone 
		VALUES ("ID", "PacketSessionData_ID");
	END;
$BODY$;

CREATE OR REPLACE PROCEDURE insert_weather_forecast_sample("ID" uuid, "PacketSessionData_ID" uuid)
LANGUAGE 'plpgsql'
AS $BODY$
	BEGIN
		INSERT INTO WeatherForecastSample 
		VALUES ("ID", "PacketSessionData_ID");
	END;
$BODY$;