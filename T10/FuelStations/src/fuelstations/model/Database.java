package fuelstations.model;

import javax.swing.JOptionPane;

public class Database {
    
    static final String DRIVER_JDBC = "org.apache.derby.jdbc.EmbeddedDriver";
    static final String URL_JDBC = "jdbc:derby://localhost:1527/FuelStationsDB";
    static final String USERNAME_JDBC = "fkrein";
    static final String PASSWORD_JDBC = "1qa3ed";
    
    //faz a conexão com o banco de dados
    public Database(){
        try {
            System.setProperty("jdbc.drivers", DRIVER_JDBC);
            Class.forName(DRIVER_JDBC);
        } catch(Exception ex){
            JOptionPane.showMessageDialog(null, "Couldn't connect to the database: " + ex);
        }
    }
    
}
