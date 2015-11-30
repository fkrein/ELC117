package fuelstations.controller;

import fuelstations.model.Database;
import fuelstations.view.*;
import java.sql.Connection;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class Control {
    
    public Control(){
        
        //<editor-fold defaultstate="collapsed" desc="Nimbus">
        try {
            javax.swing.UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | UnsupportedLookAndFeelException e) {
            JOptionPane.showMessageDialog(null, "Unsupported nimbus (resourse available since JAVA SE 6 update 10): " + e);
        }
        //</editor-fold>
        
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                StationProperties sp = new StationProperties();
                StationsList sl = new StationsList();
                
                Database db = new Database();
                Connection db_con = db.Connect();
                
                sp.setVisible(true);
                sp.setLocationRelativeTo(null);
                sl.setVisible(true);
                sl.setLocationRelativeTo(null);
                
            }
        });
        
    }

}
