-- CREACION DE LA BASE DE DATOS
CREATE DATABASE IF NOT EXISTS taller_db;

-- SE USA LA BASE DE DATOS 
USE taller_db;
-- DROP DATABASE taller_db;
-- SE REALIZAN LAS SENTENCIAS DML PARA LA CREACION DE LAS TABLAS

-- CREACION DE TABLA EDITORIALES
CREATE TABLE IF NOT EXISTS editoriales (
	id_editorial int auto_increment primary key,
	nombre varchar(40) not null,
	direccion varchar(100) not null,
	sitio_web varchar(150) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime null,
	fecha_eliminacion datetime null
);

-- CREACION DE TABLA MIEMBROS
CREATE TABLE IF NOT EXISTS miembros (
	id_miembro int auto_increment primary key,
    nombre varchar(40) not null,
    apellido varchar(40) not null,
    direccion varchar(30) not null,
    correo_electronico varchar(100) unique not null,
	celular bigint(10) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime null,
	fecha_eliminacion datetime null
);

-- CREACION DE TABLA LIBROS
CREATE TABLE IF NOT EXISTS libros (
	id_libro int auto_increment primary key,
    editorial_id int not null,
    isbn varchar(100) unique not null ,
    titulo varchar(40) not null,
    descripcion varchar(1000) not null,
    anio_publicacion int(4) not null,
    genero varchar(70) not null,
    idioma varchar(20) not null,
    cantidad_stock int(100) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime null,
	fecha_eliminacion datetime null,
    -- CREACION DE LAS RELACIONES ENTRE LLAVE FORANEA Y PRIMARIY
    CONSTRAINT fk_libros_editoriales foreign key (editorial_id) references editoriales(id_editorial)
);

-- CREACION DE TABLA AUTORES
CREATE TABLE IF NOT EXISTS autores (
	id_autor int auto_increment primary key,
    nombre varchar(40) not null,
    apellido varchar(40) not null,
    fecha_nacimiento date not null,
    pais_nacimiento varchar(20) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime null,
	fecha_eliminacion datetime null
);

CREATE TABLE libros_autores (
	id_libro_autor int primary key auto_increment,
	libro_id int not null,
    autor_id int not null,
	CONSTRAINT fk_libros_autores_libros foreign key (libro_id) references libros(id_libro),
	CONSTRAINT fk_libros_autores_autores foreign key (autor_id) references autores(id_autor)
);
-- CREACION DE TABLA PRESTAMOS
CREATE TABLE IF NOT EXISTS prestamos (
	id_prestamo int auto_increment primary key,
    miembro_id int not null,
	libro_id int not null,
    fecha_prestamo date not null,
    fecha_devolucion_prevista date not null,
	fecha_devolucion_real date not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime null,
	fecha_eliminacion datetime null,
    -- CREACION DE LAS RELACIONES ENTRE LLAVE FORANEA Y PRIMARIA
    CONSTRAINT fk_prestamos_libros foreign key (libro_id) references libros(id_libro),
    CONSTRAINT fk_prestamos_miembros foreign key (miembro_id) references miembros(id_miembro),
    -- LA FECHA DE DEVOLUCION PREVISTA DE UN PRESTAMO DEBE SER POSTERIOR A LA FECHA DE PRESTAMO
	CONSTRAINT chk_fechas CHECK (fecha_devolucion_prevista = (date_add(fecha_prestamo, interval 15 day))  )
);

-- INICIAMOS LOS REGISTROS POR CADA TABLA


