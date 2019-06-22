-- Archivo de funciones y procedimientos para el funcionamiento del negocio
-- No confundir con las funciones de triggers


-- Seleccionar un show de la lista de shows activos
-- @return idShow numeric
--CREATE OR REPLACE FUNCTION insert_presentacion()
--RETURNS public.CirqueShow.id%TYPE $$
--DECLARE
--BEGIN
--  SELECT id, nombre FROM public.CirqueShow;
--END;
--$$ LANGUAGE plpgsql;
--
---- Insertar una presentacion para un show
--CREATE OR REPLACE FUNCTION insert_presentacion()
--RETURNS text AS $$
--DECLARE
--BEGIN
--  SELECT id, nombre FROM public.CirqueShow;
--
--  -- Quiere guardar los cambios?
--  ROLLBACK;
--  COMMIT;
--END;
--$$ LANGUAGE plpgsql;


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
    INTO STRICT var_id, var_nombre, var_nombre2, var_apellido, var_apellido2, var_genero, var_fech_nac, var_idiomas, var_passport
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

