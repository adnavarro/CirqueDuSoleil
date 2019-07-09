SELECT 
  count(aspirantes.nume_audi) as "AUDICIONES POSITIVAS",
  date_part('year',c.hora_in) as "AÑO",
  (SELECT (CASE WHEN date_part('month', c.hora_in) < 7 THEN 1 ELSE 2 END) AS "SEMESTRE"),
  ROUND(100*(count(aspirantes.nume_audi)-LAG(count(aspirantes.nume_audi),1) OVER (ORDER BY date_part('year',c.hora_in)))
		/ (lag(count(aspirantes.nume_audi), 1) over (order by date_part('year',c.hora_in))),2) || '%' as "Crecimiento"
FROM
  CalenAudicion c,
  (SELECT count(CalenAudicion.id) as nume_audi, CalenAudicion.id as calen_id, a.id_CalenAudicion as a_calen_id
   FROM a_a as a, CalenAudicion 
  WHERE a.id_CalenAudicion = CalenAudicion.id and a.resulta= TRUE
  GROUP BY CalenAudicion.id, a.id_CalenAudicion
  ORDER BY CalenAudicion.id) as aspirantes
WHERE
  c.cupos_disp <= aspirantes.nume_audi and c.id=aspirantes.calen_id
GROUP BY  date_part('year',c.hora_in), "SEMESTRE" ;
