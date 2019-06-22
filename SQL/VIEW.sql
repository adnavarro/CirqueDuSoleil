
CREATE OR REPLACE VIEW shows_activos AS
SELECT id, nombre, tipo FROM public.CirqueShow WHERE estatus = TRUE;

CREATE OR REPLACE VIEW ciudades_show_itinerante AS 
SELECT s_l.id, c.id AS idshow, c.nombre, l.nombre AS lugar
FROM CirqueShow AS c, s_l, LugarGeo l
WHERE c.id = s_l.id_show AND s_l.id_LugarGeo = l.id;

