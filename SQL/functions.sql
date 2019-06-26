-- Archivo de funciones y procedimientos para el funcionamiento del negocio
-- No confundir con las funciones de triggers

-------------------------------------------
-- Utilidades
-------------------------------------------

-- Obtener el ultimo id de una tabla
-- @param mytable varchar
-- @returns numeric
CREATE OR REPLACE FUNCTION get_maxid(mytable varchar) RETURNS numeric AS $$
DECLARE
  var_consulta varchar;
  var_id numeric;
BEGIN
  var_consulta := 'SELECT MAX(id) FROM ' || mytable || ';';
  EXECUTE var_consulta INTO var_id;
  RETURN var_id;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------
-- Todo lo relacionado a listar contenido
-------------------------------------------

-- Listar shows activos
-- @returns table
CREATE OR REPLACE FUNCTION listar_shows_activos()
RETURNS TABLE(id numeric, nombre varchar, tipo varchar) AS $$
BEGIN
  RETURN QUERY SELECT c.id, c.nombre, c.tipo 
    FROM public.CirqueShow AS c WHERE c.estatus = TRUE;
END;
$$ LANGUAGE plpgsql;


-- Listar presentaciones disponilbes
-- @param myIdshow numeric id del show
-- @returns table
CREATE OR REPLACE FUNCTION listar_presentaciones_disponibles(myIdshow numeric)
RETURNS TABLE(id numeric, nombre varchar, fecha timestamp) AS $$
BEGIN
  RETURN QUERY SELECT DISTINCT p.id, s.nombre, p.fecha 
    FROM public.CirqueShow AS s, public.Presenta p, s_l
    WHERE ((s.id = p.id_Show) OR (s.id = s_l.id_show AND s_l.id = p.id_SL)) 
      AND p.estatus = FALSE AND s.id = myIdshow
    ORDER BY p.fecha ASC;
END;
$$ LANGUAGE plpgsql;


-- Listar paises en la base de datos
-- @param [continente] varchar nombre corto o largo del continente
-- @returns table
CREATE OR REPLACE FUNCTION listar_paises(continen varchar DEFAULT NULL)
RETURNS TABLE(id numeric, nombre varchar, continente varchar) AS $$
BEGIN
  IF continen IS NULL THEN
    RETURN QUERY SELECT l.id, l.nombre, l.contine 
      FROM public.LugarGeo AS l WHERE l.tipo_geo = 'P'
      ORDER BY l.contine, l.nombre;
  ELSE
    IF continen = 'am' OR continen = 'America' OR continen = 'america' THEN
      continen := 'AM';
    ELSIF continen = 'af' OR continen = 'Africa' OR continen = 'africa' THEN
      continen := 'AF';
    ELSIF continen = 'as' OR continen = 'Asia' OR continen = 'asia' THEN
      continen := 'AS';
    ELSIF continen = 'eu' OR continen = 'Europa' OR continen = 'europa' THEN
      continen := 'EU';
    ELSIF continen = 'oc' OR continen = 'Oceania' OR continen = 'oceania' THEN
      continen := 'OC';
    END IF;
    RETURN QUERY SELECT l.id, l.nombre, l.contine 
      FROM public.LugarGeo AS l 
      WHERE l.tipo_geo = 'P' AND l.contine = continen
      ORDER BY l.nombre;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- Listar ciudades en la base de datos
-- @param idpais numeric id del pais
-- @returns table
CREATE OR REPLACE FUNCTION listar_ciudades(idpais numeric)
RETURNS TABLE(id numeric, nombre varchar) AS $$
BEGIN
  RETURN QUERY SELECT l.id, l.nombre FROM public.LugarGeo AS l 
      WHERE l.tipo_geo = 'C' AND l.id_Lugar = idpais
      ORDER BY l.nombre;
END;
$$ LANGUAGE plpgsql;


-- Listar disciplinas
-- @param [mytipo] varchar
-- @returns table
-- SELECT * FROM listar_disciplinas();
-- SELECT * FROM listar_disciplinas('Atleta');
CREATE OR REPLACE FUNCTION listar_disciplinas(mytipo varchar DEFAULT NULL)
RETURNS TABLE(id numeric, nombre varchar, tipo varchar) AS $$
BEGIN
  IF mytipo IS NOT NULL THEN
    RETURN QUERY SELECT d.id, d.nombre, d.tipo FROM public.Disciplina d
      WHERE d.tipo = mytipo ORDER BY d.nombre;
  ELSE 
    RETURN QUERY SELECT d.id, d.nombre, d.tipo 
      FROM public.Disciplina d ORDER BY d.tipo, d.nombre;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- Listar audiciones por disciplina y ciudad
