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


-- LUGAR
INSERT INTO datamart_lugar(continente)
SELECT continente FROM (
  SELECT DISTINCT continente FROM trasicion_asistente ORDER BY continente
) AS CONTINENTES;

INSERT INTO datamart_lugar(continente, pais)
SELECT continente, nombre_pais FROM (
  SELECT DISTINCT continente, nombre_pais FROM trasicion_asistente ORDER BY continente, nombre_pais
) AS PAISES;

-- DATAMART
SELECT nombre_show, numero_entradas, semestre 
FROM trasicion_asistente 
WHERE year = 2018 AND nombre_pais = 'EEUU' AND semestre = 2
ORDER BY numero_entradas DESC
LIMIT 3;

CREATE OR REPLACE PROCEDURE
llenar_datamart_asistentes() AS $$
DECLARE
  record_lugar RECORD;
  record_tiempo RECORD;
  record_asistente RECORD;
  show1 public.datamart.espectaculo_asistido1%TYPE;
  show2 public.datamart.espectaculo_asistido2%TYPE;
  show3 public.datamart.espectaculo_asistido3%TYPE;
  cantidad1 public.datamart.cantidad_asistido1%TYPE;
  cantidad2 public.datamart.cantidad_asistido2%TYPE;
  cantidad3 public.datamart.cantidad_asistido3%TYPE;
BEGIN
  FOR record_lugar IN SELECT id, pais, continente FROM public.datamart_lugar LOOP
    FOR record_tiempo IN SELECT id, semestre, year FROM public.datamart_tiempo LOOP
      -- Pais semestre
      IF (record_lugar.pais IS NOT NULL AND record_tiempo.semestre IS NOT NULL) 
      THEN
        FOR record_asistente IN 
          SELECT nombre_show, numero_entradas, semestre
          FROM trasicion_asistente 
          WHERE year = record_tiempo.year AND semestre = record_tiempo.semestre AND 
            continente = record_lugar.continente AND nombre_pais = record_lugar.pais
          ORDER BY numero_entradas DESC LIMIT 3;
        LOOP
          -- Hacer cosas bonitas aquí
        END LOOP;
      END IF;
    END LOOP;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
