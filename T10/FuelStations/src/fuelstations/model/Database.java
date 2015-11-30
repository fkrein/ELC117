package fuelstations.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class Database {
    
    static final String DRIVER_JDBC = "org.apache.derby.jdbc.EmbeddedDriver";
    static final String URL_JDBC = "jdbc:derby://localhost:1527/FuelStationsDB";
    static final String USERNAME_JDBC = "fkrein";
    static final String PASSWORD_JDBC = "1qa3ed";
    
    public Database(){}
    
    //faz a conexão com o banco de dados
    public Connection Connect(){
        try {
            System.setProperty("jdbc.drivers", DRIVER_JDBC);
            Class.forName(DRIVER_JDBC);
            return DriverManager.getConnection(URL_JDBC, USERNAME_JDBC, PASSWORD_JDBC);
        } catch(ClassNotFoundException | SQLException ex){
            JOptionPane.showMessageDialog(null, "Couldn't connect to the database: " + ex);
            return null;
        }
    }
    
}
