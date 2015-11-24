package fuelstations;

import fuelstations.view.StationProperties;
import fuelstations.view.StationsList;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

public class FuelStations {

    public static void main(String[] args) {
        
        try {
            javax.swing.UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Unsupported nimbus (resourse available since JAVA SE 6 update 10): " + e);
        }
        
        new StationProperties().setVisible(true);
        new StationsList().setVisible(true);
        
    }
    
}