-- CREAMOS LOS REGISTROS DE LA TABLA MIEMBROS
INSERT INTO miembros (nombre, apellido, direccion, correo_electronico, celular, fecha_creacion)
VALUES
	('Elena', 'Sánchez', 'Calle_123', 'e1l3n4a_s4nchez@gmail.com', '3133354606', NOW()),
	('Andrés', 'González', 'Carrera_456', 'a2ndres_456@hotmail.com', '3212456789', NOW()),
	('María', 'López', 'Avenida_789', 'ma3ria_lopez@gmail.com', '3129876543', NOW()),
	('Carlos', 'Martínez', 'Calle_234', 'c2arlos_m234@hotmail.com', '3187654321', NOW()),
	('Laura', 'Hernández', 'Carrera_567', 'lau3ra_h5er6nandez@gmail.com', '3151234567', NOW()),
	('José', 'Pérez', 'Avenida_890', 'j2os3e_perez@hotmail.com', '3142345678', NOW()),
	('Ana', 'Gómez', 'Calle_123', 'an3a_g4om5ez@gmail.com', '3203456789', NOW()),
	('Luis', 'Rodríguez', 'Carrera_456', 'luis_r5odr6iguez@hotmail.com', '3114567890', NOW()),
	('Camila', 'Ramírez', 'Avenida_789', 'ca3mila_r7am8irez@gmail.com', '3175678901', NOW()),
	('Andrea', 'García', 'Calle_234', 'an2drea_gar6cia@hotmail.com', '3146789012', NOW()),
	('Juan', 'Vargas', 'Carrera_567', 'ju2an_v5arg6as@gmail.com', '3107890123', NOW()),
	('Sofía', 'Fernández', 'Avenida_890', 'so2fia_fe5rn6andez@hotmail.com', '3128901234', NOW()),
	('Diego', 'López', 'Calle_123', 'di3ego_l4op5ez@gmail.com', '3139012345', NOW()),
	('Valentina', 'Martínez', 'Carrera_456', 'va3le4nt5ina_m6art7inez@hotmail.com', '3140123456', NOW()),
	('Andrés', 'Hernández', 'Avenida_789', 'an2dres_h5er6na7ndez@gmail.com', '3151234567', NOW()),
	('Isabella', 'Pérez', 'Calle_234', 'is2ab3ella_p5er6ez@hotmail.com', '3162345678', NOW()),
	('Carlos', 'González', 'Carrera_567', 'ca2r3los_g4on5za6lez@gmail.com', '3173456789', NOW()),
	('María', 'Ramírez', 'Avenida_890', 'ma2r3ia_r4am5ir6ez@hotmail.com', '3184567890', NOW()),
	('Javier', 'López', 'Calle_123', 'ja2vi3er_l4op5ez@gmail.com', '3195678901', NOW()),
	('Valeria', 'García', 'Carrera_456', 'va2le3ri4a_g5ar6ci7a@gmail.com', '3206789012', NOW()),
	('Miguel', 'Herrera', 'Avenida_789', 'mi2g3uel_h4er5re6ra@gmail.com', '3117890123', NOW()),
	('Ana', 'Soto', 'Calle_123', 'an2a_s3o4to@gmail.com', '3128901234', NOW()),
	('David', 'Guzmán', 'Carrera_456', 'da2vi3d_g4uz5man@gmail.com', '3139012345', NOW()),
	('Carolina', 'Ortega', 'Avenida_890', 'ca2ro3li4na_o5r6te7ga@gmail.com', '3140123456', NOW()),
	('José', 'López', 'Calle_234', 'jo2se3_lo4pe5z@gmail.com', '3151234567', NOW()),
	('Laura', 'Pérez', 'Carrera_567', 'la2ur3a_p4er5ez@gmail.com', '3162345678', NOW()),
	('Andrés', 'García', 'Avenida_890', 'an2dr3es_g4ar5ci6a@gmail.com', '3173456789', NOW()),
	('María', 'González', 'Calle_123', 'ma2r3ia_g4on5za6lez@gmail.com', '3184567890', NOW()),
	('Carlos', 'Ramírez', 'Carrera_456', 'ca2r3los_r4am5ir6ez@gmail.com', '3195678901', NOW()),
	('Valentina', 'Hernández', 'Avenida_789', 'va2le3nt4in5a_h5er6na7ndez@gmail.com', '3206789012', NOW());

