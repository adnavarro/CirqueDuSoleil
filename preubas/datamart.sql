DROP TABLE IF EXISTS datamart CASCADE;
DROP TABLE IF EXISTS datamart_lugar CASCADE;
DROP TABLE IF EXISTS datamart_tiempo CASCADE;
DROP TABLE IF EXISTS datamart_disiplina CASCADE;

create table datamart_lugar(
  id SERIAL primary key,
  pais varchar(32),
  continente varchar(32),
  fechacreacion timestamp DEFAULT NOW()
);
create table datamart_tiempo(
  id SERIAL primary key,
  semestre numeric(1),
  year numeric(5),
  bienio varchar(9) -- Ej: '2017-2018'
);
create table datamart_disiplina(
  id SERIAL primary key,
  nombre varchar(32),
  fechacreacion timestamp DEFAULT NOW()
);
create table datamart(
  id SERIAL primary key,
  espectaculo_asistido1 varchar(32),
  espectaculo_asistido2 varchar(32),
  espectaculo_asistido3 varchar(32),
  cantidad_asistido1 numeric(6),
  cantidad_asistido2 numeric(6),
  cantidad_asistido3 numeric(6),
  espectaculo_ingreso1 varchar(32),
  espectaculo_ingreso2 varchar(32),
  espectaculo_ingreso3 varchar(32),
  cantidad_ingreso1 numeric(9,2),
  cantidad_ingreso2 numeric(9,2),
  cantidad_ingreso3 numeric(9,2),
  espectaculo_crecimiento_i varchar(32),
  espectaculo_crecimiento_r varchar(32),
  porcentaje_audiciones_positiva numeric(4,2),
  porcentaje_crecimiento_disiplina numeric(4,2),
  id_lugar integer,
  id_tiempo integer,
  id_disiplina integer
);


-- TIEMPO
INSERT INTO datamart_tiempo(year)
SELECT year FROM (
  SELECT DISTINCT year FROM trasicion_asistente ORDER BY year
) AS YEARS;

INSERT INTO datamart_tiempo(year, semestre)
SELECT year, semestre FROM (
  SELECT DISTINCT year, semestre FROM trasicion_asistente ORDER BY year, semestre
) AS SEMESTRES;

INSERT INTO datamart_tiempo(bienio)
SELECT DISTINCT year || '-' || year + 1 as bienio 
FROM trasicion_ingresos 
WHERE year + 1 <= (SELECT MAX(year) FROM trasicion_ingresos)
ORDER BY bienio;


-- LUGAR
INSERT INTO datamart_lugar(continente)
SELECT continente FROM (
  SELECT DISTINCT continente FROM trasicion_asistente ORDER BY continente
) AS CONTINENTES;

INSERT INTO datamart_lugar(continente, pais)
SELECT continente, nombre_pais FROM (
  SELECT DISTINCT continente, nombre_pais FROM trasicion_asistente ORDER BY continente, nombre_pais
) AS PAISES;

-- DATAMART ASISTENTES
CREATE OR REPLACE PROCEDURE
llenar_datamart_asistentes() AS $$
DECLARE
  record_lugar RECORD;
  record_tiempo RECORD;
  var_shows varchar(32) ARRAY[3];
  var_cantidades numeric(6) ARRAY[3];
