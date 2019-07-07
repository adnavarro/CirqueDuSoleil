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

-- Paises con shows itinerantes por semestres
SELECT 
	c.nombre as show,
	lu.nombre as pais,
  date_part('year', p.fecha) as ano,
  (SELECT (CASE WHEN date_part('month', p.fecha) < 7 THEN '1' ELSE '2' END) AS semestre),
	COUNT(e)
FROM
	CirqueShow c
  INNER JOIN s_L s ON c.id = s.id_show
  INNER JOIN LugarGeo l ON s.id_LugarGeo = l.id
  INNER JOIN LugarGeo Lu ON l.id_lugar=lu.id
  INNER JOIN Presenta p on s.id = p.id_SL
  INNER JOIN Entrada e on e.id_Presenta = p.id
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha), semestre;