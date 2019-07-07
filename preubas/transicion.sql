create table Tabla_transicion(
  id SERIAL primary key,
  nombre_show varchar(32),
  nombre_pais varchar(32),
  numero_entradas numeric(6),
  year numeric(5),
  semestre numeric(1)
);

INSERT INTO Tabla_transicion (nombre_show,nombre_pais,numero_entradas,year,semestre)
SELECT show,pais,count,ano,semestre
FROM (SELECT 
	c.nombre as show,
	lu.nombre as pais,
	COUNT(e),
  date_part('year', p.fecha) as ano,
  (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN 1 ELSE 2 END) AS semestre)
FROM
	CirqueShow c
  INNER JOIN s_L s on c.id = s.id_show
  INNER JOIN LugarGeo l on s.id_LugarGeo = l.id,
  LugarGeo Lu,
	Entrada e
  INNER JOIN Presenta p on e.id_Presenta = p.id
WHERE
  (l.id_lugar=lu.id) AND s.id = p.id_SL
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha), semestre) AS NARUTO;


INSERT INTO Tabla_transicion (nombre_show,nombre_pais,numero_entradas,year,semestre)
SELECT show,pais,count,ano,semestre
FROM( SELECT
	c.nombre as show,
	lu.nombre as pais,
	COUNT(e),
  date_part('year', p.fecha) as ano,
   (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN 1 ELSE 2 END) AS semestre)
FROM
	CirqueShow c,
	LugarGeo l,
  LugarGeo Lu,
	Entrada e,
	Presenta p
WHERE
	p.id_Show = c.id AND
	e.id_Presenta = p.id AND
	c.id_LugarPresent = l.id AND
  l.id_lugar=lu.id
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha),semestre) AS RESIDENTES;
