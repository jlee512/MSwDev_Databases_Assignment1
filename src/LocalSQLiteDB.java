/**
 * Created by Julian on 18/09/2017.
 */

//Concrete implementation of AbstractDB Class. Instances of this class are to be used in command-line query tool.
public class LocalSQLiteDB extends AbstractDB {

    public LocalSQLiteDB(String jdbcName, String filepath) {
        super(jdbcName, filepath);
    }

}
