--TRIGGER PARA VALIDAR QUE LA MONEDA, EL CONTINENTE Y EL IDIOMA DE UN PAÍS NO SEA NULO
create function val_LugarGeo_monCon() returns trigger as $tr_LugarGeoMonCon$
begin
	--Chequea que el idioma no sea nulo
	if new.idiomas is null then
		raise exception 'Al menos debe haber un idioma';
	end if;
	--Chequea que este la moneda
	if new.moneda is null then
		raise exception 'La moneda no puede ser nula para un país';
	end if;
	--Chequea que este el continente
	if new.contine is null then
		raise exception 'El continente no puede ser nulo para un país';
	end if;
	return new;
end;
$tr_LugarGeoMonCon$ language plpgsql;

create trigger tr_LugarGeoMonCon before insert on LugarGeo
for each row when (new.tipo_geo='P') execute procedure val_LugarGeo_monCon();

--TRIGGER PARA VALIDAR QUE CADA CIUDAD TENGA UN PAÍS ASOCIADO
create function val_LugarGeo_CiuPai() returns trigger as $tr_LugarGeoCiuPai$
begin
	--Chequea que este el país asociado
	if new.id_Lugar is null then
		raise exception 'La ciudad debe tener un país asociado';
	end if;
	return new;
end;
$tr_LugarGeoCiuPai$ language plpgsql;

create trigger tr_LugarGeoCiuPai before insert on LugarGeo
for each row when (new.tipo_geo='C') execute procedure val_LugarGeo_CiuPai();

--TRIGGER PARA VALIDAR QUE LA ENTRADA DE UN MENOR ESTE ASOCIADA CON UN MAYOR
create function val_Entrada_MenMay() returns trigger as $tr_EntradaMenMay$
declare tip varchar(12);
begin
	--Chequea si no tiene una entrada asociada
	if new.id_Entrada is null then
		raise exception 'El niño debe estar asociado con un adulto';
	--Chequea si la entrada asociada no es de otro niño
	else
		select tipoPerson into tip
		from Entrada
		where id=new.id_Entrada;
		
		if tip='Menor' then
			raise exception 'El niño no puede estar asociado a otro menor';
		end if;
	end if;
	return new;
end;
$tr_EntradaMenMay$ language plpgsql;

create trigger tr_EntradaMenMay before insert on Entrada
for each row when (new.tipoPerson='Menor') execute procedure val_Entrada_MenMay();

--TRIGGER PARA VALIDAR QUE SHOWS RESIDENTES TENGAN LUGAR DE PRESENTACIÓN
create function val_Show() returns trigger as $tr_show$
begin
	--Chequea que el lugar de presentación no sea nulo
	if new.id_LugarPresent is null then
		raise exception 'Un show residente debe tener un lugar de presentacion';
	end if;
	return new;
end;
$tr_show$ language plpgsql;

create trigger tr_show before insert on CirqueShow
for each row when (new.tipo='Residente') execute procedure val_Show();

--TRIGGER PARA CERRAR EL ÚLTIMO HISTORICO DE PRECIOS ANTES DE CREAR OTRO
create function cierra_Precio() returns trigger as $tr_HistPrecio$
begin
	if new.id>1 then
		Update Hist_Precio
		set fech_fin = now()
		where fech_fin is null and tipo=new.tipo;
	end if;
	return new;
end;
$tr_HistPrecio$ language plpgsql;

create trigger tr_HistPrecio before insert on Hist_Precio
for each row execute procedure cierra_Precio();

--TRIGGER PARA VALIDAR QUE UNA PRESENTACION ITINERANTE TENGA LUGAR GEOGRAFICO, LUGAR DE PRESENTACION Y SHOW
create function val_Presenta_Itine() returns trigger as $tr_PresentaItine$
declare idshow numeric(4); declare tip varchar(12);
begin
	if new.id_SL is null then
		raise exception 'Error: Datos incompletos... Recuerda poner los datos del lugar y show';
	end if;
	
	select id_show into idshow
	from S_L
	where id=new.id_SL;
	
	select tipo into tip
	from CirqueShow
	where id=idshow;
	
	if tip<>'Itinerante' then
		raise exception 'Show seleccionado no es itinerante';
	elsif new.id_LugarPresent is null then
		raise exception 'Debes tener un lugar de presentación';
	end if;
	return new;
end;
$tr_PresentaItine$ language plpgsql;

create trigger tr_PresentaItine before insert on Presenta
for each row when (new.id_Show=null) execute procedure val_Presenta_Itine();