-- @param iddisiplina numeric id del pais
-- @param idciudad numeric id del pais
-- @returns table
-- SELECT * FROM listar_audiciones();
-- SELECT * FROM listar_audiciones(null, 39);
-- SELECT * FROM listar_audiciones(1);
-- SELECT * FROM listar_audiciones(1, 39);
CREATE OR REPLACE FUNCTION listar_audiciones(
  iddisiplina numeric DEFAULT NULL, 
  idciudad numeric DEFAULT NULL)
RETURNS TABLE(id numeric, disciplina varchar, ciudad varchar, inicio timestamp) AS $$
BEGIN
  IF iddisiplina IS NOT NULL AND idciudad IS NOT NULL THEN
    RETURN QUERY SELECT c.id, d.nombre, g.nombre, c.hora_in 
      FROM public.Disciplina d, public.CalenAudicion c, public.LugarPresent l, public.LugarGeo g
      WHERE c.id_LugarPreset = l.id AND c.id_Disci = d.id AND l.id_LugarGeo = g.id
        AND d.id = iddisiplina AND g.id = idciudad
      ORDER BY c.hora_in;
  ELSIF iddisiplina IS NOT NULL THEN
    RETURN QUERY SELECT c.id, d.nombre, g.nombre, c.hora_in 
      FROM public.Disciplina d, public.CalenAudicion c, public.LugarPresent l, public.LugarGeo g
      WHERE c.id_LugarPreset = l.id AND c.id_Disci = d.id AND l.id_LugarGeo = g.id
        AND d.id = iddisiplina
      ORDER BY g.nombre, c.hora_in;
  ELSIF idciudad IS NOT NULL THEN
    RETURN QUERY SELECT c.id, d.nombre, g.nombre, c.hora_in 
      FROM public.Disciplina d, public.CalenAudicion c, public.LugarPresent l, public.LugarGeo g
      WHERE c.id_LugarPreset = l.id AND c.id_Disci = d.id AND l.id_LugarGeo = g.id
        AND g.id = idciudad
      ORDER BY d.nombre, c.hora_in;
  ELSE
    RETURN QUERY SELECT c.id, d.nombre, g.nombre, c.hora_in 
      FROM public.Disciplina d, public.CalenAudicion c, public.LugarPresent l, public.LugarGeo g
      WHERE c.id_LugarPreset = l.id AND c.id_Disci = d.id AND l.id_LugarGeo = g.id
      ORDER BY d.nombre, g.nombre, c.hora_in;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- Listar los aspirantes de una audicion
-- @param idaudicion numeric
-- @returns table
-- SELECT * FROM listar_aspirantes(101);
CREATE OR REPLACE FUNCTION listar_aspirantes(idaudicion numeric)
RETURNS TABLE(id numeric, apellido varchar, nombre varchar, resultado boolean) AS $$
BEGIN
  RETURN QUERY SELECT a.id, a.apellido, a.nombre, A_A.resulta FROM A_A, Aspirante a
    WHERE A_A.id_CalenAudicion = idaudicion AND A_A.id_Aspirante = a.id
    ORDER BY a.apellido, a.nombre;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------
-- Todo lo relacionado a presentaciones
-------------------------------------------


-- Validar tiempo entre presentaiciones dada la condicion de distancia entre ciudades
-- @param lastDate timestamp ultimo dia de la presentacion
-- @param newDate timestamp nuevo dia que se desea ingresar
-- @param distancia integer Distancia entre ciudades [0..3]
-- @returns boolean
CREATE OR REPLACE FUNCTION 
validar_fechas_presentaciones(lastDate timestamp, newDate timestamp, distancia integer)
RETURNS boolean AS $$
BEGIN
  IF (SELECT newDate < lastDate) THEN
    RETURN false;
  ELSIF distancia = 0 THEN
    RETURN (SELECT (newDate - lastDate) > interval '2.5 hours');
  ELSIF distancia = 1 THEN
    RETURN (SELECT (newDate - lastDate) > interval '1 week');
  ELSIF distancia = 2 THEN
    RETURN (SELECT (newDate - lastDate) > interval '1 month');
  ELSIF distancia = 3 THEN
    RETURN (SELECT (newDate - lastDate) > interval '1.5 months');
  END IF;
  RETURN false;