-- CREACION DE LOS REGISTROS DE LA TABLA EDITORIALES
INSERT INTO editoriales (nombre, direccion, sitio_web, fecha_creacion) 
VALUES
	('Random House', 'Calle Travessera De Gracia núm. 47 49, (08021), Barcelona, Cataluña', 'https://www.penguinrandomhouse.com/', NOW()),
	('HarperCollins', 'Avenida de Burgos, 8B planta 18, - 28036 Madrid', 'https://www.harpercollins.com/', NOW()),
	('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', 'https://www.simonandschuster.com/', NOW()),
	('Macmillan', 'Insurgentes Sur 1457, Piso 25, Torre Manacar, Col. Insurgentes Mixcoac', 'https://us.macmillan.com/', NOW()),
	('Hachette Book Group', '290 Avenue of the Americas, Midtown Manhattan, New York City', 'https://www.hachettebookgroup.com/', NOW()),
	('Scholastic Corporation', '557 Broadway, New York City, New York 1001', 'https://www.scholastic.com/', NOW()),
	('Bloomsbury Publishing', '50 Bedford Square, London WC1B', 'https://www.bloomsbury.com/', NOW()),
	('Wiley', 'Corporate Headquarters Suite 300 111 River Street', 'https://www.wiley.com/', NOW()),
	('Elsevier', 'Radarweg 29, 1043 NX Amsterdam, The Netherlands', 'https://www.elsevier.com/', NOW()),
	('Springer', 'One New York Plaza, Suite 4600', 'https://www.springer.com/', NOW()),
	('Beacon Press', '24 Farnsworth Street Boston, MA 02210', 'https://www.beacon.org/', NOW()),
	('MIT Press', '120 Broadway, New York, NY 10271', 'https://mitpress.mit.edu/', NOW()),
	('Editorial Norma', 'Cl. 95 #33-44, Bogotá', 'https://www.librerianorma.com/', NOW()),
	('Grupo Editorial Planeta', 'Cl. 73 #7-60, Bogotá', 'https://www.planetadelibros.com/', NOW()),
	('Siruela', 'Calle Almagro, 25, Pral Dcha. 28010, Madrid', 'http://www.siruela.com/', NOW()),
	('Anagrama', 'Calle Pau Claris 172 P. PRINCIPAL 2. 08037, Barcelona', 'https://www.anagrama-ed.es/', NOW());


