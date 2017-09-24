DROP TABLE IF EXISTS IncidentEffect;
DROP TABLE IF EXISTS Incident;
DROP TABLE IF EXISTS IncidentType;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS RouteComponent;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS StopOffset;
DROP TABLE IF EXISTS StopType;
DROP TABLE IF EXISTS Stop;
DROP TABLE IF EXISTS Certification;
DROP TABLE IF EXISTS Operator;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS TransportMode;

-- Create the TransportMode table to group/classify different modes of transport
CREATE TABLE TransportMode (
  ModeID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  ModeName VARCHAR(50) NOT NULL,
  PassengerCapacity INTEGER NOT NULL
);

-- Create Vehicle table (representative of individual vehicles which make up the 'fleet')
CREATE TABLE Vehicle (
  VehicleID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  VehicleRegistration VARCHAR(10),
  ModeID  INTEGER NOT NULL,
  FOREIGN KEY (ModeID) REFERENCES TransportMode (ModeID)
);

-- Create Operator table (representative of the operators of each 'fleet' vehicle. ContactNumber is not multi-valued - assumed to be the operators cellphone number.
CREATE TABLE Operator (
  OperatorID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  FName VARCHAR(100) NOT NULL,
  LName VARCHAR(100) NOT NULL,
  ContactNumber INTEGER NOT NULL,
  EmergencyContact INTEGER NOT NULL,
  Age INTEGER,
  Salary INTEGER NOT NULL,
  VehicleID INTEGER,
  FOREIGN KEY (VehicleID) REFERENCES Vehicle (VehicleID)
);

-- Create Certification table (representative of which operators are qualified to operate which transport modes.
CREATE TABLE Certification (
  CertificateID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  ModeID INTEGER NOT NULL,
  OperatorID INTEGER NOT NULL,
  FOREIGN KEY (ModeID) REFERENCES TransportMode (ModeID),
  FOREIGN KEY (OperatorID) REFERENCES Operator (OperatorID)
);

-- Create Stops table (representative of all stops within the transport network). This table has no foreign key relations
CREATE TABLE Stop (
  StopID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  StopName VARCHAR(100) NOT NULL,
  ShortName VARCHAR(10) NOT NULL,
  LocationLat FLOAT NOT NULL,
  LocationLong FLOAT NOT NULL
);

-- Create StopType table (linkage between the TransportMode and Stop table).
CREATE TABLE StopType (
  StopTypeID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  ModeID INTEGER NOT NULL,
  StopID INTEGER NOT NULL,
  FOREIGN KEY (ModeID) REFERENCES TransportMode (ModeID),
  FOREIGN KEY (StopID) REFERENCES Stop (StopID)
);

-- Create StopOffset table (self-relation to stops whereby the offsets between each stop are stored). This table will be used to increase the resiliency of the system to incidents (e.g natural disasters)
CREATE TABLE StopOffset (
  OffsetID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  StopID1 INTEGER NOT NULL,
  StopID2 INTEGER NOT NULL,
  OffsetDistance INTEGER NOT NULL,
  FOREIGN KEY (StopID1) REFERENCES Stop (StopID),
  FOREIGN KEY (StopID2) REFERENCES Stop (StopID)
);

-- Create Route table which will include each of the route names of the network. This will be linked to stops via the RouteComponent table.
CREATE TABLE Route (
  RouteID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  RouteName VARCHAR(100) NOT NULL
);

CREATE TABLE RouteComponent(
  RouteComponentID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  StopID INTEGER NOT NULL,
  RouteID INTEGER NOT NULL,
  FOREIGN KEY (StopID) REFERENCES Stop (StopID),
  FOREIGN KEY (RouteID) REFERENCES Route (RouteID)
);

-- Create Schedule table. This includes the arrival/departure times and could be used for constructing timetables. Vehicles are also assigned schedules and to Stops/Routes via the RouteComponent table (therefore this table assists with Resource Planning/Logistics)
CREATE TABLE Schedule (
  ScheduleID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  ArrivalTime TEXT,
  DepartureTime TEXT,
  RouteComponentID INTEGER NOT NULL,
  VehicleID INTEGER,
  FOREIGN KEY (RouteComponentID) REFERENCES RouteComponent (RouteComponentID),
  FOREIGN KEY (VehicleID) REFERENCES Vehicle (VehicleID)
);

-- Create IncidentType table. This categorises/groups incidents to assist with the immediate/long-term response (e.g. earthquakes, flooding, vandalism, power-outage etc.)
CREATE TABLE IncidentType (
  IncidentTypeID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  IncidentTypeName VARCHAR(200) NOT NULL
);

-- Create Incident table which will store instances of incidents which affect the transport network
CREATE TABLE Incident (
  IncidentID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  IncidentName TEXT NOT NULL,
  OccurrenceDateTime TEXT NOT NULL,
  Resolution BOOLEAN NOT NULL,
  IncidentTypeID INTEGER NOT NULL,
  FOREIGN KEY (IncidentTypeID) REFERENCES IncidentType (IncidentTypeID)
);

-- Create IncidentEffect table which will link specific events to the stops which are affected.
CREATE TABLE IncidentEffect (
  IncidentEffectID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  StopID INTEGER NOT NULL,
  IncidentID INTEGER NOT NULL,
  FOREIGN KEY (StopID) REFERENCES Stop (StopID),
  FOREIGN KEY (IncidentID) REFERENCES Incident (IncidentID)
);