END;
$$ LANGUAGE plpgsql;

-- Genera una fecha dadas las condiciones de distancia
-- @param lastDate timestamp
-- @param distancia integer
-- @returns timestamp
CREATE OR REPLACE FUNCTION 
get_proxima_fecha(lastDate timestamp, distancia integer)
RETURNS timestamp AS $$
BEGIN
  IF distancia = 0 THEN
    RETURN (SELECT lastDate + interval '2.5 hours');
  ELSIF distancia = 1 THEN
    RETURN (SELECT lastDate + interval '1 week');
  ELSIF distancia = 2 THEN
    RETURN (SELECT lastDate + interval '1 month');
  ELSIF distancia = 3 THEN
    RETURN (SELECT lastDate + interval '1.5 months');
  END IF;
  RETURN false;
END;
$$ LANGUAGE plpgsql;


-- Obtener la distancia entre 2 ciudades dades, util para itinerntes
-- @param idciudad1 numeric
-- @param idciudad2 numeric
-- @return integer 0 = 2.5h | 1 = 1s | 2 = 1m | 3 = 1.5m
CREATE OR REPLACE FUNCTION 
distancia_ciudades(idciudad1 numeric, idciudad2 numeric)
RETURNS integer AS $$
DECLARE
  var_idpais1 public.LugarGeo.id%TYPE;
  var_idpais2 public.LugarGeo.id%TYPE;
  var_contine1 public.LugarGeo.contine%TYPE;
  var_contine2 public.LugarGeo.contine%TYPE;
BEGIN
  -- Validar ciudades
  SELECT id_Lugar INTO var_idpais1 FROM public.LugarGeo 
  WHERE id = idciudad1 AND tipo_geo = 'C';
  IF NOT FOUND THEN
    RAISE EXCEPTION 'El id: % no corresponde con una ciudad', idciudad1;
  END IF;
  SELECT id_Lugar INTO var_idpais2 FROM public.LugarGeo 
  WHERE id = idciudad2 AND tipo_geo = 'C';
  IF NOT FOUND THEN
    RAISE EXCEPTION 'El id: % no corresponde con una ciudad', idciudad2;
  END IF;

  IF idciudad1 = idciudad2 THEN
    RETURN  0; -- 2.5 horas
  ELSIF var_idpais1 = var_idpais2 THEN
    RETURN  1; -- 1 semana
  ELSE 
    SELECT contine INTO var_contine1 FROM public.LugarGeo WHERE id = var_idpais1;
    SELECT contine INTO var_contine2 FROM public.LugarGeo WHERE id = var_idpais2;
    IF var_contine1 = var_contine2 
      OR (var_contine1 = 'EU' AND var_contine2 = 'AF')
      OR (var_contine1 = 'AF' AND var_contine2 = 'EU') 
      OR (var_contine1 = 'AS' AND var_contine2 = 'OC')
      OR (var_contine1 = 'OC' AND var_contine2 = 'AS')
      THEN
      RETURN 1; -- 1 semana
    ELSIF (var_contine1 = 'AM' AND var_contine2 = 'EU')
      OR (var_contine1 = 'AM' AND var_contine2 = 'AF')
      OR (var_contine1 = 'EU' AND var_contine2 = 'AM')
      OR (var_contine1 = 'EU' AND var_contine2 = 'AS')
      OR (var_contine1 = 'EU' AND var_contine2 = 'OC')
      OR (var_contine1 = 'AS' AND var_contine2 = 'EU')
      OR (var_contine1 = 'AS' AND var_contine2 = 'AF')
      OR (var_contine1 = 'OC' AND var_contine2 = 'EU')
      OR (var_contine1 = 'OC' AND var_contine2 = 'AF')
      THEN
      RETURN  2; -- 1 mes
    ELSIF (var_contine1 = 'AM' AND var_contine2 = 'AS') 
      OR (var_contine1 = 'AM' AND var_contine2 = 'OC')
      OR (var_contine1 = 'AS' AND var_contine2 = 'AM')
      OR (var_contine1 = 'OC' AND var_contine2 = 'AM')
      THEN
      RETURN  3; -- 1.5 meses
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- Insertar una fecha de presentacion para un show
-- @param idshow numeric
-- @param fecha varchar
-- @param [idlugar] numeric obligatorio para itinerantes
-- @param [validarFecha] boolean posibilidad de insertar en el pasado
CREATE OR REPLACE PROCEDURE 
insertar_presentacion(
    idshow numeric, 
    myfecha timestamp, 
    idlugar numeric DEFAULT 0, 
    validarFecha boolean DEFAULT true) AS $$
