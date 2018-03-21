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

public class Jugador {
    
    
    static ResultSet jugador;
    
    public Jugador(){}

    public static String nombreJugador(int idJugador, Statement s){

      String nombre = "";
      try {
        jugador = s.executeQuery ("SELECT Nombre FROM jugador WHERE idJugador = " + idJugador + ";");
        jugador.last();
        nombre = jugador.getString("Nombre");
      } catch (SQLException e) {e.printStackTrace();}
      return nombre;
 
    }

    public static int idJugador(String nombre, Statement s){

      int id = 0;
      try {
        jugador = s.executeQuery ("SELECT idJugador FROM jugador WHERE Nombre LIKE '" + nombre + "';");
        jugador.last();
        id = jugador.getInt("idJugador");
      } catch (SQLException e) {e.printStackTrace();}
      return id;    
    }

    public static HashMap<Integer, String> listadoJugadores(Statement s){
      
      HashMap<Integer, String> jugadores = new HashMap<Integer, String>();
      
      try {
        ResultSet listadoJugadores = s.executeQuery ("SELECT idJugador, Nombre FROM jugador;");
        while (listadoJugadores.next()){
          jugadores.put(listadoJugadores.getInt("idJugador"), listadoJugadores.getString("Nombre"));
        }
      } catch (SQLException e) {e.printStackTrace();}
      
      return jugadores;
              
    }

    public static int nuevoIdJugador(Statement s){
      
      int id = -1;
      
      try {
        ResultSet idJugador = s.executeQuery ("SELECT MAX(idJugador) AS idJugador FROM Jugador;");
        idJugador.last();
        id = idJugador.getInt("idJugador") + 1;
      } catch (SQLException e) {e.printStackTrace();}
      
      return id;
    }
    
    public static void guardarJugador(int id, String nombre, String email, String nick, Statement s){
      
      String insercion = "";
      
      if (id > -1 ){
        insercion += "UPDATE Jugador SET `Nombre`='" + nombre + "',`Email`='" + email + "',`Nick`='" +
                     nick + "' WHERE idJugador=" + id + ";";
      } else {
        id = nuevoIdJugador(s);
        insercion += "INSERT INTO Jugador VALUES (" + id + ", " + "'" + nombre + "', '" + email +
                     "', '" + nick + "');";
      }

      try {
        s.execute (insercion);
      } catch (SQLException e) {e.printStackTrace();}
      
      //return insercion;
    }

    public static void borrarJugador(int id, Statement s){

      try {
        s.execute ("DELETE FROM Jugador WHERE idJugador = " + id + ";");
      } catch (SQLException e) {e.printStackTrace();}

    }

  public static String datosJugador(String jugador, Statement s){

    String data = "";
    String query = "SELECT idJugador, Email, Nick FROM jugador WHERE Nombre LIKE '" + jugador + "';";
    try {
      ResultSet datosPersonaje = s.executeQuery (query);
      datosPersonaje.last();
      data += "{\"id\":" + datosPersonaje.getInt("idJugador") + ", ";
      data += "\"email\":\"" + datosPersonaje.getString("Email") + "\", ";
      data += "\"nick\":\"" + datosPersonaje.getString("Nick") + "\"}";
      
    } catch (SQLException e) {e.printStackTrace(); data = query;}

    return data;
  }

}

