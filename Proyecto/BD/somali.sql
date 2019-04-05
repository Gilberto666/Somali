-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-04-2019 a las 21:07:24
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `somali`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddComentario` (IN `_id_mensaje` INT, IN `_nombre_co` VARCHAR(100), IN `_apellido_co` VARCHAR(100), IN `_email_co` VARCHAR(100), IN `_mensaje` VARCHAR(250), IN `_fecha_co` DATE, IN `_visibilidad` TINYINT(1), IN `_resid_respuesta` INT)  BEGIN
	declare nombreSE varchar(100);
    declare apellidoSE varchar(100);
    declare emailSE varchar(100);
	declare mensajeSE VARCHAR(250);
    
    SELECT TRIM(_nombre_co) INTO nombreSE;    
    SELECT TRIM(_apellido_co) INTO apellidoSE;    
    SELECT TRIM(_email_co) INTO emailSE;    
    SELECT TRIM(_mensaje) INTO mensajeSE;    

	IF (nombreSE = "") THEN
		SELECT "El campo Nombre no puede estar vacio";	
	ELSEIF (apellidoSE = "") THEN
		SELECT "El campo Apellido no puede estar vacio";	
	ELSEIF (emailSE = "") THEN
		SELECT "El campo Email no puede estar vacio";	        
	ELSEIF (mensajeSE = "") THEN
		SELECT "El campo Mensaje no puede estar vacio";
	ELSE
		IF (_id_mensaje) THEN 
			UPDATE comentario SET nombre_co=nombreSE, apellido_co=apellidoSE,email_co=emailSE,mensaje=mensajeSE,fecha_co=_fecha_co,
            visibilidad=_visibilidad,resid_respuesta=_resid_respuesta
			WHERE id_mensaje = _id_mensaje;
		ELSE 
			INSERT INTO comentario VALUES (null,nombreSE,apellidoSE,emailSE,mensajeSE,_fecha_co,0,null);
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProd` (IN `_id_producto` INT, IN `_imagen` VARCHAR(150), IN `_nom_producto` VARCHAR(100), IN `_descripcion` VARCHAR(100), IN `_precio` DOUBLE, IN `_cantidad` DOUBLE, IN `_estatus` TINYINT(1))  BEGIN
	DECLARE imagenSE VARCHAR(100);
    DECLARE nom_productoSE VARCHAR(100);
    DECLARE descripcionSE VARCHAR(100);
    DECLARE precioSE double;
    DECLARE cantidadSE double;
    declare n int;
    SELECT TRIM(_imagen) INTO imagenSE;    
    SELECT TRIM(_nom_producto) INTO nom_productoSE;       
    SELECT TRIM(_descripcion) INTO descripcionSE;       
    SELECT TRIM(_precio) INTO precioSE;       
    SELECT TRIM(_cantidad) INTO cantidadSE;       
    

    select count(nom_producto) into n from producto where trim(nom_producto)=nom_productoSE;
	IF (imagenSE = "") THEN
			SELECT "El campo Imagen no puede estar vacio";	
			ELSEIF (nom_productoSE = "") THEN
				SELECT "El campo Nombre no puede estar vacio";	
			ELSEIF (descripcionSE = "") THEN
				SELECT "El campo Descripción no puede estar vacio";	
			ELSEIF (precioSE = "") THEN
				SELECT "El campo Precio no puede estar vacio";	
			ELSEIF (cantidadSE = "") THEN
				SELECT "El campo Cantidad no puede estar vacio";	
		ELSE
			IF (_id_producto) THEN 
				UPDATE producto SET imagen = imagenSE, nom_producto=nom_productoSE, descripcion=descripcionSE, precio=precioSE, 
				cantidad=cantidadSE, estatus=_estatus WHERE id_producto = _id_producto;
			ELSE 
				INSERT INTO producto VALUES (null,imagenSE,nom_productoSE,descripcionSE,precioSE,cantidadSE,0);
			END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddResp` (IN `_id_respuesta` INT, IN `_respuesta` VARCHAR(250))  BEGIN
	DECLARE respuestaSE VARCHAR(250);
    declare n int;
	SELECT TRIM(_respuesta) INTO respuestaSE;
    select count(respuesta) into n from respuesta where trim(respuesta)=respuestaSE;

    IF n > 0 then
		select "La Respuesta existe" as "Error..";    
    ELSE
		IF (respuestaSE = "") THEN
			SELECT "El campo Respuesta no puede estar vacio";	
		ELSE
			IF (_id_respuesta) THEN 
				UPDATE respuesta SET respuesta = respuestaSE
				WHERE id_respuesta = _id_respuesta;
			ELSE 
				INSERT INTO respuesta VALUES (null,respuestaSE);
			END IF;
		END IF;
	 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (IN `_id_admin` INT, IN `_nombre` VARCHAR(100), IN `_apellido` VARCHAR(100), IN `_email` VARCHAR(100), IN `_password` VARCHAR(100), IN `_tarea` TINYINT(1))  BEGIN
	DECLARE nombreSE VARCHAR(100);
	DECLARE apellidoSE VARCHAR(100);
	DECLARE emailSE VARCHAR(100);
	DECLARE passwordSE VARCHAR(100);
    declare n int;
	SELECT TRIM(_nombre) INTO nombreSE;
	SELECT TRIM(_apellido) INTO apellidoSE;
	SELECT TRIM(_email) INTO emailSE;
	SELECT TRIM(_password) INTO passwordSE;
    select count(email) into n from administrador where trim(email)=emailSE;
   		IF (nombreSE = "") THEN
			SELECT "El campo Nombre no puede estar vacio";	
		ELSEIF (apellidoSE = "") THEN
			SELECT "El campo Apellidos no puede estar vacio";	
		ELSEIF (emailSE = "") THEN
			SELECT "El campo Email no puede estar vacio";	
		ELSEIF (passwordSE = "") THEN
			SELECT "El campo Password no puede estar vacio";	
		ELSE
			IF (_id_admin) THEN 
				UPDATE administrador SET nombre = nombreSE,apellido=apellidoSE,email=emailSE,password=passwordSE, tarea=_tarea
				WHERE id_admin = _id_admin;
			ELSE
            
            
				INSERT INTO administrador VALUES (null,nombreSE,apellidoSE,emailSE,passwordSE,0);
		END IF;
	 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelComentario` (IN `_id_mensaje` INT)  begin
		delete from comentario where id_mensaje = _id_mensaje;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelProd` (IN `_id_producto` INT)  begin
		delete from producto where id_producto = _id_producto;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelResp` (IN `_id_respuesta` INT)  begin
		delete from respuesta where id_respuesta = _id_respuesta;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelUser` (IN `_id_admin` INT)  begin
	delete from administrador where id_admin = _id_admin;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_admin` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `tarea` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_admin`, `nombre`, `apellido`, `email`, `password`, `tarea`) VALUES
(1, 'Ernesto', 'Rico Gutiérrez', 'netoricow@hotmail.com', 'somali', 4),
(4, 'Hassan Yamill', 'Martínez Soto', 'hassanyamillm@gmail.com', 'somali', 1),
(5, 'Mariana', 'Almanza Barajas', 'mariana.al.ba@hotmail.com', 'somali', 1),
(7, 'Angelíca', 'González García', 'Angelica.Garcia5074@hotmail.com', 'somali', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id_mensaje` int(11) NOT NULL,
  `nombre_co` varchar(100) NOT NULL,
  `apellido_co` varchar(100) NOT NULL,
  `email_co` varchar(100) NOT NULL,
  `mensaje` varchar(250) NOT NULL,
  `fecha_co` date NOT NULL,
  `visibilidad` tinyint(1) NOT NULL,
  `resid_respuesta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`id_mensaje`, `nombre_co`, `apellido_co`, `email_co`, `mensaje`, `fecha_co`, `visibilidad`, `resid_respuesta`) VALUES
(1, 'Ernesto', 'Rico', 'netoricow@gmail.com', 'Mensaje Prueba', '2019-03-12', 1, 1),
(2, 'Alexis', 'Estrada', 'dfghjhd@ghjk.com', 'Hassan es puto', '2019-03-16', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `imagen` varchar(150) NOT NULL,
  `nom_producto` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `precio` double NOT NULL,
  `cantidad` double NOT NULL,
  `estatus` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `imagen`, `nom_producto`, `descripcion`, `precio`, `cantidad`, `estatus`) VALUES
(6, 'somali.jpg', 'Prueba', 'Producto Prueba Número Uno', 45, 123, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuesta`
--

CREATE TABLE `respuesta` (
  `id_respuesta` int(11) NOT NULL,
  `respuesta` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `respuesta`
--

INSERT INTO `respuesta` (`id_respuesta`, `respuesta`) VALUES
(1, 'Gracias por tu comentario'),
(2, 'No contamos con una respuesta al momento'),
(3, 'Estamos trabajando en ello');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `resid_respuesta` (`resid_respuesta`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `respuesta`
--
ALTER TABLE `respuesta`
  ADD PRIMARY KEY (`id_respuesta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `respuesta`
--
ALTER TABLE `respuesta`
  MODIFY `id_respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `resid_respuesta` FOREIGN KEY (`resid_respuesta`) REFERENCES `respuesta` (`id_respuesta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
