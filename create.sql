create type Persona as(
	nombre varchar(20),
	nombre2 varchar(20),
	apellido varchar(20),
	apellido2 varchar(20),
	genero varchar(1),
	fech_nac date
);

create table Artista(
	id numeric(2) not null primary key,
	idiomas varchar(20) array[3] not null,
	passport numeric(3) array[3] not null,
	datos_per persona not null
);

create table Aspirante(
	id numeric(2) not null primary key,
	idiomas varchar(20) array[3] not null,
	passport numeric(3) array[3] not null,
	telefonos numeric array[3] not null,
	datos_per persona not null
);

create table Disciplina(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo varchar(20) not null,
	descrip varchar(300)
);

create table Lugar_Geo(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo_geo varchar(1) check (tipo_geo='M' or tipo_geo='E' or tipo_geo='P' or tipo_geo='C'),
	idiomas varchar(20) array[3],
	moneda varchar(5),
	contine varchar(2) check (contine='AM' or contine='AS' or contine='EU' or 
							  contine='OC' or contine='AF'),
	fk_Lugar numeric references Lugar_Geo (id)
);

create table CirqueShow(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo varchar(5) check (tipo='Tour' or tipo='Local') not null,
	imagen bytea not null,
	descrip varchar(300)
);