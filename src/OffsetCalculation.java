import java.util.ArrayList;

/**
 * Created by Julian on 22/09/2017.
 */

//Java Class prepared to calculate the offset distances between each stop (18 ^ 2 calculations, decided to automate). Outputs a string which is then used within the database_setup script

public class OffsetCalculation {

    public static int earth_radius = 6371;
    ArrayList<Double> latitudes = new ArrayList<>();
    ArrayList<Double> longitudes = new ArrayList<>();

//    Constructor which populates latitude/longitude ArrayList
    OffsetCalculation() {
        latitudes.add(-41.2796091);
        longitudes.add(174.7786341);
        latitudes.add(-41.2796091);
        longitudes.add(174.7786341);
        latitudes.add(-41.223345);
        longitudes.add(174.8047433);
        latitudes.add(-41.2427911);
        longitudes.add(174.7934473);
        latitudes.add(-41.2427911);
        longitudes.add(174.7934473);
        latitudes.add(-41.2509827);
        longitudes.add(174.7719325);
        latitudes.add(-41.2509827);
        longitudes.add(174.7719325);
        latitudes.add(-41.2219427);
        longitudes.add(174.8693815);
        latitudes.add(-41.2219427);
        longitudes.add(174.8693815);
        latitudes.add(-41.2138367);
        longitudes.add(174.9188543);
        latitudes.add(-41.1262323);
        longitudes.add(175.0703175);
        latitudes.add(-41.1693644);
        longitudes.add(174.8283628);
        latitudes.add(-41.1693644);
        longitudes.add(174.8283628);
        latitudes.add(-41.137454);
        longitudes.add(174.8433939);
        latitudes.add(-41.1063152);
        longitudes.add(174.8662679);
        latitudes.add(-41.0952204);
        longitudes.add(174.8683278);
        latitudes.add(-40.8765871);
        longitudes.add(175.0662132);
        latitudes.add(-41.2313266);
        longitudes.add(174.8097958);
    }

//    Calculate distance function based on Haversine Function
    public double calculateDistances(double latitude1, double longitude1, double latitude2, double longitude2) {

        double diffLatRad = Math.toRadians(latitude2 - latitude1);
        double diffLongRad = Math.toRadians(longitude2 - longitude1);

        double a = Math.sin(diffLatRad / 2) * Math.sin(diffLatRad / 2) + Math.cos(Math.toRadians(latitude1)) * Math.cos(Math.toRadians(latitude2)) * Math.sin(diffLongRad / 2) * Math.sin(diffLongRad / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double d = earth_radius * c;

        return d;

    }

//  Nested loop to Calculate all distance permutations and output a string which can be used within the SQLite table construction
    public String calculateAllDistances (ArrayList<Double> latitudes, ArrayList<Double> longitudes) {

        String database_entry = "";

        for (int i = 0; i < latitudes.size(); i++) {
            for (int j = 0; j < longitudes.size(); j++) {
                if (i != j) {
                    int stop1 = i + 1;
                    int stop2 = j + 1;
                    int distance = (int)calculateDistances(latitudes.get(i), longitudes.get(i), latitudes.get(j), longitudes.get(j));
                    database_entry += "(" + stop1 + ", " + stop2 + ", " + distance + "), ";
                }


            }
            database_entry += "\n";
        }

        return database_entry;

    }

    public static void main(String[] args) {
        OffsetCalculation offsetCalculation = new OffsetCalculation();
        System.out.println(offsetCalculation.calculateAllDistances(offsetCalculation.latitudes, offsetCalculation.longitudes));
    }

}
