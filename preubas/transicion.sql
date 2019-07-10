DROP TABLE IF EXISTS trasicion_asistente CASCADE;
DROP TABLE IF EXISTS trasicion_ingresos CASCADE;

create table trasicion_asistente(
  id SERIAL primary key,
  nombre_show varchar(32),
  continente varchar(32),
  nombre_pais varchar(32),
  numero_entradas numeric(6),
  year numeric(5),
  semestre numeric(1)
);
create table trasicion_ingresos(
  id SERIAL primary key,
  espectaculo varchar(32),
  year numeric(5),
  ingresos numeric(9,2)
);

-- AISTENTES
INSERT INTO trasicion_asistente (nombre_show,continente,nombre_pais,numero_entradas,year,semestre)
SELECT show,continente,pais,count,ano,semestre
FROM (
  SELECT 
    c.nombre as show,
    lu.contine as continente,
    lu.nombre as pais,
    date_part('year', p.fecha) as ano,
    (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN 1 ELSE 2 END) AS semestre),
    COUNT(e)
  FROM
    CirqueShow c
    INNER JOIN s_L s ON c.id = s.id_show
    INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
    INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
    INNER JOIN Presenta p on s.id = p.id_SL
    INNER JOIN Entrada e on e.id_Presenta = p.id
  GROUP BY c.nombre, lu.contine, lu.nombre, ano, semestre
) AS ITINERANTES;


INSERT INTO trasicion_asistente (nombre_show,continente,nombre_pais,numero_entradas,year,semestre)
SELECT show,continente,pais,count,ano,semestre
FROM(
  SELECT 
    c.nombre as show,
    lu.contine as continente,
    lu.nombre as pais,
    date_part('year', p.fecha) as ano,
    (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN 1 ELSE 2 END) AS semestre),
    COUNT(e)
  FROM
    CirqueShow c,
    LugarGeo l,
    LugarGeo Lu,
    Presenta p,
    Entrada e
  WHERE
    p.id_Show = c.id AND
    e.id_Presenta = p.id AND
    c.id_LugarPresent = l.id AND
    l.id_lugar=lu.id
  GROUP BY c.nombre, lu.contine, lu.nombre, ano, semestre
) AS RESIDENTES;

-- INGRESOS
INSERT INTO trasicion_ingresos (espectaculo, year, ingresos)
SELECT 
	c.nombre AS espectaculo,
  date_part('year', p.fecha) as year,
	SUM(e.precio) AS ingresos
FROM
	CirqueShow c,
	Presenta p,
	Entrada e
WHERE
	p.id_Show = c.id AND
	e.id_Presenta = p.id
GROUP BY espectaculo, year
UNION
SELECT 
	c.nombre AS espectaculo,
  date_part('year', p.fecha) as year,
	SUM(e.precio) AS ingresos
FROM
	CirqueShow c
  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id
GROUP BY espectaculo, year;