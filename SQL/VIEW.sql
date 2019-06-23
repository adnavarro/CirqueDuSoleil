
CREATE OR REPLACE VIEW shows_activos AS
SELECT id, nombre, tipo FROM public.CirqueShow WHERE estatus = TRUE;

CREATE OR REPLACE VIEW presentaciones_disponibles AS
SELECT DISTINCT p.id, s.id AS idShow, s.nombre, p.fecha 
FROM public.CirqueShow AS s, public.Presenta p, s_l
WHERE ((s.id = p.id_Show) OR (s.id = s_l.id_show AND s_l.id = p.id_SL)) AND p.estatus = FALSE;

CREATE OR REPLACE VIEW ciudades_show_itinerante AS 
SELECT s_l.id, c.id AS idshow, c.nombre, l.nombre AS lugar
FROM CirqueShow AS c, s_l, LugarGeo l
WHERE c.id = s_l.id_show AND s_l.id_LugarGeo = l.id;