DECLARE
  var_idshow public.CirqueShow.id%TYPE;
  var_tiposhow public.CirqueShow.tipo%TYPE;
  var_maxid public.presenta.id%TYPE;
  var_idsl public.s_l.id%TYPE;
  var_idlugar public.LugarGeo.id%TYPE;
  var_idultimolugar public.LugarGeo.id%TYPE;
  var_ultimafecha public.presenta.fecha%TYPE;
  var_distancia integer;
BEGIN
  -- Validar que la fecha sea posterior a hoy
  IF validarFecha AND myfecha < (SELECT NOW()) THEN
    RAISE EXCEPTION 'No puede insertar presentaciones en el pasado';
  END IF;

  -- Validar que un itinerante tenga fecha o que un residente no la tenga
  SELECT id, tipo INTO var_idshow, var_tiposhow
    FROM public.CirqueShow WHERE id = idshow;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Show con id: % no encontreado', idshow;
  END IF;
  IF var_tiposhow = 'Residente' AND idlugar <> 0 THEN
    RAISE EXCEPTION 'No debe especificar id de lugar para los residentes';
  END IF;
  IF var_tiposhow = 'Itinerante' AND idlugar <= 0 THEN
    RAISE EXCEPTION 'Debe especificar el id de lugar para los itinerantes';
  END IF;

  -- Tomar siguiente id
  SELECT MAX(id) + 1 INTO STRICT var_maxid FROM public.presenta;
  
  -- Insertar Residente
  IF var_tiposhow = 'Residente' THEN
    INSERT INTO public.presenta VALUES
 	    (var_maxid,myfecha,(myfecha < (SELECT NOW())),idshow,null,null);
  END IF;

  -- Insertar Itinerante
  IF var_tiposhow = 'Itinerante' THEN

    -- Validar ciudad
    SELECT id INTO var_idlugar FROM public.LugarGeo 
      WHERE id = idlugar AND tipo_geo = 'C';
    IF NOT FOUND THEN
      RAISE EXCEPTION 'Ciudad con id: % no encontreado', idlugar;
    END IF;
  
    -- Tomar relacion show lugar o crear si no existe
    SELECT id INTO var_idsl FROM public.s_l 
      WHERE id_Show = idshow AND id_LugarGeo = idlugar;
    IF NOT FOUND THEN
      -- Insertar una relacion show lugar
      SELECT MAX(id) + 1 INTO STRICT var_idsl FROM public.s_l;
      INSERT INTO public.s_l VALUES (var_idsl, idshow, idlugar);
    END IF;

    -- Obtener datos del ultimo show
    SELECT s_l.id_LugarGeo, p.fecha INTO var_idultimolugar, var_ultimafecha
    FROM public.s_l, public.presenta p
    WHERE p.id_SL = s_l.id AND p.fecha <= myfecha
    ORDER BY p.fecha DESC LIMIT 1;

    IF FOUND THEN
      -- Obtener distancia entre ciudades
      SELECT distancia_ciudades(var_idultimolugar, idlugar) INTO var_distancia;
      -- Validar las fechas
      IF NOT (SELECT validar_fechas_presentaciones(var_ultimafecha, myfecha, var_distancia)) THEN
        RAISE EXCEPTION 
          'Dada la ultima presentación. Sugerimos probar con %', 
          get_proxima_fecha(var_ultimafecha, var_distancia);
      END IF;
    END IF;

    INSERT INTO public.presenta VALUES
 	    (var_maxid,myfecha,(myfecha < (SELECT NOW())),null,var_idsl,null);
  END IF;
