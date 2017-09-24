import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by Julian on 24/09/2017.
 */
public class Database_Queries {

    LocalSQLiteDB sqLiteDB;

    // Main method defining the command line tool for accessing the database
    public static void main(String[] args) {
        Database_Queries db_queries = new Database_Queries();
        boolean tool_running = true;
        System.out.println("Welcome to the Wellington Public Transport Database Query Tool");
        System.out.println("---------------------------oooooooo---------------------------");
        System.out.println();


        while (tool_running) {
            int selection = -1;
            //Output the query options
            db_queries.outputQueryOptions();
            //Read input using the Keyboard Class readInput() method
            try {
                selection = Integer.parseInt(Keyboard.readInput());
                if (selection < 1 || selection > 6) {
                    throw new NumberFormatException("Invalid query option");
                }
            } catch (NumberFormatException e) {
                System.out.println();
                System.out.println("Please enter a valid query option or quit (Number + press return)");
                System.out.println();
                continue;
            }

            switch (selection) {
                case 1:
                    db_queries.routesAffected();
                    break;
                case 2:
                    db_queries.routesNeverAffected();
                    break;
                case 3:
                    db_queries.top10MostAffected();
                    break;
                case 4:
                    db_queries.top10LeastAffected();
                    break;
                case 5:
                    db_queries.routesAffectedInLast5Years();
                    break;
                case 6:
                    tool_running = false;
                    System.out.println();
                    System.out.println("Thank you for using the Wellington Public Transport Query Tool");
                    System.out.println("Goodbye");
                    break;
            }

            System.out.println();
        }

    }

    //  Constructor for Database_Queries Class - creates new SQLiteDB object instance for use when this class is constructed
    public Database_Queries() {

        File database = new File("public_transport.sqlite");
        sqLiteDB = new LocalSQLiteDB("sqlite", database.getAbsolutePath());

    }

    public void outputQueryOptions() {
        System.out.println("---------------------------oooooooo---------------------------");
        System.out.println("Enter your Query Option (Number + press return): ");
        System.out.println("(1) - Review routes affected by incidents in network history");
        System.out.println("(2) - Review routes never affected by incidents in network history");
        System.out.println("(3) - Review Top 10 most affected routes");
        System.out.println("(4) - Review Top 10 least affected routes");
        System.out.println("(5) - Review routes affected in the last 5 years");
        System.out.println("(6) - EXIT AND CLOSE QUERY TOOL");
        System.out.println();
        System.out.println("User selection: ");
    }

    // Prepared Statements have been used - this will allow the query-tool to be dynamic/interactive at a later stage if this is desired
    // Please refer to assignment_queries.sql for cleaner SQL query interpretation

