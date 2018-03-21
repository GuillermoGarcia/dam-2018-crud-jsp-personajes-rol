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


public class Personaje {
    
    
    public Personaje(){}

    public static String nombrePersonaje(int idPersonaje, Statement s){

      String nombre = "";
      
      try {
        ResultSet personaje = s.executeQuery ("SELECT * FROM personaje WHERE idPersonaje = " + idPersonaje + ";");
        personaje.last();
        nombre = personaje.getString("Nombre");
      } catch (SQLException e) {e.printStackTrace();}
      
      return nombre;
 
    }

    public static int idPersonaje(String nombre, Statement s){

      int id = 0;
      
      try {
        ResultSet personaje = s.executeQuery ("SELECT idPersonaje FROM personaje WHERE Nombre LIKE '" + nombre + "';");
        personaje.last();
        id = personaje.getInt("idPersonaje");
      } catch (SQLException e) {e.printStackTrace();}
      
      return id;
      
    }

    public static HashMap<Integer, String> personajesPartida(int idPartida, Statement s){

      HashMap<Integer, String> personajes = new HashMap<Integer, String>();
      
      try {
        ResultSet listadoPersonajes = s.executeQuery ("SELECT Nombre, Jugador FROM personaje" + 
                                           " WHERE Partida = " + idPartida + " ORDER BY Nombre DESC;");
        while (listadoPersonajes.next()){
          personajes.put(listadoPersonajes.getInt("Jugador"),listadoPersonajes.getString("Nombre"));
        }
      } catch (SQLException e) {e.printStackTrace();}
      
      return personajes;

    }

    public static int nuevoIdPersonaje(Statement s){
      
      int id = -1;
      
      try {
        ResultSet idPersonaje = s.executeQuery ("SELECT MAX(idPersonaje) AS idPersonaje FROM Personaje;");
        idPersonaje.last();
        id = idPersonaje.getInt("idPersonaje") + 1;
      } catch (SQLException e) {e.printStackTrace();}
      
      return id;
    }
    
    public static void guardarPersonaje(int id, String nombre, String raza, int edad, int jugador, Statement s){

      String insercion = "";
      
      if (id > -1 ){
        insercion += "UPDATE Personaje SET `Nombre`='" + nombre + "',`Raza`='" + raza + "',`Edad`=" +
                     edad + ",`Jugador`=" + jugador + " WHERE idPersonaje=" + id + ";";
      } else {
        id = nuevoIdPersonaje(s);
        insercion += "INSERT INTO Personaje VALUES (" + id + ", " + "'" + nombre + "', '" + raza +
                     "', " + edad +  ", " + jugador + ", NULL);";
      }

      try {
        s.execute (insercion);
      } catch (SQLException e) {e.printStackTrace();}
      
    }

    public static void borrarPersonaje(int id, Statement s){

      try {
        s.execute ("DELETE FROM Personaje WHERE idPersonaje = " + id + ";");
      } catch (SQLException e) {e.printStackTrace();}

    }
    
    public static void dejarPartida(String personaje, String jugador, Statement s){

      try {
        s.execute ("UPDATE Personaje SET Partida = NULL WHERE Jugador = " +
                  Jugador.idJugador(jugador, s) + " AND idPersonaje = " +
                  idPersonaje(personaje, s) + ";");
      } catch (SQLException e) {e.printStackTrace();}
      
    }

    public static void entrarPartida(int idPartida, int idPersonaje, Statement s){

      try {
        s.execute ("UPDATE Personaje SET Partida = " + idPartida + " WHERE idPersonaje = " +
                  idPersonaje + ";");
      } catch (SQLException e) {e.printStackTrace();}
      
    }

    public static HashMap<Integer, String> listadoPersonajes(Statement s){
      
      HashMap<Integer, String> personajes = new HashMap<Integer, String>();
      
      try {
        ResultSet listadoPersonajes = s.executeQuery ("SELECT idPersonaje, Nombre FROM personaje WHERE Partida IS NULL;");
        while (listadoPersonajes.next()){
          personajes.put(listadoPersonajes.getInt("idPersonaje"), listadoPersonajes.getString("Nombre"));
        }
      } catch (SQLException e) {e.printStackTrace();}
      
      return personajes;
              
    }

  public static String datosPersonaje(String personaje, String jugador, Statement s){

    String data = "";
    String query = "SELECT idPersonaje, Raza, Edad, Jugador FROM personaje WHERE Nombre LIKE '" +
                personaje +"' AND Jugador = " + Jugador.idJugador(jugador, s) + ";";
    try {
      ResultSet datosPersonaje = s.executeQuery (query);
      datosPersonaje.last();
      data += "{\"id\":" + datosPersonaje.getInt("idPersonaje") + ", ";
      data += "\"jugador\":" + datosPersonaje.getInt("Jugador") + ", ";
      data += "\"raza\":\"" + datosPersonaje.getString("Raza") + "\", ";
      data += "\"edad\":" + datosPersonaje.getInt("edad") + "}";
      
    } catch (SQLException e) {e.printStackTrace(); data = query;}

    return data;
  }
}

