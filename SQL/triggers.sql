--TRIGGER PARA VALIDAR QUE LA MONEDA Y EL CONTINENTE DE UN PAIS NO SEA NULO
create function val_LugarGeo_monCon() returns trigger as $tr_LugarGeoMonCon$
begin
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

--TRIGGER PARA VALIDAR QUE CADA CIUDAD TENGA UN PAIS ASOCIADO
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