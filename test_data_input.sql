-- Populate tables in creation order with synthetic data
-- -----------------TRANSPORT MODE --------------
INSERT INTO TransportMode(ModeName, PassengerCapacity) VALUES ("Bus", 42), ("Train", 364);

-- -----------------VEHICLES---------------------
-- Buses
INSERT INTO Vehicle (VehicleRegistration, ModeID) VALUES ("BSJ176", 1), ("BSJ177", 1), ("BSJ178", 1), ("BSJ179", 1), ("BSJ180", 1), ("BSJ181", 1), ("BSJ182", 1), ("BSJ183", 1), ("BSJ184", 1), ("BSJ185", 1);
-- Trains
INSERT INTO Vehicle (VehicleRegistration, ModeID) VALUES ("WGNTR123", 2), ("WGNTR124", 2), ("WGNTR125", 2), ("WGNTR126", 2), ("WGNTR127", 2), ("WGNTR128", 2), ("WGNTR129", 2), ("WGNTR130", 2), ("WGNTR131", 2), ("WGNTR132", 2);

-- ---------------OPERATORS---------------------
INSERT INTO Operator (FName, LName, ContactNumber, EmergencyContact, Age, Salary, VehicleID) VALUES
  ("Logan", "Thomas", 0211234567,0271234567, 42, 52000, 1),
  ("Daniel", "Faulk", 0212345678, 0272345678, 29, 45000, 2),
  ("Claudia", "Rot", 0213456789, 0273456789, 35, 55000, 3),
  ("Mathias", "Sault", 0214567890, 0274567890, 54, 48000, 4),
  ("Anelie", "Conner", 0215678901, 0275678901, 32, 50000, 5),
  ("Sampson", "Katsuo", 0210987654, 0270987654, 34, 58000, 6),
  ("Leah", "Ida", 0219876543, 0279876543, 39, 41000, 7),
  ("Emily", "Winston", 0218765432, 0278765432, 24, 47000, 8),
  ("Kat", "Clive", 0217654321, 0277654321, 41, 46000, 9),
  ("Jenni", "Jody", 0216543210, 0276543210, 43, 43000, 10),
  ("Pollie", "Christopherson", 0216789012, 0276789012, 24, 52000, 11),
  ("Stefanie", "Smith", 0217890123, 027890123, 29, 55000, 12),
  ("Richard", "Morrin", 0218901234, 0278901234, 30, 53000, 13),
  ("Ivan", "Pierce", 0219012345, 0279012345, 38, 54000, 14),
  ("Jingyi", "Yu", 0210123456, 0270123456, 33, 54000, 15);

-- ---------------CERTIFICATION---------------------
INSERT INTO Certification (ModeID, OperatorID) VALUES
  (1, 1),
  (2, 1),
  (1, 2),
  (1, 3),
  (2, 3),
  (1, 4),
  (1, 5),
  (2, 5),
  (2, 6),
  (2, 7),
  (2, 8),
  (2, 9),
  (2, 10);

-- ---------------STOP---------------------
INSERT INTO Stop (StopName, ShortName, LocationLat, LocationLong) VALUES
  ("Wellington Railway Station", "WGTNRAIL", -41.2796091, 174.7786341),
  ("Wellington Station", "WGTN", -41.2796091, 174.7786341),
  ("Johnsonville Station", "JVILLE", -41.223345, 174.8047433),
  ("Khandallah", "KDLLH", -41.2427911, 174.7934473),
  ("Khandallah Bus Stop", "KDLLHBUS", -41.2427911, 174.7934473),
  ("Ngaio", "NGAIO", -41.2509827,174.7719325),
  ("Ngaio Bus Stop", "NGAIOBUS", -41.2509827,174.7719325),
  ("Petone", "PET", -41.2219427,174.8693815),
  ("Petone Bus Stop", "PETBUS", -41.2219427,174.8693815),
  ("Waterloo - Hutt Central", "WTLOO", -41.2138367,174.9188543),
  ("Upper Hutt", "UHUTT", -41.1262323,175.0703175),
  ("Tawa", "TAWA", -41.1693644,174.8283628),
  ("Tawa Bus Stop", "TAWABUS", -41.1693644,174.8283628),
  ("Porirua", "PRRA", -41.137454,174.8433939),
  ("Paremata", "PMTA", -41.1063152,174.8662679),
  ("Mana", "MANA", -41.0952204,174.8683278),
  ("Waikanae", "WKNAE", -40.8765871,175.0662132),
  ("Newlands", "NWLDS", -41.2313266,174.8097958);

