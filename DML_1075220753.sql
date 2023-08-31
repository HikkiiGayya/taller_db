
-- USAMOS LA BASE DE DATOS
USE taller_db;

-- VAMOS A REALIZAR LAS CONSULTAS DDL

-- a. Realizar una consulta de libros por género, ejemplo “Ciencia Ficción”
SELECT * FROM libros WHERE genero = "Fantasia";

-- b. Realizar una consulta de los libros disponibles, tener en cuenta el campo cantidad en stock
SELECT 
	titulo AS Libro,
    cantidad_stock 
FROM libros 
ORDER BY cantidad_stock ;

-- c. Realizar la búsqueda de libros por un determinado autor
SELECT 
	lib.titulo AS Libro,
    aut.nombre AS Nombre_autor,
    aut.apellido AS Apellido_autor
FROM libros_autores AS lib_a 
INNER JOIN libros AS lib ON lib_a.libro_id = lib.id_libro
INNER JOIN autores AS aut ON lib_a.autor_id = aut.id_autor
WHERE aut.nombre LIKE "%j.k%";

-- d. Realizar la búsqueda de préstamos pendientes, es decir los libros que aun no han sido devueltos
SELECT
	mi.nombre AS Miembro,
    lib.titulo AS Libro,
    fecha_devolucion_prevista AS Fecha_devolucion_prevista,
	fecha_devolucion_real 
FROM prestamos AS pres
INNER JOIN libros AS lib ON pres.libro_id = lib.id_libro
INNER JOIN miembros AS mi ON mi.id_miembro = pres.miembro_id
WHERE fecha_devolucion_real = "0000-00-00"
ORDER BY mi.nombre;


-- e. Realizar búsqueda de miembros por correo electrónico
SELECT
	mi.nombre AS Nombre,
    mi.correo_electronico 
FROM miembros AS mi
WHERE correo_electronico = "lau3ra_h5er6nandez@gmail.com";


-- f. Realizar búsqueda del historial de préstamos de un libro, en dicha consulta debe
-- retornar únicamente los siguientes campos
-- i. ISBN
-- ii. Titulo
-- iii. Género
-- iv. Nombres y apellidos del miembro que prestó el libro

SELECT
	lib.isbn AS ISBN,
    lib.titulo AS Titulo,
    lib.genero AS Género,
	CONCAT(mi.nombre, ' ', mi.apellido) AS Nombre_miembro
FROM prestamos AS pres 
INNER JOIN libros AS lib ON lib.id_libro = pres.libro_id
INNER JOIN miembros AS mi ON pres.miembro_id = mi.id_miembro
WHERE lib.isbn = "978-0061120084";

-- g. Realizar consulta de préstamos vencidos, tener en cuenta el campo fecha devolución prevista

SELECT 
	lib.titulo AS Libro,
    pres.fecha_prestamo,
    pres.fecha_devolucion_prevista,
    pres.fecha_devolucion_real
FROM prestamos AS pres 
INNER JOIN libros AS lib ON lib.id_libro = pres.libro_id
WHERE fecha_devolucion_prevista < fecha_devolucion_real;

-- h. Realizar consulta para encontrar la editorial que ha publicado la mayor cantidad de libros. 
SELECT 
	edi.nombre AS Editorial, 
	COUNT(lib.id_libro) AS Cantidad_libros
FROM editoriales AS edi
INNER JOIN libros AS lib ON lib.editorial_id = edi.id_editorial
GROUP BY edi.id_editorial 
ORDER BY Cantidad_libros DESC
LIMIT 1;

-- i. Realizar consulta para encontrar los libros más populares según la cantidad de préstamos
SELECT  
	lib.isbn AS ISBN,
    lib.titulo AS Libro,
    COUNT(pres.libro_id) AS Cantidad_prestamo 
FROM libros AS lib 
INNER JOIN prestamos as pres ON pres.libro_id = lib.id_libro
GROUP BY lib.id_libro HAVING Cantidad_prestamo >=1 
ORDER BY Cantidad_prestamo DESC;

-- j. Encuentra el número de libros escritos por cada autor
SELECT 
	lib.isbn AS ISBN,
    lib.titulo AS Libro,
    COUNT(aut.id_autor) AS Cantidad_autores
FROM libros_autores AS lib_a
INNER JOIN libros AS lib ON lib_a.libro_id = lib.id_libro
INNER JOIN autores AS aut ON lib_a.autor_id = aut.id_autor
GROUP BY lib.id_libro 
ORDER BY Cantidad_autores DESC;

-- k. Consultar los libros donde el año de publicación esté entre 1996 y 2006
SELECT 
	lib.titulo AS Libro,
	 lib.anio_publicacion AS Año_Publicacion 
FROM libros AS lib WHERE lib.anio_publicacion
BETWEEN 1996 AND 2006;

-- l. Consultar el número total de libros disponibles en el inventario
SELECT SUM(cantidad_stock) AS Cantidad_disponible
FROM libros ;


-- m. Calcular el número de préstamos realizados en cada mes
SELECT
    MONTH(fecha_prestamo) AS Mes,
    COUNT(fecha_prestamo) AS Numero_préstamos
FROM prestamos
GROUP BY mes ORDER BY mes;

-- n. Calcular cuantos libros existen por cada género
SELECT 
	genero AS Genero,
    COUNT(genero) AS Cantidad
FROM libros
GROUP BY genero;


-- o. Calcular el promedio de préstamos realizados por cada miembro
SELECT 
	mi.id_miembro,
    mi.nombre, 
    COUNT(pres.miembro_id) AS Total_prestamos, 
    COUNT(pres.miembro_id) / COUNT(DISTINCT mi.id_miembro) AS Promedio_prestamos
FROM miembros AS mi
LEFT JOIN prestamos AS pres ON mi.id_miembro = pres.miembro_id
GROUP BY mi.id_miembro, mi.nombre
ORDER BY Promedio_prestamos DESC;