-- CREACION DE LOS REGISTROS DE LOS LIBROS
INSERT INTO libros ( editorial_id, isbn, titulo, descripcion, anio_publicacion, genero, idioma,  cantidad_stock, fecha_creacion)
VALUES 
	(1, '978-0307474728', 'Cien años de soledad', '"Cien años de soledad" es una novela escrita por Gabriel García Márquez que narra la historia de la familia Buendía a lo largo de varias generaciones en el ficticio pueblo de Macondo. La novela combina elementos de realismo mágico con una rica narrativa que explora temas como el amor, la soledad, la violencia y la búsqueda de significado en un mundo cambiante.', 1967, 'Realismo mágico, novela', 'Español', 5, NOW()),
	( 16, '978-0061120084', 'Matar un ruiseñor', '"Matar un ruiseñor" es una novela escrita por Harper Lee que aborda temas de racismo, injusticia y moralidad en una pequeña ciudad del sur de Estados Unidos durante la década de 1930. A través de los ojos de la joven Scout Finch, la novela explora la lucha por la justicia y la comprensión en un contexto de prejuicios y desigualdad.', 1960, 'Novela literaria, ficción histórica', 'Inglés', 20, NOW()),
	(5, '978-9500732627', 'El túnel', '"El túnel" es una novela escrita por Ernesto Sabato que explora la mente y los conflictos internos de un pintor obsesionado con una mujer llamada María. La novela es un estudio psicológico profundo y oscuro que aborda temas como la soledad, la alienación y la búsqueda de sentido en la existencia.', 1948, 'Novela psicológica, ficción', 'Español', 15, NOW()),
	( 7, '978-8418218644', 'La metamorfosis', '"La metamorfosis" es una novela corta escrita por Franz Kafka en la que el protagonista, Gregor Samsa, se despierta un día convertido en un insecto gigante. La obra explora temas de alienación, aislamiento y la relación entre el individuo y la sociedad.', 1915, 'Novela corta, ficción absurda', 'Alemán', 35, NOW()),
	( 1,'978-0007203543', 'La comunidad del anillo', 'El primer libro de la trilogía "El Señor de los Anillos" de J.R.R. Tolkien sigue las aventuras de Frodo Bolsón y un grupo de compañeros mientras intentan destruir el Anillo Único para evitar que el malvado Sauron recupere su poder. La historia se desarrolla en un mundo de fantasía lleno de personajes memorables y épicas batallas.', 1954, 'Fantasía épica', 'Inglés', 21, NOW()),
	(6, '978-8845270758', 'Las dos torres', 'El segundo libro de la trilogía continúa la historia de "La comunidad del anillo", siguiendo a los personajes en diferentes lugares y situaciones mientras enfrentan desafíos y peligros en su búsqueda por destruir el Anillo Único y detener a Sauron.', 1954, 'Fantasía épica', 'Inglés', 8, NOW()),
	( 3, '978-0007123803', 'El retorno del rey', 'El tercer y último libro de la trilogía concluye la épica historia de "El Señor de los Anillos", llevando a los personajes a una batalla final contra las fuerzas de Sauron. La trilogía culmina en un emocionante desenlace que resuelve los destinos de los personajes y el destino del Anillo Único.', 1955, 'Fantasía épica', 'Inglés', 60, NOW()),
	(2, '978-0545069670', 'Harry Potter y la piedra filosofal', 'El joven huérfano Harry Potter descubre que es un mago y es invitado a asistir a la Escuela de Magia y Hechicería de Hogwarts. Allí, junto a sus amigos Ron y Hermione, se embarcará en aventuras mágicas mientras descubre la verdad sobre su pasado y enfrenta al maligno Lord Voldemort.', 1997, 'Fantasía', 'Inglés', 45, NOW()),
	(13, '978-8831000154', 'Harry Potter y la cámara secreta', 'En su segundo año en Hogwarts, Harry descubre que los estudiantes están siendo petrificados misteriosamente. Junto a Ron y Hermione, investiga la Cámara de los Secretos y enfrenta peligros ancestrales.', 1998, 'Fantasía', 'Inglés', 37, NOW()),
	(4, '978-0439554923', 'Harry Potter y el prisionero de Azkaban', 'En su tercer año en Hogwarts, Harry se entera de la existencia de Sirius Black, un peligroso prófugo de Azkaban. A medida que descubre la verdad, también conoce secretos sobre su pasado.', 1999, 'Fantasía', 'Inglés', 25, NOW()),
	(12, '978-8893819930', 'Harry Potter y el cáliz de fuego', 'En su cuarto año en Hogwarts, Harry es elegido para participar en el Torneo de los Tres Magos, un peligroso concurso entre escuelas de magia. Sin embargo, las pruebas se vuelven mortales y Harry descubre oscuros secretos.', 2000, 'Fantasía', 'Inglés', 3, NOW()),
	(3, '978-0439567619', 'Harry Potter y la Orden del Fénix', 'En su quinto año en Hogwarts, Harry se une a la Orden del Fénix, un grupo que lucha contra el regreso de Lord Voldemort. Mientras tanto, enfrenta desafíos en la escuela y descubre más sobre su conexión con el oscuro mago.', 2003, 'Fantasía', 'Inglés', 75, NOW()),
	(13, '978-8831003438', 'Harry Potter y el misterio del príncipe', 'En su sexto año en Hogwarts, Harry investiga un misterioso libro de hechizos que perteneció al "Príncipe Mestizo". A medida que la oscuridad se cierne sobre el mundo mágico, Harry se prepara para enfrentar su destino.', 2005, 'Fantasía', 'Inglés', 45, NOW()),
	(1, '978-3757807870', 'Orgullo y Prejuicio', 'Esta novela clásica de Jane Austen narra la historia de Elizabeth Bennet y su relación con el orgulloso y enigmático Sr. Darcy. A través de un retrato irónico de la sociedad y las convenciones de la época, Austen explora temas de amor, prejuicio, clases sociales y matrimonio.', 1813, 'Novela romántica, Clásico', 'Inglés', 63, NOW()),
	(7, '978-8497403573', 'Don Quijote de la Mancha', 'Escrita por Miguel de Cervantes, esta novela es una de las obras más destacadas de la literatura española y mundial. Cuenta la historia de un caballero llamado Don Quijote que se embarca en aventuras inspiradas por sus lecturas de libros de caballerías.', 'Primera parte en 1605, segunda parte en 1615', 'Novela de caballerías, Parodia, Satírica', 'Español', 34, NOW()),
	(10, '978-0140431872', 'El retrato de Dorian Gray', 'Escrita por Oscar Wilde, esta novela explora temas de belleza, decadencia y moralidad. Cuenta la historia de Dorian Gray, un joven cuyo retrato envejece mientras él mantiene su apariencia juvenil.', 1890, 'Novela gótica, Filosófica', 'Inglés', 29, NOW()),
	(9, '978-3458200178', 'El Principito', 'Escrito por Antoine de Saint-Exupéry, es un cuento poético y filosófico que narra el viaje de un niño extraterrestre a través de diversos planetas, donde aprende sobre la vida, el amor y la amistad.', 1943, 'Literatura infantil, Filosofía', 'Francés', 80, NOW()),
	(6, '978-0451511478', 'Hamlet', 'Tragedia escrita por William Shakespeare, sigue la historia del príncipe Hamlet de Dinamarca mientras busca vengar la muerte de su padre. Explora temas de venganza, traición y locura.', 'Entre 1600 y 1602', 'Tragedia', 'Inglés', 57, NOW()),
	(16, '978-8807901461', 'Guerra y Paz', 'Novela épica escrita por León Tolstói que abarca la vida de varios personajes durante las guerras napoleónicas y la sociedad rusa del siglo XIX. Explora temas de historia, política y existencialismo.', 1869, 'Novela histórica', 'Ruso', 11, NOW()),
	(14, '978-0142437247', 'Moby Dick', 'Escrita por Herman Melville, es una novela que sigue la obsesiva búsqueda del capitán Ahab para cazar al gran cachalote blanco llamado Moby Dick. La novela aborda temas de venganza, naturaleza humana y la relación del hombre con la naturaleza.', 1851, 'Novela de aventuras, Alegoría', 'Inglés', 38, NOW()),
	(8, '978-3988288820', 'La Divina Comedia', 'Escrito por Dante Alighieri, "La Divina Comedia" es un poema épico que consta de tres partes: "Infierno", "Purgatorio" y "Paraíso". Narra el viaje del protagonista, Dante, a través del Infierno, el Purgatorio y el Paraíso, guiado por el poeta romano Virgilio y posteriormente por su amada Beatriz. La obra es una alegoría que aborda temas religiosos, morales y filosóficos.', 1308, 'Poesía épica, Alegoría', 'Italiano', 1, NOW());

