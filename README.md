# CirqueDuSolei

Proyecto de bases 2

## Requisitos

1. [PostgreSQL](https://www.postgresql.org/)
2. [node.js](https://nodejs.org/en/)
3. [http-server](https://www.npmjs.com/package/http-server) *globalmente con npm*
4. [Power BI](https://powerbi.microsoft.com/en-us/)

## Base de datos

1. Crear las tablas de [create.sql](./SQL/create.sql)
2. Insertar los datos de [insert.sql](./SQL/insert.sql)

### Nota:

Para visualizar las imagenes en Power Bi necesitas ejecutar el servidor local en esta ruta
```sh
http-serve
```

## Lista de shows del para el proyecto

### ACTIVOS:
- [x] OVO 1 -- 1000
- [x] Amaluna 1001 -- 2000
- [x] Alegria 2001 -- 3000
- [x] Kurios 3001 -- 4000
- [x] Bazzar 5001 -- 6000
- [ ] Volta 6001 -- 7000

### RETIRADOS:
- [ ] IRIS (11-13) 4001 -- 5000
- [ ] Nouvelle Experience (90-93) 7001 -- 8000
- [ ] Delirium (06-08) 8001 -- 9000


## Reportes

- [x] Lista de shows
- [x] Detalle de show
- [x] Calendario de show
- [x] Historico de show
- [ ] Ficha de artista
- [x] Audiciones
- [ ] Detalle de audiciones
- [ ] Detalle de audiciones
- [ ] Detalle de audiciones
- [ ] Entrada


## Procedimientos de optimizacion

### Insertar una presentación para un show

- [x] Ver lista de shows activos
- [x] Sugerir fecha itinerante (show)
- [x] Insertar presentacion de residente (show, fecha)
- [ ] Validar residentes con calendario semanal
- [x] Ver lugares para itinerantes (show itinerante)
- [x] Validar fechas por distancia de ciudades (show itinerante)
- [x] Insertar presentacion de itinerante (show, lugar, fecha)
- [x] Generar calendario con rango de fechas, arreglo de horas y faltos de fecha

### Contratar un artista

- [x] Seleccionar audicion de lista de audiciones (disciplina, ciudad) 
- [x] Seleccionar participante de lista de participantes (audicion)
- [x] Marcar participante como aprovado (participante)
- [x] Copiar sus datos a los artistas (participante, apodo)

### Otros procesos

- [x] Vender entradas
- [ ] Validar disponibilidad
- [ ] Asignar artistas a personajes
- [ ] Crear una audicion
- [ ] Generar inscripciones para audiciones
- [ ] Cambiar valor de las entradas
- [ ] Registrar datos de forma bonita

## Comandos de consola (pgsql)

Nota: Pongo los archivos directamente en el disco C porque windows no queria agarrarlo en otro lado
Nota2: El encoding se lo pongo al principio porque windows no queria funcionar, si sus SO coopera no hace falta

```pgsql
\encoding UTF8
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
\i C:/CirqueDuSoleil/create.sql;
\i C:/CirqueDuSoleil/triggers.sql;
\i C:/CirqueDuSoleil/functions.sql;
\i C:/CirqueDuSoleil/insert.sql;
\i C:/CirqueDuSoleil/insert-aspirantes.sql;
\i C:/CirqueDuSoleil/insert-artistas.sql;
\i C:/CirqueDuSoleil/insert-A_H-D_A-A_A-Audiciones-Historial.sql;
\i C:/CirqueDuSoleil/VIEW.sql;
```
