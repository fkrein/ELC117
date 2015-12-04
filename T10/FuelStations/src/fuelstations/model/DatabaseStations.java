package fuelstations.model;

import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;

public class DatabaseStations {
    
    private String cnpj;
    private String razao_social;
    private String nome_fantasia;
    private String bandeira;
    private String endereco;
    private String bairro;
    private String cep;
    private String imagem;
    
    private static final String INSERT = "INSERT INTO STATIONSTABLE (cnpj, razao_social, nome_fantasia, bandeira, endereco, bairro, cep, imagem) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE = "UPDATE STATIONSTABLE SET razao_social = ?, nome_fantasia = ?, bandeira = ?, endereco = ?, bairro = ?, cep = ?, imagem = ?, WHERE cnpj = ?";
    private static final String DELETE = "DELETE FROM STATIONSTABLE WHERE cnpj = ?";
    private static final String SELECT = "SELECT cnpj, razao_social, nome_fantasia, bandeira, endereco, bairro, cep, imagem FROM STATIONSTABLE ";
    private static final String DELETE_STATIONS_FUELS = "DELETE FROM STATIONSTABLE WHERE cnpj = ?";
    private static final String SEARCH = "SELECT cnpj, razao_social, nome_fantasia, bandeira, endereco, bairro, cep, imagem FROM STATIONSTABLE WHERE bairro LIKE ";
    
    public DatabaseStations(){}
    
    public void Insert(Connection db_con){

        try {
            PreparedStatement ps = db_con.prepareStatement(INSERT);
            ps.setString(1, cnpj);
            ps.setString(2, razao_social);
            ps.setString(3, nome_fantasia);
            ps.setString(4, bandeira);
            ps.setString(5, endereco);
            ps.setString(6, bairro);
            ps.setString(7, cep);
            ps.setString(8, imagem);
            ps.executeUpdate();
            
        }catch(SQLException | HeadlessException ex){
           JOptionPane.showMessageDialog(null, "Couldn't insert data on database: " + ex);
        }
        
    }
    
    public void Update(Connection db_con){
        
        try {
            PreparedStatement ps = db_con.prepareStatement(UPDATE);ps.setString(1, cnpj);
            ps.setString(1, razao_social);
            ps.setString(2, nome_fantasia);
            ps.setString(3, bandeira);
            ps.setString(4, endereco);
            ps.setString(5, bairro);
            ps.setString(6, cep);
            ps.setString(7, imagem);
            ps.setString(8, cnpj);
            ps.executeUpdate();
            
        }catch(SQLException | HeadlessException ex){
           JOptionPane.showMessageDialog(null, "Couldn't update database: " + ex);
        }
        
    }
    
    public void Delete(Connection db_con){
        
        try{
            PreparedStatement ps = db_con.prepareStatement(DELETE);
            ps.setString(1, "'" + cnpj + "'");
            ps.executeUpdate(); 

        } catch(Exception ex){
            JOptionPane.showMessageDialog(null, "Couldn't exclude data from database: " + ex);
        }
    }
    
    public ArrayList<DatabaseStations> getFuelsList(Connection db_con){
        
        ArrayList stationslist = new ArrayList();
        
        try {
            PreparedStatement ps = db_con.prepareStatement(SELECT);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                cnpj = rs.getString(1);
                razao_social = rs.getString(2);
                nome_fantasia = rs.getString(3);
                bandeira = rs.getString(4);
                endereco = rs.getString(5);
                bairro = rs.getString(6);
                cep = rs.getString(7);
                imagem = rs.getString(8);
                stationslist.add(this);
            }
            
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Couldn't find data on database: " + ex);
        }
        
        return stationslist;
    }
    
    public ArrayList<DatabaseStations> PesquisaPorBairro(Connection db_con, String search){
            
            ArrayList stationslist = new ArrayList();

            try {
                PreparedStatement ps = db_con.prepareStatement(SEARCH + "'%" + search + "%'");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    cnpj = rs.getString(1);
                    razao_social = rs.getString(2);
                    nome_fantasia = rs.getString(3);
                    bandeira = rs.getString(4);
                    endereco = rs.getString(5);
                    bairro = rs.getString(6);
                    cep = rs.getString(7);
                    imagem = rs.getString(8);
                    stationslist.add(this);
                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, "Couldn't find data on database: " + ex);
        }
        
        return stationslist;
    }
    
}
