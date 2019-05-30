create type Persona as(
	nombre varchar(20), /* Obligatorio */
	nombre2 varchar(20),
	apellido varchar(20), /* Obligatorio */
	apellido2 varchar(20),
	genero varchar(1), /* Obligatorio, solo M,F,O */
	fech_nac date /* Obligatorio */
);

create type DatosDirector as(
	nombre varchar(20), /* Obligatorio */
	apellido varchar(20), /* Obligatorio */
	cargo varchar(20) /* Obligatorio */
);

create type Acto as(
	nombre varchar(20), /* Obligatorio */
	descrip varchar(20) /* Obligatorio */
);

create type dir as(
	calle varchar(20),
	codPostal numeric,
	detalle varchar(100)
);

create table Hist_Precio(
	id numeric(2) not null,
	fech_in date not null,
	tipo varchar(12) not null, /* Cada tipo no puede tener mas de un periodo activo */
	precio numeric not null, /* Precio en dolares */
	fech_fin date,
	constraint id_Hist_Precio primary key(id, fech_in)
);

create table Artist(
	id numeric(2) not null primary key,
	idiomas varchar(20) array[3] not null,
	passport numeric(3) array[3] not null,
	apodo varchar(20),
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

create table D_A(
	id_Disci numeric(2) not null references Disciplina(id),
	id_Artist numeric(2) not null references Artist(id),
	descrip varchar(300),
	constraint id_DA primary key(id_Disci, id_Artist)
);

create table LugarGeo(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo_geo varchar(1) check (tipo_geo='M' or tipo_geo='E' or tipo_geo='P'),
	idiomas varchar(20) array[3], /* Obligatorio para pais */
	moneda varchar(5), /* Obligatorio para pais */
	contine varchar(2) check (contine='AM' or contine='AS' or contine='EU' or 
							  contine='OC' or contine='AF'), /* Obligatorio para pais */
	id_Lugar numeric references LugarGeo(id)
);

create table LugarPresent(
	id numeric(2) not null primary key,
	tipo varchar(6) not null check(tipo='Arena' or tipo='Teatro' or tipo='Gym' 
								   or tipo='Hotel' or tipo='Otro'),
	nombre varchar(20) not null,
	capacidad numeric not null,
	direccion dir,
	id_LugarGeo numeric(2) not null references LugarGeo(id)
);

create table CirqueShow(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo varchar(10) check (tipo='Itinerante' or tipo='Residente') not null,
	imagen bytea not null,
	show_acto Acto array[3] not null,
	datos_extra DatosDirector array[3] not null,
	musica varchar(20) array[7] not null,
	descrip varchar(300),
	id_LugarPresent numeric(2) references LugarPresent(id) /* Obligatorio para residente */
);

create table Personaje(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	descrip varchar(300) not null,
	id_Show numeric(2) unique not null references CirqueShow(id)
);

create table Hist_Show_Per_Art(
	fech_in date not null,
	fech_fin date,
	id_Artist numeric(2) not null references Artist(id),
	id_Personaje numeric(2) not null references Personaje(id),
	constraint id_Hist_Show_Per_Art primary key (fech_in, id_Artist, id_Personaje)
);

create table A_H(
	id_Show numeric(2) not null references CirqueShow(id),
	id_Disci numeric(2) not null references Disciplina(id),
	constraint id_AH primary key(id_Show, id_Disci)
);

create table S_L (
	id numeric(2) not null primary key,
	id_Show numeric(2) not null references CirqueShow(id),
	id_LugarGeo numeric (2) not null references LugarGeo(id),
	constraint Unico_SL unique(id_Show, id_LugarGeo)
);

create table Presenta(
	id numeric(2) not null primary key,
	fecha date not null,
	hora timestamp not null,
	estatus bool not null, /* 0:No realizado, 1:Realizado */
	id_Show numeric(2) references CirqueShow(id), /* Obligatorio para residente */
	id_SL numeric(2) references S_L(id), /* Obligatorio para itinerante */
	id_LugarPresent numeric(2) references LugarPresent(id) /* Obligatorio para itinerante no carpa */
);

create table Entrada(
	id numeric(2) not null primary key,
	precio numeric(3) not null, /* Moneda del pais */
	tipo varchar(3) check (tipo='A' or tipo='B' or tipo='C' or tipo='VIP'),
	tipoPerson varchar(12) check (tipoPerson='Menor' or tipoPerson='Tercera edad' or 
								   tipoPerson='Adulto') not null,
	fecha_Emision date not null,
	hora_emision timestamp not null,
	id_Presenta numeric(2) not null references Presenta(id),
	id_Entrada numeric(2) references Entrada(id)
);

create table CalenAudicion(
	id numeric(2) not null primary key,
	fecha date not null,
	hora_in timestamp not null,
	hora_fin timestamp not null,
	max_partici numeric(3) not null,
	cupos_disp numeric(3) not null,
	id_LugarPreset numeric(2) not null references LugarPresent(id),
	id_Disci numeric(2) not null references Disciplina(id)
);

create table A_A(
	id_Inscrip numeric(2) not null unique,
	resulta bool not null, /* 0:No aprobado, 1:Aprobado */
	id_Aspirante numeric(2) not null references Aspirante(id),
	id_CalenAudicion numeric(2) not null references CalenAudicion(id),
	constraint id_Inscrip primary key(id_Aspirante, id_CalenAudicion)
);