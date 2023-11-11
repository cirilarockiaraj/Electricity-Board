package connection;

import java.sql.*;

public class db
{
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException
    {
        String dbDriver = "com.mysql.jdbc.Driver";
        String dbURL = "jdbc:mysql:// localhost:3306/";
        // Database name to access
        String dbName = "electricity_board";
        String dbUsername = "root";
        String dbPassword = "";
  
        Class.forName(dbDriver);
        Connection conn = DriverManager.getConnection(dbURL + dbName,dbUsername, dbPassword);
        return conn;
    }
}
