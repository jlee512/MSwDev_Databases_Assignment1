-- Query (1) All routes that have
--
-- (A) Ever been affected
SELECT DISTINCT r.RouteName AS 'Route Affected'
FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie
WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID
GROUP BY r.RouteName, i.IncidentName;

-- (B) Never been affected
SELECT r.RouteName AS 'Routes Not Affected'
FROM Route AS r
WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID);

-- Query (2) The 10 routes that have been affected

-- (A) The most (descending order)
SELECT * FROM (
  SELECT r.RouteName AS 'Route', COUNT(r.RouteID) AS 'NumberOfIncidents'
  FROM Stop AS s, Route AS r, RouteComponent as rc, IncidentEffect AS ie
  WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID
  GROUP BY r.RouteName

  UNION

  SELECT r.RouteName AS 'Route', 0 AS 'NumberOfIncidents'
  FROM Stop AS s, Route AS r, RouteComponent as rc, IncidentEffect AS ie
  WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID) GROUP BY r.RouteName)

ORDER BY NumberOfIncidents DESC LIMIT 10;


-- (B) The least (ascending order)
SELECT * FROM (
SELECT r.RouteName AS 'Route', COUNT(r.RouteID) AS 'NumberOfIncidents'
FROM Stop AS s, Route AS r, RouteComponent as rc, IncidentEffect AS ie
WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID
GROUP BY r.RouteName

UNION

SELECT r.RouteName AS 'Route', 0 AS 'NumberOfIncidents'
FROM Stop AS s, Route AS r, RouteComponent as rc, IncidentEffect AS ie
WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID) GROUP BY r.RouteName)

ORDER BY NumberOfIncidents ASC LIMIT 10;

-- Query (3) All routes affected in the last 5 years
SELECT Route, strftime('%d-%m-%Y %H:%M', Max(Occurrence)) AS 'LastIncidentDate', (strftime('%Y', 'now') - strftime('%Y', Max(Occurrence))) AS 'YearsSinceLastOccurrence', IncidentName AS 'Incident Name' FROM
  (SELECT r.RouteName AS Route, i.OccurrenceDateTime AS Occurrence, i.IncidentName AS IncidentName
FROM Stop AS s, Route AS r, RouteComponent as rc, Incident AS i, IncidentEffect AS ie
WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND i.IncidentID = ie.IncidentID AND (datetime('now', '-5 year')) < i.OccurrenceDateTime
ORDER BY i.OccurrenceDateTime DESC)
GROUP BY Route;
