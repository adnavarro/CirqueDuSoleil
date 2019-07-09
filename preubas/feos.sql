-- Paises con shows residentes por año
SELECT 
	c.nombre,
	lu.nombre,
	COUNT(e),
  date_part('year', p.fecha)
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
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha);

UPDATE CirqueShow SET id_LugarPresent = 3 WHERE id = 5;

SELECT 
	c.nombre,
	p.fecha
FROM
	CirqueShow c,
  Presenta p
WHERE
  c.id = 5 AND
	p.id_Show = c.id
;

---- Paises con shows residentes por semestre
SELECT 
	c.nombre as show,
	lu.nombre as pais,
  date_part('year', p.fecha) as ano,
  (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN '1' ELSE '2' END) AS semestre),
	COUNT(e)
FROM
	CirqueShow c,
	LugarGeo l,
  LugarGeo Lu,
	Presenta p,
	Entrada e,
  s_l
WHERE
	(c.id = p.id_Show AND
	p.id = e.id_Presenta AND
	c.id_LugarPresent = l.id AND
  l.id_lugar=lu.id) OR
  (c.id = s_l.id_Show AND 
  s_l.id_LugarGeo = l.id AND
  p.id = e.id_Presenta AND 
  l.id_lugar=lu.id)
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha), semestre;


SELECT 
	c.nombre as show,
	l.id_lugar as pais,
  date_part('year', p.fecha) as ano,
  COUNT(e)
FROM
	CirqueShow c,
	LugarGeo l,
	Presenta p,
  s_l,
	Entrada e
WHERE
  (c.id = s_l.id_Show AND 
  s_l.id_LugarGeo = l.id AND
  p.id = e.id_Presenta)
GROUP BY c.nombre, l.id_lugar, date_part('year', p.fecha)
Order BY ano;

SELECT DISTINCT p.id, s.nombre, p.fecha 
    FROM public.CirqueShow AS s, public.Presenta p, s_l
    WHERE ((s.id = p.id_Show) OR (s.id = s_l.id_show AND s_l.id = p.id_SL)) 
      AND p.estatus = FALSE AND s.id = myIdshow
    ORDER BY p.fecha ASC;



(SELECT l.nombre
    FROM LugarGeo Lu
    WHERE l.id_lugar=lu.id) 

    ---- Paises con shows residentes por semestre
SELECT 
	c.nombre as show,
	lu.nombre as pais,
  date_part('year', p.fecha) as ano,
  (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN '1' ELSE '2' END) AS semestre),
	COUNT(e)
FROM
	CirqueShow c
  INNER JOIN s_L s on c.id = s.id_show
  INNER JOIN LugarGeo l on s.id_LugarGeo = l.id,
  LugarGeo Lu,
	Entrada e
  INNER JOIN Presenta p on e.id_Presenta = p.id
WHERE
  (l.id_lugar=lu.id) AND s.id = p.id_SL
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha), semestre;




SELECT 
  c.nombre as show, 
  lu.nombre as pais,
  p.fecha
FROM CirqueShow c
  INNER JOIN s_l s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p ON s.id = p.id_SL;

  

SELECT 
  c.nombre as show, 
  lu.nombre as pais,
  p.fecha,
  e.id as entrada
FROM CirqueShow c
  INNER JOIN s_l s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p ON s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id;

SELECT 
  c.nombre as show, 
  l.nombre as pais,
  p.fecha,
  e.id as entrada
FROM CirqueShow c
  INNER JOIN s_l s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p ON s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id;



SELECT 
  c.nombre as show, 
  lu.nombre as pais,
  p.fecha,
  COUNT(e) as entradas
FROM CirqueShow c
  INNER JOIN s_l s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p ON s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id
GROUP BY show, pais, fecha;

SELECT 
  c.nombre as show, 
  l.nombre as pais,
  p.fecha,
  COUNT(e) as entradas
FROM CirqueShow c,
  s_l s,
  LugarGeo l,
  LugarGeo Lu,
  Presenta p,
  Entrada e
WHERE
  c.id = s.id_show AND
  s.id_LugarGeo = l.id AND
  l.id_lugar=lu.id AND
  s.id = p.id_SL AND
  e.id_Presenta = p.id
GROUP BY show, pais, fecha;