-- ---------------STOPTYPE---------------------
INSERT INTO StopType (ModeID, StopID) VALUES
  (2, 1),
  (1, 2),
  (1, 3),
  (2, 3),
  (2, 4),
  (1, 5),
  (2, 6),
  (1, 7),
  (2, 8),
  (1, 9),
  (1, 10),
  (2, 10),
  (2, 11),
  (2, 12),
  (1, 13),
  (2, 14),
  (2, 15),
  (2, 16),
  (2, 17),
  (1, 18);

-- Test query to confirm StopType was setup correctly
SELECT s.StopName, t.ModeName FROM Stop AS s, TransportMode AS t, StopType AS st WHERE st.ModeID = t.ModeID AND s.StopID = st.StopID;

-- ---------------STOPOFFSET---------------------
INSERT INTO StopOffset (StopID1, StopID2, OffsetDistance) VALUES
  (1, 2, 0), (1, 3, 6), (1, 4, 4), (1, 5, 4), (1, 6, 3), (1, 7, 3), (1, 8, 9), (1, 9, 9), (1, 10, 13), (1, 11, 29), (1, 12, 12), (1, 13, 12), (1, 14, 16), (1, 15, 20), (1, 16, 21), (1, 17, 50), (1, 18, 5),
  (2, 1, 0), (2, 3, 6), (2, 4, 4), (2, 5, 4), (2, 6, 3), (2, 7, 3), (2, 8, 9), (2, 9, 9), (2, 10, 13), (2, 11, 29), (2, 12, 12), (2, 13, 12), (2, 14, 16), (2, 15, 20), (2, 16, 21), (2, 17, 50), (2, 18, 5),
  (3, 1, 6), (3, 2, 6), (3, 4, 2), (3, 5, 2), (3, 6, 4), (3, 7, 4), (3, 8, 5), (3, 9, 5), (3, 10, 9), (3, 11, 24), (3, 12, 6), (3, 13, 6), (3, 14, 10), (3, 15, 13), (3, 16, 15), (3, 17, 44), (3, 18, 0),
  (4, 1, 4), (4, 2, 4), (4, 3, 2), (4, 5, 0), (4, 6, 2), (4, 7, 2), (4, 8, 6), (4, 9, 6), (4, 10, 10), (4, 11, 26), (4, 12, 8), (4, 13, 8), (4, 14, 12), (4, 15, 16), (4, 16, 17), (4, 17, 46), (4, 18, 1),
  (5, 1, 4), (5, 2, 4), (5, 3, 2), (5, 4, 0), (5, 6, 2), (5, 7, 2), (5, 8, 6), (5, 9, 6), (5, 10, 10), (5, 11, 26), (5, 12, 8), (5, 13, 8), (5, 14, 12), (5, 15, 16), (5, 16, 17), (5, 17, 46), (5, 18, 1),
  (6, 1, 3), (6, 2, 3), (6, 3, 4), (6, 4, 2), (6, 5, 2), (6, 7, 0), (6, 8, 8), (6, 9, 8), (6, 10, 12), (6, 11, 28), (6, 12, 10), (6, 13, 10), (6, 14, 13), (6, 15, 17), (6, 16, 19), (6, 17, 48), (6, 18, 3),
  (7, 1, 3), (7, 2, 3), (7, 3, 4), (7, 4, 2), (7, 5, 2), (7, 6, 0), (7, 8, 8), (7, 9, 8), (7, 10, 12), (7, 11, 28), (7, 12, 10), (7, 13, 10), (7, 14, 13), (7, 15, 17), (7, 16, 19), (7, 17, 48), (7, 18, 3),
  (8, 1, 9), (8, 2, 9), (8, 3, 5), (8, 4, 6), (8, 5, 6), (8, 6, 8), (8, 7, 8), (8, 9, 0), (8, 10, 4), (8, 11, 19), (8, 12, 6), (8, 13, 6), (8, 14, 9), (8, 15, 12), (8, 16, 14), (8, 17, 41), (8, 18, 5),
  (9, 1, 9), (9, 2, 9), (9, 3, 5), (9, 4, 6), (9, 5, 6), (9, 6, 8), (9, 7, 8), (9, 8, 0), (9, 10, 4), (9, 11, 19), (9, 12, 6), (9, 13, 6), (9, 14, 9), (9, 15, 12), (9, 16, 14), (9, 17, 41), (9, 18, 5),
  (10, 1, 13), (10, 2, 13), (10, 3, 9), (10, 4, 10), (10, 5, 10), (10, 6, 12), (10, 7, 12), (10, 8, 4), (10, 9, 4), (10, 11, 15), (10, 12, 9), (10, 13, 9), (10, 14, 10), (10, 15, 12), (10, 16, 13), (10, 17, 39), (10, 18, 9),
  (11, 1, 29), (11, 2, 29), (11, 3, 24), (11, 4, 26), (11, 5, 26), (11, 6, 28), (11, 7, 28), (11, 8, 19), (11, 9, 19), (11, 10, 15), (11, 12, 20), (11, 13, 20), (11, 14, 19), (11, 15, 17), (11, 16, 17), (11, 17, 27), (11, 18, 24),
  (12, 1, 12), (12, 2, 12), (12, 3, 6), (12, 4, 8), (12, 5, 8), (12, 6, 10), (12, 7, 10), (12, 8, 6), (12, 9, 6), (12, 10, 9), (12, 11, 20), (12, 13, 0), (12, 14, 3), (12, 15, 7), (12, 16, 8), (12, 17, 38), (12, 18, 7),
  (13, 1, 12), (13, 2, 12), (13, 3, 6), (13, 4, 8), (13, 5, 8), (13, 6, 10), (13, 7, 10), (13, 8, 6), (13, 9, 6), (13, 10, 9), (13, 11, 20), (13, 12, 0), (13, 14, 3), (13, 15, 7), (13, 16, 8), (13, 17, 38), (13, 18, 7),
  (14, 1, 16), (14, 2, 16), (14, 3, 10), (14, 4, 12), (14, 5, 12), (14, 6, 13), (14, 7, 13), (14, 8, 9), (14, 9, 9), (14, 10, 10), (14, 11, 19), (14, 12, 3), (14, 13, 3), (14, 15, 3), (14, 16, 5), (14, 17, 34), (14, 18, 10),
  (15, 1, 20), (15, 2, 20), (15, 3, 13), (15, 4, 16), (15, 5, 16), (15, 6, 17), (15, 7, 17), (15, 8, 12), (15, 9, 12), (15, 10, 12), (15, 11, 17), (15, 12, 7), (15, 13, 7), (15, 14, 3), (15, 16, 1), (15, 17, 30), (15, 18, 14),
  (16, 1, 21), (16, 2, 21), (16, 3, 15), (16, 4, 17), (16, 5, 17), (16, 6, 19), (16, 7, 19), (16, 8, 14), (16, 9, 14), (16, 10, 13), (16, 11, 17), (16, 12, 8), (16, 13, 8), (16, 14, 5), (16, 15, 1), (16, 17, 29), (16, 18, 15),
  (17, 1, 50), (17, 2, 50), (17, 3, 44), (17, 4, 46), (17, 5, 46), (17, 6, 48), (17, 7, 48), (17, 8, 41), (17, 9, 41), (17, 10, 39), (17, 11, 27), (17, 12, 38), (17, 13, 38), (17, 14, 34), (17, 15, 30), (17, 16, 29), (17, 18, 44),
  (18, 1, 5), (18, 2, 5), (18, 3, 0), (18, 4, 1), (18, 5, 1), (18, 6, 3), (18, 7, 3), (18, 8, 5), (18, 9, 5), (18, 10, 9), (18, 11, 24), (18, 12, 7), (18, 13, 7), (18, 14, 10), (18, 15, 14), (18, 16, 15), (18, 17, 44);


