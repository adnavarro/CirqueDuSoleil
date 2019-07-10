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
ORDER BY aspirantes.disci_id;