SELECT c.nombre as show, 
  l.nombre as pais,
  e.id as entrada,
  p.fecha
FROM CirqueShow c,
  s_l s,
  LugarGeo l,
  Presenta p,
  Entrada e
WHERE
  c.id = 3 AND
  c.id = s.id_show AND
  s.id_LugarGeo = l.id AND
  s.id = p.id_SL AND
  e.id_Presenta = p.id AND
  p.fecha > '2014-12-01' AND p.fecha < '2014-12-31';



  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id



SELECT 
	c.nombre,
	lu.nombre
FROM
	CirqueShow c,
	LugarGeo l,
  LugarGeo Lu,
	Presenta p
WHERE
	p.id_Show = c.id AND
	c.id_LugarPresent = l.id AND
  l.id_lugar=lu.id
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha);



SELECT 
	COUNT(e)
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
  l.id_lugar=lu.id;


SELECT 
	COUNT(e)
FROM
	CirqueShow c
  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id;




-- Ingresos por año
SELECT 
	c.nombre,
  date_part('year', p.fecha),
	SUM(e.precio)
FROM
	CirqueShow c,
	Presenta p,
	Entrada e
WHERE
	p.id_Show = c.id AND
	e.id_Presenta = p.id
GROUP BY c.nombre, date_part('year', p.fecha)
UNION
SELECT 
	c.nombre as show,
  date_part('year', p.fecha),
	SUM(e.precio)
FROM
	CirqueShow c
  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id
GROUP BY c.nombre, date_part('year', p.fecha);

SELECT SUM(precio) FROM entrada;

SELECT SUM(e.precio)
FROM
	CirqueShow c,
	Presenta p,
	Entrada e
WHERE
	p.id_Show = c.id AND
	e.id_Presenta = p.id
SELECT 
	SUM(e.precio)
FROM
	CirqueShow c
  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id;



SELECT DISTINCT year FROM trasicion_asistente ORDER BY year;

SELECT nombre_show, numero_entradas, semestre 
FROM trasicion_asistente 
WHERE year = 2018 AND nombre_pais = 'EEUU' AND semestre = 1
ORDER BY numero_entradas DESC
LIMIT 3;
SELECT nombre_show, numero_entradas, semestre 
FROM trasicion_asistente 
WHERE year = 2018 AND nombre_pais = 'EEUU' AND semestre = 2
ORDER BY numero_entradas DESC
LIMIT 3;

SELECT nombre_show, SUM(numero_entradas) AS entradas, year 
FROM trasicion_asistente 
WHERE year = 2018 AND nombre_pais = 'EEUU'
GROUP BY nombre_show, year
ORDER BY entradas DESC
LIMIT 3;

SELECT ARRAY(
  SELECT nombre_show FROM (
    SELECT nombre_show, SUM(numero_entradas) AS entradas 
    FROM trasicion_asistente 
    WHERE year = 2018 AND nombre_pais = 'EEUU'
    GROUP BY nombre_show
    ORDER BY entradas DESC
    LIMIT 3
  ) AS PAISYEAR
);

SELECT ARRAY(SELECT nombre_show FROM (
    SELECT nombre_show, SUM(numero_entradas) AS entradas 
    FROM trasicion_asistente 
    WHERE year = 2018 AND semestre = 1 AND
      continente = 'AM'
    GROUP BY nombre_show
    ORDER BY entradas DESC LIMIT 3
  ) AS CONTINENTESEMESTRE
);

SELECT nombre_show, SUM(numero_entradas) AS entradas 
FROM trasicion_asistente 
WHERE year = 2018 AND continente = 'AM'
GROUP BY nombre_show
ORDER BY entradas DESC LIMIT 3;

SELECT nombre_show, numero_entradas, nombre_pais
FROM trasicion_asistente 
WHERE year = 2018 AND semestre = 1 AND
  continente = 'AM'
ORDER BY numero_entradas DESC LIMIT 3;

CALL llenar_datamart_asistentes();
SELECT espectaculo_asistido1 as show1,
  espectaculo_asistido2 as show2,
  espectaculo_asistido3 as show3,
  cantidad_asistido1 as cant1,
  cantidad_asistido2 as cant2,
  cantidad_asistido3 as cant3,
  id_lugar as l, id_tiempo as t
FROM datamart;
TRUNCATE datamart;

