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
  (l.id_lugar=lu.id)
GROUP BY c.nombre, lu.nombre, date_part('year', p.fecha), semestre;
