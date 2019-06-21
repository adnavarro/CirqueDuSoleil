
create type DatosExtra as(
	nombre varchar(128), /* Obligatorio */
	apellido varchar(128), /* Obligatorio */
	cargo varchar(128) /* Obligatorio */
);

create type Acto as(
	nombre varchar(256), /* Obligatorio */
	descrip text /* Obligatorio */
);

create type dir as(
	calle varchar(32),
	codPostal numeric,
	detalle varchar(256)
);

create table Hist_Precio(
	id numeric(4) not null,
	fech_in date not null,
	tipo varchar(12) not null, /* Cada tipo no puede tener mas de un periodo activo */
	precio numeric not null, /* Precio en dolares */
	fech_fin date,
	constraint id_Hist_Precio primary key(id, fech_in)
);

create table Artist(
	id numeric(4) not null primary key,
	nombre varchar(32) not null, 
	nombre2 varchar(32),
	apellido varchar(32) not null,
	apellido2 varchar(32),
	genero varchar(1) not null check (genero='M' or genero='F' or genero='O'),
	fech_nac date not null,
	idiomas varchar(32) array[3] not null,
	passport numeric(10) array[3] not null,
	apodo varchar(32)
);

create table Aspirante(
	id numeric(4) not null primary key,
	nombre varchar(32) not null, 
	nombre2 varchar(32),
	apellido varchar(32) not null,
	apellido2 varchar(32),
	genero varchar(1) not null check (genero='M' or genero='F' or genero='O'),
	fech_nac date not null,
	idiomas varchar(32) array[3] not null,
	passport numeric(10) array[3] not null,
	telefonos varchar(25) array[3] not null
);

create table Disciplina(
	id numeric(4) not null primary key,
	nombre varchar(128) not null,
	tipo varchar(128) not null,
	descrip text
);

create table D_A(
	id_Artist numeric(4) not null references Artist(id),
	id_Disci numeric(4) not null references Disciplina(id),
	constraint id_DA primary key(id_Disci, id_Artist)
);

create table LugarGeo(
	id numeric(4) not null primary key,
	nombre varchar(128) not null,
	tipo_geo varchar(1) not null check (tipo_geo='C' or tipo_geo='P'),
	idiomas varchar(32) array[3], /* Obligatorio para pais */
	moneda varchar(20), /* Obligatorio para pais */
	contine varchar(2) check (contine='AM' or contine='AS' or contine='EU' 
							  or contine='OC' or contine='AF'), /* Obligatorio para pais */
	id_Lugar numeric references LugarGeo(id) /* Obligatorio para ciudad */
);

create table LugarPresent(
	id numeric(4) not null primary key,
	tipo varchar(6) not null check(tipo='Arena' or tipo='Teatro' or tipo='Gym' or tipo='Hotel' or tipo='Otro'),
	nombre varchar(128) not null,
	capacidad numeric not null,
	direccion dir,
	id_LugarGeo numeric(4) not null references LugarGeo(id)
);

create table CirqueShow(
	id numeric(4) not null primary key,
	nombre varchar(256) not null,
	tipo varchar(10) check (tipo='Itinerante' or tipo='Residente') not null,
	imagen varchar(256) not null,
	show_acto Acto array[3] not null,
	datos_extra DatosExtra array[3] not null,
	musica varchar(256) array[7] not null,
	descrip text,
	estatus boolean,
	fech_in date,
	id_LugarPresent numeric(4) references LugarPresent(id) /* Obligatorio para residente */
);

create table Personaje(
	id numeric(4) not null primary key,
	nombre varchar(256) not null,
	descrip text not null,
	id_Show numeric(4) not null references CirqueShow(id)
);

create table Hist_Show_Per_Art(
	fech_in date not null,
	fech_fin date,
	id_Artist numeric(4) not null references Artist(id),
	id_Personaje numeric(4) not null references Personaje(id),
	constraint id_Hist_Show_Per_Art primary key (fech_in, id_Artist, id_Personaje)
);

create table A_H(
	id_Show numeric(4) not null references CirqueShow(id),
	id_Disci numeric(4) not null references Disciplina(id),
	constraint id_AH primary key(id_Show, id_Disci)
);

create table S_L (
	id numeric(4) not null primary key,
	id_Show numeric(4) not null references CirqueShow(id),
	id_LugarGeo numeric (2) not null references LugarGeo(id),
	constraint Unico_SL unique(id_Show, id_LugarGeo)
);

create table Presenta(
	id numeric(4) not null primary key,
	fecha timestamp not null,
	estatus bool not null, /* 0:No realizado, 1:Realizado */
	id_Show numeric(4) references CirqueShow(id), /* Obligatorio para residente */
	id_SL numeric(4) references S_L(id), /* Obligatorio para itinerante */
	id_LugarPresent numeric(4) references LugarPresent(id) /* Obligatorio para itinerante no carpa */
);

create table Entrada(
	id numeric(10) not null primary key,
	precio numeric(3) not null, /* Moneda del pais */
	tipo varchar(3) check (tipo='A' or tipo='B' or tipo='C' or tipo='VIP'),
	tipoPerson varchar(12) check (tipoPerson='Menor' or tipoPerson='Tercera edad' or tipoPerson='Adulto') not null,
	fecha_emision timestamp not null,
	id_Presenta numeric(4) not null references Presenta(id),
	id_Entrada numeric(10) references Entrada(id) /* Obligatorio para menores */
);

create table CalenAudicion(
	id numeric(4) not null primary key,
	fecha date not null,
	hora_in timestamp not null,
	hora_fin timestamp not null,
	max_partici numeric(3) not null,
	cupos_disp numeric(3) not null,
	id_LugarPreset numeric(4) not null references LugarPresent(id),
	id_Disci numeric(4) not null references Disciplina(id)
);

create table A_A(
	id_Inscrip numeric(4) not null unique,
	resulta bool not null, /* 0:No aprobado, 1:Aprobado */
	id_Aspirante numeric(4) not null references Aspirante(id),
	id_CalenAudicion numeric(4) not null references CalenAudicion(id),
	constraint id_Inscrip primary key(id_Aspirante, id_CalenAudicion)
);

