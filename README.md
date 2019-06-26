# CirqueDuSolei

Proyecto de bases 2

## Requisitos

1. [PostgreSQL](https://www.postgresql.org/)
2. [Python](https://www.python.org/downloads/)
3. [Django](https://docs.djangoproject.com/en/2.2/howto/windows/)
4. [Power BI](https://powerbi.microsoft.com/en-us/)

## Base de datos

1. Crear las tablas de [create.sql](./SQL/create.sql)
2. Insertar los datos de [insert.sql](./SQL/insert.sql)

### Nota:

Para visualizar las imagenes en Power Bi necesitas ejecutar en consola (en la carpeta mysite del proyecto):
```python manage.py runserver
```

## Lista de shows del para el proyecto

### ACTIVOS:
- [x] OVO 1 -- 1000
- [x] Amaluna 1001 -- 2000
- [x] Alegria 2001 -- 3000
- [x] Kurios 3001 -- 4000
- [x] Bazzar 5001 -- 6000
- [x] Volta 6001 -- 7000

### RETIRADOS:
- [x] IRIS (11-13) 4001 -- 5000
- [x] Nouvelle Experience (90-93) 7001 -- 8000
- [x] Delirium (06-08) 8001 -- 9000


## Reportes

- [x] Lista de shows
- [x] Detalle de show
- [x] Calendario de show
- [x] Historico de show
- [x] Ficha de artista
- [x] Audiciones
- [x] Detalle de audiciones
- [x] Entrada


## Procedimientos de optimizacion

### Insertar una presentación para un show

- [x] Ver lista de shows activos
- [x] Sugerir fecha itinerante (show)
- [x] Insertar presentacion de residente (show, fecha)
- [ ] Validar residentes con calendario semanal
- [ ] Validar residentes entre enero-julio o septiembre-diciembre
- [x] Ver lugares para itinerantes (show itinerante)
- [x] Validar fechas por distancia de ciudades (show itinerante)
- [x] Insertar presentacion de itinerante (show, lugar, fecha)
- [x] Generar calendario con rango de fechas, arreglo de horas y faltos de fecha

### Contratar un artista

- [x] Seleccionar audicion de lista de audiciones (disciplina, ciudad) 
- [x] Seleccionar participante de lista de participantes (audicion)
- [x] Marcar participante como aprovado (participante)
- [x] Copiar sus datos a los artistas (participante, apodo)
- [x] Validar edades de apirantes
- [ ] Validar edades de artistas

### Audiciones

- [x] Crear una audicion
- [x] Generar inscripciones para audiciones
- [ ] Validar disponibilidad

### Entradas

- [x] Vender entradas y aplicar descuento si corresponde
- [ ] Validar disponibilidad
- [ ] Cambiar valor de las entradas

### Otros procesos

- [ ] Asignar artistas a personajes y guardarlo en su historico
- [ ] Conversion monetaria :(
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
```