END;
$$ LANGUAGE plpgsql;
-- Falta: validar calendario semanal de residentes y horarios


-- Generar calendario dado rango de fechas 1 o 2 horas por dia e intervalo entre fechas
-- @param idshow numeric
-- @param idlugar numeric
-- @param fecha_inicio date
-- @param fecha_final date
-- @param hora1 time
-- @param [hora2] time 
-- @param [diasintervalo] integer
CREATE OR REPLACE PROCEDURE 
generar_calendario(
    idshow numeric, 
    idlugar numeric,
    fecha_inicio date, 
    fecha_final date,
    hora1 time,
    hora2 time DEFAULT NULL,
    diasintervalo integer DEFAULT 1/*Ideal seria poner [] dias de la semana*/) AS $$
DECLARE
  var_tiposhow public.CirqueShow.tipo%TYPE;
  var_idpresentacion public.s_l.id%TYPE;
  var_fecha timestamp;
  var_intervalo integer;
BEGIN
  IF fecha_inicio >= fecha_final THEN
    RAISE EXCEPTION 'Ingrese primero la fecha inicial y luego la final de la temporada';
  END IF;
  IF hora1 >= hora2 THEN
    RAISE EXCEPTION 'Ingrese primero la hora menor y luego la mayor';
  END IF;
  
  SELECT tipo INTO var_tiposhow
    FROM public.CirqueShow WHERE id = idshow;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Show con id: % no encontreado', idshow;
  END IF;
  IF var_tiposhow = 'Residente' THEN
    RAISE EXCEPTION 'Lo sentimos, de momento está funcion no esta disponible para shows residentes';
  END IF;

  SELECT p.id INTO var_idpresentacion FROM public.s_l, public.presenta p
  WHERE p.id_SL = s_l.id AND p.fecha >= fecha_inicio AND p.fecha <= (fecha_final + TIME '23:59');

  IF FOUND THEN
    RAISE EXCEPTION 'No se pueden insertar presentaciones. Ya existen dentro de este rango';
  ELSE
    -- Generar el calendario
    var_intervalo := fecha_final - fecha_inicio;
    FOR i IN 0..var_intervalo BY diasintervalo LOOP
      var_fecha := fecha_inicio + i * interval '1 day' + hora1;
      CALL insertar_presentacion(idshow, var_fecha, idlugar, FALSE);
      IF hora2 IS NOT NULL THEN
        var_fecha := fecha_inicio + i * interval '1 day' + hora2;
        CALL insertar_presentacion(idshow, var_fecha, idlugar, FALSE);
      END IF;
    END LOOP;
  END IF;  
END;
$$ LANGUAGE plpgsql;

-------------------------------------------
-- Todo lo relacionado a Audiciones
-------------------------------------------

-- Procedimiento para copiar los datos de un aspirante a la tabla de artista
-- @param myid numeric
-- @param apodo varchar
CREATE OR REPLACE PROCEDURE 
copiar_aspiratne_artista(myid numeric, apodo varchar DEFAULT '') AS $$
DECLARE
  var_id public.aspirante.id%TYPE;
  var_nombre public.aspirante.nombre%TYPE;
  var_nombre2 public.aspirante.nombre2%TYPE;
  var_apellido public.aspirante.apellido%TYPE;
  var_apellido2 public.aspirante.apellido2%TYPE;
  var_genero public.aspirante.genero%TYPE;
  var_fech_nac public.aspirante.fech_nac%TYPE;
  var_idiomas public.aspirante.idiomas%TYPE;
  var_passport public.aspirante.passport%TYPE;
BEGIN
  SELECT id, nombre, nombre2, apellido, apellido2, genero, fech_nac, idiomas, passport 
    INTO var_id, var_nombre, var_nombre2, var_apellido, var_apellido2, var_genero, var_fech_nac, var_idiomas, var_passport
    FROM public.aspirante WHERE id = myid;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Aspirante con id: % no encontreado', myid;
  END IF;
  IF apodo IS NULL OR apodo = '' THEN
    apodo := NULL;
  END IF;
  INSERT INTO public.artist VALUES (var_id, var_nombre, var_nombre2, var_apellido, var_apellido2, var_genero, var_fech_nac, var_idiomas, var_passport, apodo);