-- Verify offset distances setup correctly (W
SELECT s1.StopName AS StopName1, s2.StopName AS StopName2, o.OffsetDistance FROM Stop AS s1, Stop AS s2, StopOffset AS o WHERE s1.StopID = o.StopID1 AND s2.StopID = o.StopID2 AND s1.StopName = 'Wellington Railway Station' ORDER BY o.OffsetDistance;

-- ---------------ROUTE---------------------
INSERT INTO Route (RouteName) VALUES
  ("Johnsonville Train Line"),
  ("Johnsonville > Newlands Bus Route"),
  ("Tawa Bus Route"),
  ("Kandallah Bus Route"),
   ("Waikanae Train Line"),
  ("Waterloo Bus Route"),
  ("Upper Hutt Train Line");

-- ---------------ROUTECOMPONENT---------------------
-- Johnsonville Train Line
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (3, 1),
  (4, 1),
  (6, 1),
  (1, 1);

-- Johnsonville > Newlands Bus Route
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (3, 2),
  (18, 2),
  (2, 2);

-- Tawa Bus Route
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (13, 3),
  (3, 3),
  (2, 3);

-- Kandallah Bus Route
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (5, 4),
  (7, 4),
  (2, 4);

-- Waikanae Train Line
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (17, 5),
  (16, 5),
  (15, 5),
  (14, 5),
  (12, 5),
  (1, 5);

-- Waterloo Bus Route
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (10, 6),
  (9, 6),
  (2, 6);

-- Upper Hutt Train Line
INSERT INTO RouteComponent (StopID, RouteID) VALUES
  (11, 7),
  (10, 7),
  (8, 7),
  (1, 7);

-- Test query to confirm route components correct input
SELECT rc.RouteComponentID, s.StopName, r.RouteName FROM Stop as s, Route as r, RouteComponent as rc WHERE r.RouteID = rc.RouteID AND s.StopID = rc.StopID ORDER BY rc.RouteComponentID;

-- ---------------SCHEDULE---------------------
-- Schedule a morning and an evening run for each route
-- Johnsonville Train Line
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 1, 11),
  (time("08:05"), time("08:06"), 2, 11),
  (time("08:13"), time("08:14"), 3, 11),
  (time("08:25"), null, 4, 11);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 4, 12),
  (time("08:11"), time("08:12"), 3, 12),
  (time("08:19"), time("08:20"), 2, 12),
  (time("08:25"), null, 1, 12);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 4, 11),
  (time("17:11"), time("17:12"), 3, 11),
  (time("17:19"), time("17:20"), 2, 11),
  (time("17:25"), null, 1, 11);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 1, 12),
  (time("17:05"), time("17:06"), 2, 12),
  (time("17:13"), time("17:14"), 3, 12),
  (time("17:25"), null, 4, 12);