    // Method which extracts all Public Transport Routes which have been affected by 'Incidents' (at any stage)
    // Formatted output is printed to the console
    public void routesAffected() {
        try (Connection c = sqLiteDB.connection()) {
            try (PreparedStatement stmt = c.prepareStatement("SELECT DISTINCT r.RouteName AS 'Route Affected' FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID GROUP BY r.RouteName, i.IncidentName;")) {

                //Store the query results in a ResultSet object
                try (ResultSet r = stmt.executeQuery()) {
                    ArrayList<String> routes_affected = new ArrayList<>();
                    while (r.next()) {
                        routes_affected.add(r.getString("Route Affected"));
                    }

                    // Print query output to the console
                    System.out.println();
                    System.out.println("---------------Routes Affected in Network History------------");

                    System.out.println("Number of routes affected: " + routes_affected.size());
                    System.out.println("Individual Routes: ");
                    for (int i = 0; i < routes_affected.size(); i++) {
                        System.out.println((i + 1) + ". " + routes_affected.get(i));
                    }
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method which extracts all Public Transport Routes which have been NEVER been affected by 'Incidents' (at any stage)
    // Formatted output is printed to the console
    public void routesNeverAffected() {
        try (Connection c = sqLiteDB.connection()) {
            try (PreparedStatement stmt = c.prepareStatement("SELECT r.RouteName AS 'Routes Not Affected' FROM Route AS r WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID);")) {

                //Store the query results in a ResultSet object
                try (ResultSet r = stmt.executeQuery()) {
                    ArrayList<String> routes_never_affected = new ArrayList<>();
                    while (r.next()) {
                        routes_never_affected.add(r.getString("Routes Not Affected"));
                    }

                    // Print query output to the console
                    System.out.println();
                    System.out.println("---------------Routes Never Affected in Network History------------");

                    System.out.println("Number of routes never affected: " + routes_never_affected.size());
                    System.out.println("Individual Routes: ");
                    for (int i = 0; i < routes_never_affected.size(); i++) {
                        System.out.println((i + 1) + ". " + routes_never_affected.get(i));
                    }
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method which extracts the top 10 MOST affected routes in the network (descending order)
    // Formatted output is printed to the console
    public void top10MostAffected() {
        try (Connection c = sqLiteDB.connection()) {
            try (PreparedStatement stmt = c.prepareStatement("SELECT * FROM (SELECT r.RouteName AS 'Route', COUNT(r.RouteID) AS 'NumberOfIncidents' FROM Stop AS s, Route AS r, RouteComponent AS rc, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID GROUP BY r.RouteName UNION SELECT r.RouteName AS 'Route', 0 AS 'NumberOfIncidents' FROM Stop AS s, Route AS r, RouteComponent AS rc, IncidentEffect AS ie WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID) GROUP BY r.RouteName) ORDER BY NumberOfIncidents DESC LIMIT 10;")) {

                //Store the query results in a ResultSet object
                try (ResultSet r = stmt.executeQuery()) {
                    ArrayList<String> routes_affected = new ArrayList<>();
                    ArrayList<Integer> number_of_incidents = new ArrayList<>();
                    while (r.next()) {
                        routes_affected.add(r.getString("Route"));
                        number_of_incidents.add(r.getInt("NumberOfIncidents"));
                    }

                    // Print query output to the console
                    System.out.println();
                    System.out.println("---------------Top 10 Routes MOST Affected in Network History------------");

                    System.out.println("Individual Routes: ");
                    for (int i = 0; i < routes_affected.size(); i++) {
                        System.out.print((i + 1) + ". " + routes_affected.get(i));
                        System.out.println(" -> " + number_of_incidents.get(i) + " incidents");
                    }
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method which extracts the top 10 LEAST affected routes in the network (ascending order)
    // Formatted output is printed to the console
    public void top10LeastAffected() {
        try (Connection c = sqLiteDB.connection()) {
            try (PreparedStatement stmt = c.prepareStatement("SELECT * FROM (SELECT r.RouteName AS 'Route', COUNT(r.RouteID) AS 'NumberOfIncidents' FROM Stop AS s, Route AS r, RouteComponent AS rc, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID GROUP BY r.RouteName UNION SELECT r.RouteName AS 'Route', 0 AS 'NumberOfIncidents' FROM Stop AS s, Route AS r, RouteComponent AS rc, IncidentEffect AS ie WHERE r.RouteID NOT IN (SELECT r.RouteID FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND ie.IncidentID = i.IncidentID) GROUP BY r.RouteName) ORDER BY NumberOfIncidents ASC LIMIT 10;")) {

                //Store the query results in a ResultSet object
                try (ResultSet r = stmt.executeQuery()) {
                    ArrayList<String> routes_affected = new ArrayList<>();
                    ArrayList<Integer> number_of_incidents = new ArrayList<>();
                    while (r.next()) {
                        routes_affected.add(r.getString("Route"));
                        number_of_incidents.add(r.getInt("NumberOfIncidents"));
                    }

                    // Print query output to the console
                    System.out.println();
                    System.out.println("---------------Top 10 Routes LEAST Affected in Network History------------");

                    System.out.println("Individual Routes: ");
                    for (int i = 0; i < routes_affected.size(); i++) {
                        System.out.print((i + 1) + ". " + routes_affected.get(i));
                        System.out.println(" -> " + number_of_incidents.get(i) + " incidents");
                    }
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method which extracts the routes which have been affected in the last 5 years (Only the most recent event is displayed in the output)
    // Formatted output is printed to the console
    public void routesAffectedInLast5Years() {
        try (Connection c = sqLiteDB.connection()) {
            try (PreparedStatement stmt = c.prepareStatement("SELECT Route, strftime('%d-%m-%Y %H:%M', Max(Occurrence)) AS 'LastIncidentDate', (strftime('%Y', 'now') - strftime('%Y', Max(Occurrence))) AS 'YearsSinceLastOccurrence', IncidentName AS 'Incident Name' FROM (SELECT r.RouteName AS Route, i.OccurrenceDateTime AS Occurrence, i.IncidentName AS IncidentName FROM Stop AS s, Route AS r, RouteComponent AS rc, Incident AS i, IncidentEffect AS ie WHERE s.StopID = rc.StopID AND r.RouteID = rc.RouteID AND ie.StopID = s.StopID AND i.IncidentID = ie.IncidentID AND (datetime('now', '-5 year')) < i.OccurrenceDateTime ORDER BY i.OccurrenceDateTime DESC) GROUP BY Route;")) {

                //Store the query results in a ResultSet object
                try (ResultSet r = stmt.executeQuery()) {
                    ArrayList<String> routes_affected = new ArrayList<>();
                    ArrayList<String> last_incident = new ArrayList<>();
                    ArrayList<String> years_since_last = new ArrayList<>();
                    ArrayList<String> incident_names = new ArrayList<>();
                    while (r.next()) {
                        routes_affected.add(r.getString("Route"));
                        last_incident.add(r.getString("LastIncidentDate"));
                        years_since_last.add(r.getString("YearsSinceLastOccurrence"));
                        incident_names.add(r.getString("Incident Name"));
                    }

                    // Print query output to the console
                    System.out.println();
                    System.out.println("---------------Routes Affected in the Last 5 Years------------");

                    System.out.println("Individual Routes: ");
                    for (int i = 0; i < routes_affected.size(); i++) {
                        System.out.println((i + 1) + ". " + routes_affected.get(i));
                        System.out.println("    Years Since Last Incident: " + years_since_last.get(i));
                        System.out.println("    Date of Last Incident: " + last_incident.get(i));
                        System.out.println("    Incident Name: " + incident_names.get(i));
                        System.out.println("        ...");
                    }
                    System.out.println();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
