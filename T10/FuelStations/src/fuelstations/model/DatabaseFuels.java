package fuelstations.model;

import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;

public class DatabaseFuels {
    
    private int id;
    private String cnpj_station;
    private String tipo;
    private String preco;
    private String data_coleta;
    
    private static final String INSERT = "INSERT INTO FUELSTABLE (cnpj_station, tipo, preco, data_coleta) VALUES (?, ?, ?, ?)";
    private static final String UPDATE = "UPDATE FUELSTABLE SET cnpj_station = ?, tipo = ?, preco = ?, data_coleta = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM FUELSTABLE WHERE id = ?";
    private static final String SELECT = "SELECT id, cnpj_station, tipo, preco, data_coleta FROM FUELSTABLE ";
    private static final String DELETE_STATIONS_FUELS = "DELETE FROM FUELSTABLE WHERE cnpj_station = ?";
    
    public DatabaseFuels(){}
    
    public void Insert(Connection db_con){

        try {
            PreparedStatement ps = db_con.prepareStatement(INSERT);
            ps.setString(1, cnpj_station);
            ps.setString(2, tipo);
            ps.setString(3, preco);
            ps.setString(4, data_coleta);
            ps.executeUpdate();
            
        }catch(SQLException | HeadlessException ex){
           JOptionPane.showMessageDialog(null, "Couldn't insert data on database: " + ex);
        }
        
    }
    
    public void Update(Connection db_con){
        
        try {
            PreparedStatement ps = db_con.prepareStatement(UPDATE);
            ps.setString(1, cnpj_station);
            ps.setString(2, tipo);
            ps.setString(3, preco);
            ps.setString(4, data_coleta);
            ps.setInt(5, id);
            ps.executeUpdate();
            
        }catch(SQLException | HeadlessException ex){
           JOptionPane.showMessageDialog(null, "Couldn't update database: " + ex);
        }
        
    }
    
    public void Delete(Connection db_con){
        
        try{
            PreparedStatement ps = db_con.prepareStatement(DELETE);
            ps.setString(1, "'" + cnpj_station + "'");
            ps.executeUpdate(); 

        } catch(Exception ex){
            JOptionPane.showMessageDialog(null, "Couldn't exclude data from database: " + ex);
        }
    }
    
    public ArrayList<DatabaseFuels> getFuelsList(Connection db_con){
        
        ArrayList fuelslist = new ArrayList();
        
        try {
            
            PreparedStatement ps = db_con.prepareStatement(SELECT);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                id = rs.getInt(1);
                cnpj_station = rs.getString(2);
                tipo = rs.getString(3);
                preco = rs.getString(4);
                data_coleta = rs.getString(5);
                fuelslist.add(this);
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Couldn't find data on database: " + ex);
        }
        
        return fuelslist;
    }
    
    public void DeleteStationFuels(Connection db_con, String cnpj){
        
        try{
            PreparedStatement ps = db_con.prepareStatement(DELETE_STATIONS_FUELS);
            ps.setString(1, cnpj);
            ps.executeUpdate();
        } catch(Exception ex){
            JOptionPane.showMessageDialog(null, "Couldn't exclude fuels list: "+ ex);
        }
        
    }
    
}