-- CREACION DE LOS REGISTROS DE AUTORES
INSERT INTO autores (nombre, apellido, fecha_nacimiento, pais_nacimiento, fecha_creacion)
VALUES
    ('Gabriel', 'García Márquez', '1927-03-06', 'Aracataca, Colombia', NOW()),
    ('Harper', 'Lee', '1926-04-28', 'Monroeville, Alabama, Estados Unidos', NOW()),
    ('Ernesto', 'Sabato', '1911-06-24', 'Rojas, Argentina', NOW()),
    ('Franz', 'Kafka', '1883-07-03', 'Praga, Imperio Austrohúngaro', NOW()),
    ('J.R.R.', 'Tolkien', '1892-01-03', 'Bloemfontein, Estado Libre de Orange', NOW()),
    ('J.K.', 'Rowling', '1965-07-31', 'Yate, Gloucestershire, Inglaterra', NOW()),
    ('Jane', 'Austen', '1775-12-16', 'Steventon, Hampshire, Inglaterra', NOW()),
    ('Miguel', 'de Cervantes', '1547-09-29', 'Alcalá de Henares, España', NOW()),
    ('Oscar', 'Wilde', '1854-10-16', 'Dublín, Irlanda', NOW()),
    ('Antoine', 'de Saint-Exupéry', '1900-06-29', 'Lyon, Francia', NOW()),
    ('William', 'Shakespeare', '1564-04-23', 'Stratford-upon-Avon, Inglaterra', NOW()),
    ('León', 'Tolstói', '1828-09-09', 'Yásnaya Poliana, Imperio Ruso', NOW()),
    ('Herman', 'Melville', '1819-08-01', 'Nueva York, Estados Unidos', NOW()),
    ('Dante', 'Alighieri', '1265-06-01', 'Florencia, República de Florencia', NOW());
