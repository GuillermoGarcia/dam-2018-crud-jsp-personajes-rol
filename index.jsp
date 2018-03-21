<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="dam2018crudjsp.Partida"%>
<%@page import="dam2018crudjsp.Jugador"%>
<%@page import="dam2018crudjsp.Personaje"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./style.css">
    
    <title>Información de Partidas de Rol - Guillermo García</title>
  </head>

  <body>
		<div class="container">
			<br><br>			
      <div class="panel panel-primary">
        <div class="panel-heading text-center"><h2>Información de Partidas de Rol</h2></div>

        <%
          
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/dam2018crudjsp","root", "");
          Statement s = conexion.createStatement();

          HashMap<Integer, String> jugadores = Jugador.listadoJugadores(s);
        %>
        <div class="grid-lateral">
          <div>
            <div id="crearJugador" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Nuevo Jugador</div>
            <div id="crearPartida" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Nueva Partida</div>
            <div id="crearPersonaje" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Nuevo Personaje</div>
          </div>
          <div class="partidas">
            <h2>Información de las Partidas</h2>

            <%
              HashMap<Integer, String> partidas = Partida.listadoPartidas(s);
              for (Map.Entry partida: partidas.entrySet()) {
                String nombrePartida = partida.getValue().toString();
                int idPartida = Integer.parseInt(partida.getKey().toString());
                String nombreDirector = Partida.nombreDirector(idPartida, s);
                String descripcionPartida = Partida.descripcionPartida(idPartida, s);
            %>
            <div>
              <h3><%=nombrePartida%></h3>
              <form method="get" class="borrado" action="borrarPartida.jsp">
                <input type="hidden" name="idPartida" value="<%=idPartida%>">
                <button type="submit" value="Añadir" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Borrar Partida</button>
              </form>
              <div id="editarPartida" class="btn btn-primary edicionDatos" data-idpartida="<%=idPartida%>" data-nombre="<%=nombrePartida%>" data-director="<%=nombreDirector%>" data-descp="<%=descripcionPartida%>">
                <span class="glyphicon glyphicon-edit"></span> Editar Partida
              </div>
            </div>
            <div class="grid2">
              <div>
                <h3>Director: <%=nombreDirector%></h3><br />
                <h3>Descripcion</h3>
                <p><%=descripcionPartida%></p>
              </div>
              <div>
                <div>
                  <h4>Personajes (Jugador)</h4>
                  <ul class="personajes">
                  <%
                    HashMap<String, String> participantes = Partida.listadoParticipantes(idPartida, s);
                    String listadoPersonajes = "";
                    if (participantes.isEmpty()){
                      listadoPersonajes = "<li>Ninguno</li>";
                    } else {
                      for (Map.Entry participante: participantes.entrySet()) {
                        String pj = participante.getKey().toString();
                        String jug = participante.getValue().toString();
                  %>
                  <li><%=pj%> (<a class="editJUG" title="Editar Jugador" data-jug="<%=jug%>"><%=jug%></a>)
                      <form method="get" action="quitarPersonajePartida.jsp">
                      <input type="hidden" name="nombrePersonaje" value="<%=pj%>">
                      <input type="hidden" name="nombreJugador" value="<%=jug%>">
                      <button type="submit" value="Añadir" class="btn btn-danger">
                      <span class="glyphicon glyphicon-remove"></span></button></form>
                      <form><button type="button" class="btn btn-primary editPJ" data-pj="<%=pj%>"
                      data-jug="<%=jug%>"><span class="glyphicon glyphicon-edit"></span></button></form>
                    </li>
                  <%
                      }
                    }
                  %>
                  </ul>
                  <div class="btn btn-primary addPj" data-partida="<%=idPartida%>"><span class="glyphicon glyphicon-plus"></span> Añadir Personaje</div>
                </div>                
                <div id="Partida<%=idPartida%>" class="anadirPj" style="display:none;">
                  <form  method="get" action="addPersonajePartida.jsp">
                    <input type="hidden" name="idPartida" value="">
                    <label for="personajes">¿Que Personaje desea añadir a la partida?</label>
                    <select name="personajes">
                      <option value="-1">Seleccione un Personaje</option>
                      <%
                        HashMap<Integer, String> personajes = Personaje.listadoPersonajes(s);
                        for (Map.Entry personaje: personajes.entrySet()) {
                          String nombrePersonaje = personaje.getValue().toString();
                          int idPersonaje = Integer.parseInt(personaje.getKey().toString());
                      %>
                      <option value="<%=idPersonaje%>"><%=nombrePersonaje%></option>
                      <%
                        }
                      %>
                      </select>
                      <button type="submit" value="Añadir" class="btn btn-secundary submitAddPj">
                        <span class="glyphicon glyphicon-plus"></span></button>
                    </form>
                  </div>
              </div>
            </div>
            <div class="separador"></div>
          <%
            } // Fin for Linea 49

            conexion.close();
          %>

          </div>
        </div>
      <div class="text-center">&copy; Guillermo García Fernández</div>
    </div>
    <div class="creacion" style="display: none;">
      <div id="creacionPartida" style="display: none;">
        <form method="get" action="guardarPartida.jsp">
          <input type="hidden" name="idPartida" value="-1">
          <div>
            <label for="nombre">Nombre Partida: </label>
            <input type="text" name="nombrePartida" size="50">
          </div>
          <div>
            <label for="director">Director de Partida: </label>
            <select name="directorPartida">
              <option value="-1">Seleccione un Director</option>
            <%
              for (Map.Entry jugador: jugadores.entrySet()) {
                String nombreJugador = jugador.getValue().toString();
                int idJugador = Integer.parseInt(jugador.getKey().toString());
            %>
              <option value="<%=idJugador%>"><%=nombreJugador%></option>
            <%
              }
            %>
            </select>
          </div>
          <div>
            <label for="descripcionPartida">Descripción Partida: </label>
            <textarea name="descripcionPartida" rows="3" cols="60"></textarea>
          </div>
          <button type="submit" value="Añadir" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Guardar</button>          
          <button type="button" value="Cancelar" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>          
         </form>
      </div>
      <div id="creacionJugador" style="display: none;">
        <form method="get" action="guardarJugador.jsp">
          <input type="hidden" name="idJugador" value="-1">
          <div>
            <label for="nombre">Nombre Jugador: </label>
            <input type="text" name="nombreJugador" size="50">
          </div>
          <div>
            <label for="email">Correo Electronico: </label>
            <input type="e-mail" name="emailJugador" size="50">
          </div>
          <div>
            <label for="nickJugador">Nick Jugador: </label><br />
            <input type="text" name="nickJugador" size="50">
          </div>
          <button type="submit" value="Añadir" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Guardar</button>          
          <button type="button" value="Cancelar" class="btn btn-danger">Cancelar</button>
          <button id="borradoJugador" type="button" value="Cancelar" class="btn btn-danger" style="display:none;"><span class="glyphicon glyphicon-remove"></span> Borrar</button>
         </form>
      </div>
      <div id="creacionPersonaje" style="display: none;">
        <form method="get" action="guardarPersonaje.jsp">
          <input type="hidden" name="idPersonaje" value="-1">
          <div>
            <label for="nombrePersonaje">Nombre del Personaje: </label>
            <input type="text" name="nombrePersonaje" size="50">
          </div>
          <div>
            <label for="razaPersonaje">Raza del Personaje: </label>
            <input type="text" name="razaPersonaje" size="50">
          </div>
          <div>
            <label for="edadPersonaje">Edad del Personaje: </label>
            <input type="number" name="edadPersonaje" value="18" min="18" max="1000">
          </div>
          <div>
            <label for="jugadorPersonaje">Jugador: </label>
            <select name="jugadorPersonaje">
              <option value="-1">Seleccione un Jugador</option>
            <%
              for (Map.Entry jugador: jugadores.entrySet()) {
                String nombreJugador = jugador.getValue().toString();
                int idJugador = Integer.parseInt(jugador.getKey().toString());
            %>
              <option value="<%=idJugador%>"><%=nombreJugador%></option>
            <%
              }
            %>
            </select>
          </div>
          <button type="submit" value="Añadir" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Guardar</button>          
          <button type="button" value="Cancelar" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>          
         </form>
      </div>          
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <script src="./main.js"></script>
  </body>
</html>