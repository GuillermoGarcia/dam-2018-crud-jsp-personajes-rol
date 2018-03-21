# CRUD con JSP y BBDD

  Practica de acceso a bases de datos desde Java, en particular, la operaciones CRUD, alta, listado, modificación y borrado.

# Temática de la Practica

  Para esta practica, la temática sera la gestión de jugadores y sus personajes en distintas partidas de rol.

# Estructura de la Base de Datos

  Se usaran las siguientes tablas en la base de datos:

  * Partida
  * Jugador
  * Personaje

  En la siguiente imagen podemos ver dichas tablas con sus columnas y sus relaciones
  
  ![Estructura de las Tablas](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud01.jpg)


# JSP

  La página web esta presentada en una única página desde la cual podemos gestionar las tres entidades (Partidas, Jugadores y Personajes)

## Vista General

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud02.png)

  En el margen derecho encontramos los botones para crear nuevas entidades (Partidas, Jugadores y Personajes)
  En el resto de la página está el listado de todas las partidas, con su información
  * Nombre de la Partida
  * Director de la Partida
  * Descripción de la Partida
  * Personajes de la Partida (Jugador al que pertenece el Personaje)
  
## Gestión de las Partidas.

  Si usamos el botón para añadir una partida nueva, nos aparecerá una ventana emergente, como podéis ver en la siguiente imagen, con un formulario para rellenar los datos de la partida.

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud05.png)

  Esta ventana emergente también aparecerá si pulsamos sobre el botón "Editar Partida" pero con los datos de la partida rellenos.

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud06.png)

  Por último, al lado del botón "Editar Partida", encontramos el botón "Borrar Partida" con el que borramos una partida.
  _Nota: Si se borra una Partida los Personajes asignados a esa Partida no se borraran sino que quedaran libres._

## Gestión de los Jugadores.

  Si usamos el botón para añadir un nuevo jugador, nos aparecerá una ventana emergente, como podéis ver en la siguiente imagen, con un formulario para rellenar los datos del jugador.

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud03.png)

  Esta ventana emergente también aparecerá si pulsamos sobre el nombre del Jugador con los datos actuales del jugador, además aparecerá un botón extra para poder borrar el Jugador.
  _Nota: Un Jugador no podrá ser borrado mientras tenga algún Personaje._

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud04.png)

## Gestión de los Personajes.

  Si usamos el botón para añadir un nuevo personaje, nos aparecerá una ventana emergente, como podéis ver en la siguiente imagen, con un formulario para rellenar los datos del jugador.

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud07.png)

  Esta ventana emergente también aparecerá si pulsamos sobre el botón de Editar, de color azul, en la misma linea que el personaje, pero con los datos del personaje rellenos.

  ![Vista General](https://github.com/GuillermoGarcia/dam-2018-crud-jsp-personajes-rol/blob/master/jspcrud08.png)

  Si pulsamos sobre el botón de Borrar, de color rojo, en la misma linea que el personaje, se quitará dicho personaje de la partida.