BEGIN
  FOR record_lugar IN SELECT id, pais, continente FROM public.datamart_lugar LOOP
    FOR record_tiempo IN SELECT id, semestre, year 
      FROM public.datamart_tiempo WHERE bienio IS NULL
    LOOP
      -- PAIS SEMESTRE
      IF (record_lugar.pais IS NOT NULL AND 
        record_lugar.continente IS NOT NULL AND 
        record_tiempo.semestre IS NOT NULL AND 
        record_tiempo.year IS NOT NULL
      ) THEN
        SELECT ARRAY(SELECT nombre_show FROM trasicion_asistente 
          WHERE year = record_tiempo.year AND semestre = record_tiempo.semestre AND 
            continente = record_lugar.continente AND nombre_pais = record_lugar.pais
          ORDER BY numero_entradas DESC LIMIT 3
        ) INTO var_shows;
        SELECT ARRAY(SELECT numero_entradas FROM trasicion_asistente 
          WHERE year = record_tiempo.year AND semestre = record_tiempo.semestre AND 
            continente = record_lugar.continente AND nombre_pais = record_lugar.pais
          ORDER BY numero_entradas DESC LIMIT 3
        ) INTO var_cantidades;
      END IF;
      -- PAIS AÑO
      IF (record_lugar.pais IS NOT NULL AND 
        record_lugar.continente IS NOT NULL AND 
        record_tiempo.semestre IS NULL AND 
        record_tiempo.year IS NOT NULL
      ) THEN
        SELECT ARRAY(SELECT nombre_show FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND  
              continente = record_lugar.continente AND nombre_pais = record_lugar.pais
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS PAISYEAR
        ) INTO var_shows;
        SELECT ARRAY(SELECT entradas FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND  
              continente = record_lugar.continente AND nombre_pais = record_lugar.pais
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS PAISYEAR
        ) INTO var_cantidades;
      END IF;
      -- CONTINENTE SEMESTRE
      IF (record_lugar.pais IS NULL AND 
        record_lugar.continente IS NOT NULL AND 
        record_tiempo.semestre IS NOT NULL AND 
        record_tiempo.year IS NOT NULL
      ) THEN
        SELECT ARRAY(SELECT nombre_show FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND semestre = record_tiempo.semestre AND
              continente = record_lugar.continente
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS CONTINENTESEMESTRE
        ) INTO var_shows;
        SELECT ARRAY(SELECT entradas FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND semestre = record_tiempo.semestre AND
              continente = record_lugar.continente
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS CONTINENTESEMESTRE
        ) INTO var_cantidades;
      END IF;
      -- CONTINENTE AÑO
      IF (record_lugar.pais IS NULL AND 
        record_lugar.continente IS NOT NULL AND 
        record_tiempo.semestre IS NULL AND 
        record_tiempo.year IS NOT NULL
      ) THEN
        SELECT ARRAY(SELECT nombre_show FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND continente = record_lugar.continente
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS CONTINENTESEMESTRE
        ) INTO var_shows;
        SELECT ARRAY(SELECT entradas FROM (
            SELECT nombre_show, SUM(numero_entradas) AS entradas 
            FROM trasicion_asistente 
            WHERE year = record_tiempo.year AND continente = record_lugar.continente
            GROUP BY nombre_show
            ORDER BY entradas DESC LIMIT 3
          ) AS CONTINENTESEMESTRE
        ) INTO var_cantidades;
      END IF;
      -- INSERT
      IF array_length(var_shows, 1) > 0 THEN
        INSERT INTO datamart(
          espectaculo_asistido1,
          espectaculo_asistido2,
          espectaculo_asistido3,
          cantidad_asistido1,
          cantidad_asistido2,
          cantidad_asistido3,
          id_lugar,
          id_tiempo
        ) VALUES (
          var_shows[1],
          var_shows[2],
          var_shows[3],
          var_cantidades[1],
          var_cantidades[2],
          var_cantidades[3],
          record_lugar.id,
          record_tiempo.id
        );
      END IF;
    END LOOP;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
CALL llenar_datamart_asistentes();

-- DATAMART INGRESOS
CREATE OR REPLACE PROCEDURE
llenar_datamart_ingresos() AS $$
DECLARE
  record_tiempo RECORD;
  var_shows varchar(32) ARRAY[3];
  var_ingresos numeric(9,2) ARRAY[3];
BEGIN
  FOR record_tiempo IN 
    SELECT id, year, bienio FROM public.datamart_tiempo 
    WHERE semestre IS NULL
  LOOP
    -- AÑOS
    IF record_tiempo.year IS NOT NULL THEN
      SELECT ARRAY(SELECT espectaculo FROM trasicion_ingresos 
        WHERE year = record_tiempo.year 
        ORDER BY ingresos DESC LIMIT 3
      ) INTO var_shows;
      SELECT ARRAY(SELECT ingresos FROM trasicion_ingresos 
        WHERE year = record_tiempo.year 
        ORDER BY ingresos DESC LIMIT 3
      ) INTO var_ingresos;
    -- BIENIOS
    ELSIF record_tiempo.bienio IS NOT NULL THEN 
      SELECT ARRAY(SELECT espectaculo FROM (
          SELECT espectaculo, SUM(ingresos) as ingresos
          FROM trasicion_ingresos 
          WHERE year = split_part(record_tiempo.bienio, '-', 1)::numeric OR 
            year = split_part(record_tiempo.bienio, '-', 2)::numeric
          GROUP BY espectaculo
          ORDER BY ingresos DESC LIMIT 3
        ) AS BIENIOS
      ) INTO var_shows;
      SELECT ARRAY(SELECT ingresos FROM (
          SELECT espectaculo, SUM(ingresos) as ingresos
          FROM trasicion_ingresos 
          WHERE year = split_part(record_tiempo.bienio, '-', 1)::numeric OR 
            year = split_part(record_tiempo.bienio, '-', 2)::numeric
          GROUP BY espectaculo
          ORDER BY ingresos DESC LIMIT 3
        ) AS BIENIOS
      ) INTO var_ingresos;
    END IF;
    -- INSERT
    IF array_length(var_shows, 1) > 0 THEN
      INSERT INTO datamart(
        espectaculo_ingreso1,
        espectaculo_ingreso2,
        espectaculo_ingreso3,
        cantidad_ingreso1,
        cantidad_ingreso2,
        cantidad_ingreso3,
        id_tiempo
      ) VALUES (
        var_shows[1],
        var_shows[2],
        var_shows[3],
        var_ingresos[1],
        var_ingresos[2],
        var_ingresos[3],
        record_tiempo.id
      );
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
CALL llenar_datamart_ingresos();