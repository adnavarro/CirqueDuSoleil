-- Archivo de funciones y procedimientos para el funcionamiento del negocio
-- No confundir con las funciones de triggers

-- Insertar una fecha de presentacion de un show itinerante dada el show y la ciudad
-- @param idshow numeric
-- @param idlugar numeric
-- @param fecha varchar
CREATE OR REPLACE PROCEDURE 
insertar_presentacion(idshow numeric, idlugar numeric, myfecha timestamp) AS $$
DECLARE
  var_idshow public.CirqueShow.id%TYPE;
  var_tiposhow public.CirqueShow.tipo%TYPE;
  var_maxid public.presenta.id%TYPE;
  var_idsl public.s_l.id%TYPE;
  var_idlugar public.LugarGeo.id%TYPE;
BEGIN
  -- Validar que la fecha sea posterior a hoy
  -- Obtener ultma fecha

  -- Validar que el tipo de show sea itinerante y se proporcione ciudad
  -- UItil si quiero insertar residentes con el mismo comando
  SELECT id, tipo INTO var_idshow, var_tiposhow
    FROM public.CirqueShow WHERE id = idshow;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Show con id: % no encontreado', idshow;
  END IF;
  IF var_tiposhow = 'Residente' AND idlugar <> 0 THEN
    RAISE EXCEPTION 'No debe especificar id de lugar para los residentes';
  END IF;
  IF var_tiposhow = 'Residente' AND idlugar <= 0 THEN
    RAISE EXCEPTION 'Debe especificar el id de lugar para los itinerantes';
  END IF;

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

  SELECT MAX(id) + 1 INTO STRICT var_maxid FROM public.presenta;
  
  -- Insertar Residente
  
  -- Insertar Itinerante
  INSERT INTO public.presenta values
 	  (var_maxid,myfecha,false,var_idshow,var_idsl,null);
END;
$$ LANGUAGE plpgsql;

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
    RAISE EXCEPTION 'aspirante con id: % no encontreado', myid;
  END IF;
  IF apodo IS NULL OR apodo = '' THEN
    apodo := NULL;
  END IF;
  INSERT INTO public.artist VALUES (var_id, var_nombre, var_nombre2, var_apellido, var_apellido2, var_genero, var_fech_nac, var_idiomas, var_passport, apodo);
END;
$$ LANGUAGE plpgsql;
-- CALL copiar_aspiratne_artista(55, 'El Puma')

