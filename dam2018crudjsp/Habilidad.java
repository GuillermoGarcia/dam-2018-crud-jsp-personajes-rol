/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author guillermogarciafernandez
 */

package dam2018crudjsp;


import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Habilidad {
    
    static Statement s;
    static ResultSet habilidad;
    
    public Habilidad(Statement s){        
    
        this.s = s;
        
    }

    static public String nombreHabilidad(int id){

      String nombre = "";
      try {
        habilidad = s.executeQuery ("SELECT * FROM habilidad WHERE idHabilidad = '" + id + "';");
        nombre = habilidad.getString("Nombre");
      } catch (SQLException e) {e.printStackTrace();}
      return nombre;
 
    }


    
}