END;
$$ LANGUAGE plpgsql;
-- CALL copiar_aspiratne_artista(55, 'El Puma');

-- Aprobar un participante
-- @param idaspirante numeric
-- @param idaudicion numeric
-- @param [apodo] varchar
-- CALL aprobar_aspirante(56, 101);
CREATE OR REPLACE PROCEDURE 
aprobar_aspirante(idaspirante numeric, idaudicion numeric, apodo varchar DEFAULT '') AS $$
DECLARE
  var_resulta public.A_A.resulta%TYPE;
  var_idartist public.Artist.id%TYPE;
BEGIN
  SELECT A_A.resulta INTO var_resulta FROM public.A_A 
    WHERE A_A.id_CalenAudicion = idaudicion AND A_A.id_Aspirante = idaspirante;
  IF NOT FOUND THEN 
    RAISE EXCEPTION 'El participante % no audicionó en %', idaspirante, idaudicion;
  ELSIF var_resulta THEN
    RAISE EXCEPTION 'El participante % ya fue aceptado en esta audicion', idaspirante;
  ELSE
    -- Aprobar artista
    UPDATE public.A_A SET resulta = TRUE 
      WHERE A_A.id_CalenAudicion = idaudicion AND A_A.id_Aspirante = idaspirante;
    SELECT a.id INTO var_idartist FROM public.Artist a WHERE a.id = idaspirante;
    -- Inserta el artista solo si es la primera vez que queda
    IF NOT FOUND THEN
      CALL copiar_aspiratne_artista(55, apodo);
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Crear una audicion en el calendario de audiciones
CREATE OR REPLACE PROCEDURE 
crear_aducion(
	hora_in timestamp,
	hora_fin timestamp,
	max_partici numeric,
	cupos_disp numeric,
	id_LugarPreset numeric,
	id_Disci numeric
) AS $$
DECLARE
  var_maxid public.CalenAudicion.id%TYPE;
BEGIN
  SELECT MAX(id)+1 INTO var_maxid FROM public.CalenAudicion;
  IF NOT FOUND OR var_maxid IS NULL THEN
    var_maxid := 1;
  END IF;
  -- Validaciones con el trigger
  INSERT INTO public.CalenAudicio VALUES 
  (var_maxid, hora_in, hora_fin, max_partici, cupos_disp, id_LugarPreset, id_Disci);
END;
$$ LANGUAGE plpgsql;

-------------------------------------------
-- Todo lo relacionado a Venta de entradas
-------------------------------------------

-- Vender entradas para las presentaciones
-- @param idpresenta numeric Id de la presentacion
-- @param precio numeric
-- @param tipo varchar Tipo de entrada
-- @param [tipoPerson] varchar Opcional tipo de persona
-- @param [fechaventa] timestamp Opcional fecha de la venta de esa entrada
-- @param [idpadre] numeric Solo para menores
CREATE OR REPLACE PROCEDURE
vender_entrada(
  idpresenta numeric, 
  precio numeric, 
  tipo varchar, 
  tipoPerson varchar(12) DEFAULT 'Adulto',
  fechaventa timestamp DEFAULT NOW(), 
  idpadre numeric DEFAULT NULL) AS $$
DECLARE
  var_maxid public.Entrada.id%TYPE;
  var_fechaini public.Presenta.fecha%TYPE;
  var_fechafin public.Presenta.fecha%TYPE;
  var_idshow public.Presenta.id_Show%TYPE;
BEGIN
  -- Selectionar intervalo de fechas
  SELECT fecha - interval '1 week', fecha - interval '30 minutes', id_Show
  INTO var_fechaini, var_fechafin, var_idshow FROM public.Presenta WHERE id = idpresenta;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Presentacion con id: % no encotrada', idpresenta;
  END IF;

  -- Hasta media hora antes  
  IF fechaventa > var_fechafin THEN
    RAISE EXCEPTION 'No se pueden vernder entradas después de %', var_fechafin;
  END IF;

  -- Si es itinerante Desde una semna antes de la presentación
  IF var_idshow IS NULL AND fechaventa < var_fechaini THEN
    RAISE EXCEPTION 'No se pueden vernder entradas antes de %, para un show itinerante', var_fechaini;
  END IF;
  
  -- Insertar
  SELECT MAX(id)+1 INTO var_maxid FROM public.Entrada;

  IF var_maxid IS NULL THEN
    var_maxid := 1; -- Primera venta
  END IF;

  IF tipoPerson = 'Menor' THEN
    precio := precio * 0.9;
  ELSIF tipoPerson = 'Tercera edad' THEN
    precio := precio * 0.8;
  END IF;

  INSERT INTO public.Entrada VALUES 
  (var_maxid,precio,tipo,tipoPerson,fechaventa,idpresenta,idpadre);
  -- Nota: Las validaciones de menores se hacen con el trigger