-- Johnsonville > Newlands Bus Route
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 5, 1),
  (time("08:08"), time("08:08"), 6, 1),
  (time("08:28"), null, 7, 1);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 7, 2),
  (time("08:20"), time("08:20"), 6, 2),
  (time("08:28"), null, 5, 2);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 5, 1),
  (time("17:08"), time("17:08"), 6, 1),
  (time("17:28"), null, 7, 1);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 7, 2),
  (time("17:20"), time("17:20"), 6, 2),
  (time("17:28"), null, 5, 2);

-- Tawa Bus Route
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 8, 3),
  (time("08:15"), time("08:15"), 9, 3),
  (time("08:29"), null, 10, 3);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 10, 4),
  (time("08:14"), time("08:14"), 9, 4),
  (time("08:29"), null, 8, 4);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 8, 3),
  (time("17:15"), time("17:15"), 9, 3),
  (time("17:29"), null, 10, 3);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 10, 4),
  (time("17:14"), time("17:14"), 9, 4),
  (time("17:29"), null, 8, 4);

-- Kandallah Bus Route
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 11, 5),
  (time("08:09"), time("08:09"), 12, 5),
  (time("08:38"), null, 13, 5);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 13, 6),
  (time("08:29"), time("08:29"), 12, 6),
  (time("08:38"), null, 11, 6);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 11, 5),
  (time("17:09"), time("17:09"), 12, 5),
  (time("17:38"), null, 13, 5);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 13, 6),
  (time("17:29"), time("17:29"), 12, 6),
  (time("17:38"), null, 11, 6);

