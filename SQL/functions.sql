-- Archivo de funciones y procedimientos para el funcionamiento del negocio
-- No confundir con las funciones de triggers

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
        RAISE EXCEPTION 'La siguente ciudad y fecha para la presentacion no cumplen los parametros';
      END IF;
    END IF;

    INSERT INTO public.presenta VALUES
 	    (var_maxid,myfecha,(myfecha < (SELECT NOW())),null,var_idsl,null);
  END IF;
END;
$$ LANGUAGE plpgsql;
-- USO
  -- Insertar itinerante normal
    -- CALL insertar_presentacion(1, '20-05-2020 20:00', 64);
  -- Insertar itinerante en el pasado (Para desarrollo)
    -- CALL insertar_presentacion(1, '20-05-2010 20:00', 64, false);
  -- Insertar residente
    -- CALL insertar_presentacion(5, '20-05-2020 20:00');
  -- Insertar residente en el pasado (Para desarrollo)
    -- CALL insertar_presentacion(5, '20-05-2010 20:00', 0, false);
--

-- Validar calendario semanal de residentes y horarios

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
-- CALL copiar_aspiratne_artista(55, 'El Puma')

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

  INSERT INTO public.Entrada VALUES 
  (var_maxid,precio,tipo,tipoPerson,fechaventa,idpresenta,idpadre);
  -- Nota: Las validaciones de menores se hacen con el trigger
END;
$$ LANGUAGE plpgsql;
-- USO
  --Vender una entrada normal para hoy
    -- CALL vender_entrada(1, 53.5, 'VIP');
  --Vender una entrada de un menor para hoy
    -- CALL vender_entrada(1, 53.5, 'VIP', 'Menor', NOW(), 1);
  --Vender una entrada en otro dia para un menor
    -- CALL vender_entrada(1, 53.5, 'VIP', 'Menor', '20-10-2020 20:00', 5);
--

CREATE OR REPLACE FUNCTION get_presentaciones_disponibles2(myIdshow numeric)
RETURNS TABLE(id numeric, idShow numeric, nombre varchar, fecha timestamp) AS $$
BEGIN
    RETURN QUERY SELECT DISTINCT p.id, s.id AS idShow, s.nombre, p.fecha 
      FROM public.CirqueShow AS s, public.Presenta p, s_l
      WHERE ((s.id = p.id_Show) OR (s.id = s_l.id_show AND s_l.id = p.id_SL)) 
        AND p.estatus = FALSE AND s.id = myIdshow;
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
  var_precio numeric;
  var_tipo varchar;
  var_fecha timestamp;
  var_idpadre numeric;
  var_cantidadporshow numeric;
  var_maxpresenta numeric;
  var_identrada public.entrada.id%TYPE;
BEGIN
  var_identrada := 1;
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
    var_precio := (SELECT RANDOM() * 100 + 50);
    FOR i IN 1..var_cantidadporshow LOOP
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
          (var_identrada,var_precio,var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
        var_precio := var_precio * 0.9;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-1);
        var_identrada := var_identrada + 1;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-2);
        var_identrada := var_identrada + 1;
      ELSIF var_random < 0.1 THEN
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
        var_precio := var_precio * 0.9;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Menor',var_fecha,var_presenta.id,var_identrada-1);
        var_identrada := var_identrada + 1;
      ELSIF var_random < 0.2 THEN
        var_precio := var_precio * 0.8;
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Tercera edad',var_fecha,var_presenta.id,NULL);
        var_identrada := var_identrada + 1;
      ELSE
        INSERT INTO public.Entrada VALUES 
          (var_identrada,var_precio,var_tipo,'Adulto',var_fecha,var_presenta.id,NULL);
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