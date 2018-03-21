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
import java.util.HashMap;

public class Caracteristica {
    
    static Statement s;
    static ResultSet listadoCaracteristicas;
    static HashMap<String, Integer> valoresBase;
    static HashMap<String, Integer> valoresModificado;
    
    public Caracteristica(Statement s){        
    
        this.s = s;
        this.valoresBase = new HashMap<String, Integer>();
        this.valoresModificado = new HashMap<String, Integer>();
        
    }

    public static HashMap<String, Integer> getValoresBase(int id){

      String nombre = "";
      try {
        listadoCaracteristicas = s.executeQuery ("SELECT * FROM caracteristica WHERE idPersonaje = '" + id + "';");
        while (listadoCaracteristicas.next()){
          valoresBase.put(listadoCaracteristicas.getString("Nombre"), Integer.valueOf(listadoCaracteristicas.getInt("ValorBase")));          
        }
      } catch (SQLException e) {e.printStackTrace();}
      return valoresBase;
 
    }

    public static HashMap<String, Integer> getValoresModificados(int id){

      String nombre = "";
      try {
        listadoCaracteristicas = s.executeQuery ("SELECT * FROM caracteristica WHERE idPersonaje = '" + id + "';");
        while (listadoCaracteristicas.next()){          
          valoresModificado.put(listadoCaracteristicas.getString("Nombre"), Integer.valueOf(listadoCaracteristicas.getInt("ValorModificado")));
        }
      } catch (SQLException e) {e.printStackTrace();}
      return valoresModificado;
 
    }
    
}

