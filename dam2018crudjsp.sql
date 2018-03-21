-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-03-2018 a las 23:30:58
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dam2018crudjsp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idJugador` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Nick` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`idJugador`, `Nombre`, `Email`, `Nick`) VALUES
(1, 'Guillermo García', 'ggf@gmail.com', 'Ulric'),
(2, 'Julio Palma', 'restalion@gmail.com', 'Restalion'),
(3, 'Enrique Quintero', 'eq@gmail.com', 'Quique'),
(4, 'Jose Ruz', 'jruz@gmail.com', 'Ruty'),
(5, 'Alvaro Moreno', 'alvarf@gmail.com', 'Alvarf'),
(6, 'Eduardo Lopez', 'chamoridin@gmail.com', 'Chamoridin'),
(7, 'Jose María Casasola', 'casasola@gmail.com', 'Txemari');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `idPartida` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text NOT NULL,
  `ReglasUsadas` varchar(100) NOT NULL,
  `Director` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`idPartida`, `Nombre`, `Descripcion`, `ReglasUsadas`, `Director`) VALUES
(1, 'Orcos del Bosque Negro', 'En la profundidad del bosque negro una tribu de Orcos lucha por sobrevivir tras la caida del Señor Oscuro.', '', 3),
(2, 'Casacas Rojas', 'Un batallón de Casacas Rojas es enviado a lo largo de europa allí donde sucesos extraños acontecen.', '', 5),
(3, 'Tropas Espaciales', 'Como miembros del 4º Regimiento de Infanteria de Legionarios de Condor, al servicio del emperador, buscais venganza tras la destrucción de vuestro planeta, pero primero debeis recomponer vuestras filas y buscar una nueva base de operaciones.', '', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje`
--

CREATE TABLE `personaje` (
  `idPersonaje` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Raza` varchar(125) NOT NULL,
  `Edad` int(4) NOT NULL,
  `Jugador` int(11) NOT NULL,
  `Partida` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `personaje`
--

INSERT INTO `personaje` (`idPersonaje`, `Nombre`, `Raza`, `Edad`, `Jugador`, `Partida`) VALUES
(1, 'Zadrur', 'Trasgo', 21, 1, 1),
(2, 'Klodar', 'Uruk-hai', 22, 2, 1),
(3, 'Edward', 'Humano', 22, 4, 2),
(4, 'Joseph', 'Elfo', 19, 6, 2),
(5, 'Peter', 'Humano', 20, 7, 2),
(6, 'Gromarech', 'Orco de Moria', 22, 5, 1),
(7, 'Andrew', 'Humano', 24, 3, 3),
(8, 'Lorenz', 'Humano', 20, 2, 3),
(9, 'Chen', 'Humano', 22, 7, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idJugador`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`idPartida`),
  ADD KEY `Director` (`Director`);

--
-- Indices de la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD PRIMARY KEY (`idPersonaje`),
  ADD UNIQUE KEY `NombrePersonaje` (`Nombre`,`Jugador`),
  ADD KEY `Jugador` (`Jugador`),
  ADD KEY `Partida` (`Partida`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `partida_ibfk_1` FOREIGN KEY (`Director`) REFERENCES `jugador` (`idJugador`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD CONSTRAINT `Personaje_ibfk_1` FOREIGN KEY (`Partida`) REFERENCES `partida` (`idPartida`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Personaje_ibfk_2` FOREIGN KEY (`Jugador`) REFERENCES `jugador` (`idJugador`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
