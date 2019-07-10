DROP TABLE IF EXISTS trasicion_asistente CASCADE;
DROP TABLE IF EXISTS trasicion_ingresos CASCADE;
DROP TABLE IF EXISTS transicion_disciplinaid CASCADE;
DROP TABLE IF EXISTS transicion_audicion CASCADE;

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
CREATE TABLE transicion_disciplinaid (
  id SERIAL primary key,
  id_disci numeric(4),
  nombre_disci varchar(32),
  cantidad_ins numeric(4),
  year numeric(5),
  Crecimiento text
);
CREATE TABLE transicion_audicion (
  id SERIAL primary key,
  fecha timestamp,
  year numeric(5),
  semestre numeric(1),
  cupos numeric(3),
  aprobados numeric(3)
);

-- DISCIPLINA
INSERT INTO transicion_disciplinaid(id_disci,nombre_disci,cantidad_ins,year,Crecimiento)
SELECT "Disciplina","Nombre","Cantidad de Inscritos","Año","Crecimiento"
FROM (
  SELECT 
  aspirantes.disci_id as "Disciplina",
  d.nombre as "Nombre",
  sum(aspirantes.nume_disci) as "Cantidad de Inscritos",
  date_part('year',c.hora_in) as "Año",
  ROUND(100*(SUM(aspirantes.nume_disci)-LAG(SUM(aspirantes.nume_disci),1) OVER (ORDER BY aspirantes.disci_id))
    / (lag(SUM(aspirantes.nume_disci), 1) over (order by aspirantes.disci_id)),2) || '%' as "Crecimiento"

FROM
  CalenAudicion c,
  Disciplina d,
  (SELECT count(disci) as nume_disci, disci.id as disci_id, Calenda.id as Calenda_id
   FROM a_a as a, Disciplina as disci, CalenAudicion as Calenda
  WHERE a.id_CalenAudicion = Calenda.id and a.resulta= TRUE and Calenda.id_disci = disci.id
  GROUP BY disci.id, Calenda.id
  ORDER BY disci.id) as aspirantes
WHERE
   c.id=aspirantes.Calenda_id and aspirantes.Calenda_id = c.id and d.id=aspirantes.disci_id
GROUP BY  date_part('year',c.hora_in), aspirantes.disci_id, aspirantes.nume_disci, d.nombre
ORDER BY aspirantes.disci_id
) AS DISCIPLINAS;

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

INSERT INTO transicion_audicion(fecha, year, semestre, cupos, aprobados)
SELECT 
  c.hora_in as fecha,
  date_part('year',c.hora_in) as year,
  (SELECT (CASE WHEN date_part('month', c.hora_in) < 7 THEN 1 ELSE 2 END) AS semestre),
  cupos_disp as cupos,
  COUNT(a_a.resulta) as aprobados
FROM CalenAudicion c
JOIN A_A ON c.id = a_a.id_CalenAudicion 
WHERE resulta = TRUE
GROUP BY fecha, year, semestre, cupos
ORDER BY fecha;
