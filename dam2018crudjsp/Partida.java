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
import dam2018crudjsp.Jugador;
import java.util.HashMap;
import java.util.Map;

public class Partida {
    
    public Partida(Statement s){        
    }

    public static String nombrePartida(int idPartida, Statement s){

      String nombre = "";
      
      try {
        ResultSet listadoPartida = s.executeQuery ("SELECT * FROM partida WHERE idPartida = '" + idPartida + "';");
        nombre = listadoPartida.getString("Nombre");
      } catch (SQLException e) {e.printStackTrace();}
      
      return nombre;
 
    }

    public static String nombreDirector(int idPartida, Statement s){

      int idDirector = 0;
      
      try {
        ResultSet director = s.executeQuery ("SELECT director FROM partida WHERE idPartida = " + idPartida + ";");
        director.last();
        idDirector = director.getInt("director");
      } catch (SQLException e) {e.printStackTrace();}
      
      return Jugador.nombreJugador(idDirector, s);
              
    }
    
    public static String descripcionPartida(int idPartida, Statement s){

      String descp = "";
      
      try {
        ResultSet descrip = s.executeQuery ("SELECT Descripcion FROM partida WHERE idPartida = " + idPartida + ";");
        descrip.last();
        descp = descrip.getString("Descripcion");
      } catch (SQLException e) {e.printStackTrace();}
      
      return descp;
              
    }

    public static HashMap<String, String> listadoParticipantes(int idPartida, Statement s){
      
      HashMap<String, String> participantes = new HashMap<String, String>();
      HashMap<Integer, String> personajes = Personaje.personajesPartida(idPartida, s);
      for (Map.Entry personaje: personajes.entrySet()) {
        String nombrePersonaje = personaje.getValue().toString();
        String nombreJugador = Jugador.nombreJugador(Integer.parseInt(personaje.getKey().toString()), s);
        participantes.put(nombrePersonaje, nombreJugador);
      }
      return participantes;
    
    }
    
    public static HashMap<Integer, String> listadoPartidas(Statement s){
      
      HashMap<Integer, String> partidas = new HashMap<Integer, String>();
      
      try {
        ResultSet listadoPartida = s.executeQuery ("SELECT idPartida, Nombre FROM partida;");
        while (listadoPartida.next()){
          partidas.put(listadoPartida.getInt("idPartida"), listadoPartida.getString("Nombre"));
        }
      } catch (SQLException e) {e.printStackTrace();}
      
      return partidas;
      
    }
    
    public static int nuevoIdPartida(Statement s){
      
      int id = -1;
      
      try {
        ResultSet idPartida = s.executeQuery ("SELECT MAX(idPartida) AS idPartida FROM partida;");
        idPartida.last();
        id = idPartida.getInt("idPartida") + 1;
      } catch (SQLException e) {e.printStackTrace();}
      
      return id;
    }
    
    public static void guardarPartida(int id, String nombre, String descrip, int director, Statement s){
      
      String insercion = "";
      
      if (id > -1 ){
        insercion += "UPDATE Partida SET `Nombre`='" + nombre + "',`Descripcion`='" + descrip +
                     "',`Director`=" + director + " WHERE idPartida=" + id + ";";
      } else {
        id = nuevoIdPartida(s);
        insercion += "INSERT INTO Partida VALUES (" + id + ", " + "'" + nombre + "', '" + descrip +
                     "', '', " +  director + ");";
      }
      
      try {
        s.execute (insercion);
      } catch (SQLException e) {e.printStackTrace();}
      
      //return insercion;
    }   

    public static void borrarPartida(int id, Statement s){

      try {
        s.execute ("DELETE FROM Partida WHERE idPartida = " + id + ";");
      } catch (SQLException e) {e.printStackTrace();}

    }
    
}