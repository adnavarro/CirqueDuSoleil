create type Persona as(
	nombre varchar(20),
	nombre2 varchar(20),
	apellido varchar(20),
	apellido2 varchar(20),
	genero varchar(1),
	fech_nac date
);

create table Hist_Precio(
	id numeric(2) not null,
	fech_in date not null,
	tipo varchar(12) not null,
	precio numeric not null,
	fech_fin date,
	constraint id_Hist_Precio primary key(id, fech_in)
);

create table Artist(
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

create table D_A(
	id_Disci numeric(2) not null references Disciplina(id),
	id_Artist numeric(2) not null references Artist(id),
	descrip varchar(300),
	constraint id_DA primary key(id_Disci, id_Artist)
);

create table LugarGeo(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo_geo varchar(1) check (tipo_geo='M' or tipo_geo='E' or tipo_geo='P' or tipo_geo='C'),
	idiomas varchar(20) array[3],
	moneda varchar(5),
	contine varchar(2) check (contine='AM' or contine='AS' or contine='EU' or 
							  contine='OC' or contine='AF'),
	id_Lugar numeric references LugarGeo(id)
);

create table LugarPresent(
	id numeric(2) not null primary key,
	tipo varchar(6) not null check(tipo='Arena' or tipo='Teatro' or tipo='Gym' 
								   or tipo='Hotel' or tipo='Otro'),
	nombre varchar(20) not null,
	capacidad numeric not null,
	dir varchar(300),
	id_LugarGeo numeric(2) not null references LugarGeo(id)
);

create table CirqueShow(
	id numeric(2) not null primary key,
	nombre varchar(20) not null,
	tipo varchar(5) check (tipo='Tour' or tipo='Local') not null,
	imagen bytea not null,
	descrip varchar(300)
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
	estatus varchar(12) check (estatus='Realizada' or estatus='No realizada'),
	id_Show numeric(2) references CirqueShow(id),
	id_SL numeric(2) references S_L(id)
);

create table Entrada(
	id numeric(2) not null primary key,
	precio numeric(3) not null,
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

create table Inscrip(
	id numeric(2) not null,
	resulta varchar(9) check (resulta='Aprobado' or resulta='Reprobado'),
	id_Aspirante numeric(2) not null references Aspirante(id),
	id_CalenAudicion numeric(2) not null references CalenAudicion(id),
	constraint id_Inscrip primary key(id, id_Aspirante, id_CalenAudicion)
);