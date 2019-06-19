-- Views requeridad para hacer los reportes

CREATE VIEW presen AS 
SELECT c.id as id_show, p.id as id_presen, c.nombre, p.fecha
FROM cirqueshow c
JOIN s_l
ON s_l.id_show = c.id
JOIN presenta p
ON p.id_sl = s_l.id
WHERE c.id = 1