-- SE INSERTAN LOS REGISTROS DE CADA LIBRO Y SU AUTOR
INSERT INTO libros_autores (libro_id, autor_id ) 
VALUES 
	(1,1),
    (1, 2),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 5),
	(7, 5),
	(8, 6),
	(9, 6),
	(10, 6),
	(11, 6),
	(12, 6),
	(13, 6),
	(14, 7),
    (15, 8),
    (16, 9),
    (17, 10),
    (18, 11),
    (19, 12),
    (20, 13),
    (21, 14);
    
-- CREAMOS LOS REGISTROS DE PRESTAMOS
INSERT INTO prestamos (miembro_id, libro_id, fecha_prestamo, fecha_devolucion_prevista, fecha_devolucion_real, fecha_creacion)
VALUES
	(1,1,'2023-08-01', DATE_ADD('2023-08-01', INTERVAL 15 DAY), '2023-08-7', NOW()),
	(2,2,'2023-08-02', DATE_ADD('2023-08-02', INTERVAL 15 DAY),  '2023-08-9', NOW()),
    (3,3,'2023-08-03', DATE_ADD('2023-08-03', INTERVAL 15 DAY), '2023-08-7', NOW()),
    (4,4,'2023-08-04', DATE_ADD('2023-08-04', INTERVAL 15 DAY), '2023-08-12', NOW()),
    (5,5,'2023-08-05', DATE_ADD('2023-08-05', INTERVAL 15 DAY), '2023-08-19', NOW()),
    (6,6,'2023-08-06', DATE_ADD('2023-08-06', INTERVAL 15 DAY), '2023-08-20', NOW()),
    (7,7,'2023-08-07', DATE_ADD('2023-08-07', INTERVAL 15 DAY), '2023-08-14', NOW()),
    (10,8,'2023-08-08', DATE_ADD('2023-08-08', INTERVAL 15 DAY), '2023-08-16', NOW()),
    (12,9,'2023-08-09', DATE_ADD('2023-08-09', INTERVAL 15 DAY), '2023-08-23', NOW()),
    (13, 10,'2023-08-10', DATE_ADD('2023-08-10', INTERVAL 15 DAY), '2023-08-24', NOW()),
    (5,16,'2023-08-11', DATE_ADD('2023-08-11', INTERVAL 15 DAY), '2023-08-21', NOW()),
    (8, 21,'2023-08-12', DATE_ADD('2023-08-12', INTERVAL 15 DAY), '2023-08-13', NOW()),
    (19, 19,'2023-08-13', DATE_ADD('2023-08-13', INTERVAL 15 DAY), '2023-08-30', NOW()),
    (17,13,'2023-08-14', DATE_ADD('2023-08-14', INTERVAL 15 DAY), '2023-08-17', NOW()),
    (15,14,'2023-08-15', DATE_ADD('2023-08-15', INTERVAL 15 DAY), '2023-08-26', NOW()),
	(5, 21,'2023-08-12', DATE_ADD('2023-08-12', INTERVAL 15 DAY), '2023-08-13', NOW()),
    (12, 21,'2023-08-13', DATE_ADD('2023-08-13', INTERVAL 15 DAY), '2023-08-30', NOW()),
    (13,21,'2023-08-14', DATE_ADD('2023-08-14', INTERVAL 15 DAY), '2023-08-17', NOW()),
	(15, 1,'2023-08-12', DATE_ADD('2023-08-12', INTERVAL 15 DAY), '2023-08-13', NOW()),
    (9, 1,'2023-08-13', DATE_ADD('2023-08-13', INTERVAL 15 DAY), '2023-08-30', NOW()),
    (2,19,'2023-09-14', DATE_ADD('2023-09-14', INTERVAL 15 DAY), '2023-09-20', NOW()),
    (2,19,'2023-09-15', DATE_ADD('2023-09-15', INTERVAL 15 DAY), '0000-00-00', NOW());
    
    