END;
$$ LANGUAGE plpgsql;

-- Obtener el ultimo id de las entradas (util para insertar un niño despues de un adulto)
-- @returns numeric
CREATE OR REPLACE FUNCTION get_ultima_entrada() RETURNS numeric AS $$
BEGIN
  RETURN MAX(id) FROM public.Entrada;
END;
$$ LANGUAGE plpgsql;









/******************************************************
  *                                                   *
  * Funciones para desarrollo (No usar en producción) *
  *                                                   *
******************************************************/

-- Inserta una cantidad N de entradas en cada presentacion
-- PRECUACIÓN puede demorar unos minutos
CREATE OR REPLACE PROCEDURE
dev_llenar_entradas(cantidadPorShow numeric(4)) AS $$
DECLARE
  var_presenta RECORD;
  var_random numeric;
  var_precioporpresentacion numeric;
  var_precio numeric;
  var_tipo varchar;
  var_fecha timestamp;
  var_idpadre numeric;
  var_cantidadporshow numeric;
  var_maxpresenta numeric;
  var_identrada public.entrada.id%TYPE;
BEGIN
  SELECT MAX(id)+1 INTO var_identrada FROM public.entrada;
  IF NOT FOUND OR var_identrada IS NULL THEN 
    var_identrada := 1;
  END IF;
  SELECT MAX(id) INTO var_maxpresenta FROM public.presenta;
  -- Iterar todas las presentacions
  FOR var_presenta IN SELECT id, fecha FROM public.presenta LOOP
    SELECT RANDOM() INTO var_random;
    IF var_random < 0.3 THEN
      var_cantidadporshow := cantidadPorShow * 0.5;
    ELSIF var_random < 0.7 THEN 
      var_cantidadporshow := cantidadPorShow * 0.8;
    ELSE
      var_cantidadporshow := cantidadPorShow;
    END IF;
    IF cantidadPorShow >= 100 THEN 
      var_cantidadporshow := var_cantidadporshow + (SELECT RANDOM() * cantidadPorShow * 0.1);
    END IF;
    -- Insertar entradas
    var_precioporpresentacion := (SELECT RANDOM() * 100 + 50);
    FOR i IN 1..var_cantidadporshow LOOP
      var_precio := var_precioporpresentacion;
      -- Datos de las entradas
      SELECT RANDOM() INTO var_random;
      IF var_random < 0.5 THEN
        var_tipo := 'A';
        var_precio := var_precio;
      ELSIF var_random < 0.75 THEN 
        var_tipo := 'B';
        var_precio := var_precio * 2;
      ELSIF var_random < 0.9 THEN 
        var_tipo := 'C';
        var_precio := var_precio * 2.5;
      ELSE
        var_tipo := 'VIP';
        var_precio := var_precio * 3.5;
      END IF;
      var_fecha := var_presenta.fecha - RANDOM() * interval '5 days' - interval '2 hours';
      -- Insertar
      SELECT RANDOM() INTO var_random;
      IF var_random < 0.02 THEN
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
        var_precio := var_precio * 0.9;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-1);
        var_identrada := var_identrada + 1;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-2);
        var_identrada := var_identrada + 1;
      ELSIF var_random < 0.1 THEN
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
        var_precio := var_precio * 0.9;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-1);
        var_identrada := var_identrada + 1;
      ELSIF var_random < 0.2 THEN
        var_precio := var_precio * 0.8;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Tercera edad',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
      ELSE
        INSERT INTO public.Entrada VALUES 
          (var_identrada,ROUND(var_precio,2),var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
      END IF;
    END LOOP;
    IF MOD(var_presenta.id, 100) = 0 THEN 
      RAISE NOTICE '% porciento', ROUND((var_presenta.id / var_maxpresenta) * 100, 2);
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM entrada;