-- Waikanae Train Line
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 14, 13),
  (time("08:33"), time("08:34"), 15, 13),
  (time("08:53"), time("08:54"), 16, 13),
  (time("08:58"), time("08:59"), 17, 13),
  (time("09:08"), time("09:09"), 18, 13),
  (time("09:24"), null, 19, 13);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 19, 14),
  (time("08:15"), time("08:16"), 18, 14),
  (time("08:25"), time("08:26"), 17, 14),
  (time("08:30"), time("08:31"), 16, 14),
  (time("08:50"), time("08:51"), 15, 14),
  (time("09:24"), null, 14, 14);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 14, 13),
  (time("17:33"), time("17:34"), 15, 13),
  (time("17:53"), time("17:54"), 16, 13),
  (time("17:58"), time("17:59"), 17, 13),
  (time("18:08"), time("18:09"), 18, 13),
  (time("18:24"), null, 19, 13);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 19, 14),
  (time("17:15"), time("17:16"), 18, 14),
  (time("17:25"), time("17:26"), 17, 14),
  (time("17:30"), time("17:31"), 16, 14),
  (time("17:50"), time("17:51"), 15, 14),
  (time("18:24"), null, 14, 14);

-- Waterloo Bus Route
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 20, 7),
  (time("08:21"), time("08:21"), 21, 7),
  (time("08:39"), null, 22, 7);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 22, 8),
  (time("08:08"), time("08:08"), 21, 8),
  (time("08:39"), null, 20, 8);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 20, 7),
  (time("17:21"), time("17:21"), 21, 7),
  (time("17:39"), null, 22, 7);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 22, 8),
  (time("17:08"), time("17:08"), 21, 8),
  (time("17:39"), null, 20, 8);

-- Upper Hutt Train Line
-- (AM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 23, 9),
  (time("08:25"), time("08:26"), 24, 9),
  (time("08:34"), time("08:35"), 25, 9),
  (time("08:47"), null, 26, 9);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("08:00"), 26, 10),
  (time("08:12"), time("08:13"), 25, 10),
  (time("08:21"), time("08:22"), 24, 10),
  (time("08:47"), null, 23, 10);
-- (PM)
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 23, 9),
  (time("17:25"), time("17:26"), 24, 9),
  (time("17:34"), time("17:35"), 25, 9),
  (time("17:47"), null, 26, 9);
INSERT INTO Schedule (ArrivalTime, DepartureTime, RouteComponentID, VehicleID) VALUES
  (null, time("17:00"), 26, 10),
  (time("17:12"), time("17:13"), 25, 10),
  (time("17:21"), time("17:22"), 24, 10),
  (time("17:47"), null, 23, 10);

-- -----------------INCIDENTTYPE---------------------
INSERT INTO IncidentType (IncidentTypeName) VALUES
  ("Earthquake Damage"),
  ("Flooding"),
  ("Train Track Fault"),
  ("Road Closed - Special Event"),
  ("Road Closed - Road Works"),
  ("Power Outage");

-- -----------------INCIDENTTYPE---------------------
INSERT INTO Incident (IncidentName, OccurrenceDateTime, Resolution, IncidentTypeID) VALUES
  ("Kaikoura Earthquake", datetime("2016-11-14 11:02"),
   1, 1),
  ("Christchurch Earthquake", datetime("2011-02-22"), 1, 1),
  ("Wellington Earthquake", datetime('now'), 0, 1),
  ("Hutt Valley Flooding", datetime("2015-05-14 17:45"), 1, 2),
  ("Khandallah Power Outage", datetime("2009-06-17 08:00"), 1, 6),
  ("Newlands Main Trunk Upgrade", datetime("2015-08-12"), 1, 5),
  ("Lower Hutt Motorway Upgrade", datetime("2002-03-01"), 1, 5),
  ("Americas Cup Victory Parade", datetime("2017-07-11 12:00"), 1, 4),
  ("Rugby World Cup Victory Parade", datetime("2011-10-26 12:00"), 1, 4),
  ("Waterloo Station Track Fault", datetime("2016-03-13 05:30"), 1, 3),
  ("Ngaio Track Fault", datetime("2013-12-13 08:00"), 1, 3);

-- -----------------INCIDENTEFFECT---------------------
INSERT INTO IncidentEffect (StopID, IncidentID) VALUES
  (2, 1),
  (4, 2),
  (2, 3),
  (4, 3),
  (6, 3),
  (11, 4),
  (4, 5),
  (18, 6),
  (9, 7),
  (2, 8),
  (2, 9),
  (10, 10),
  (6, 11);