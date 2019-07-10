# CirqueDuSolei

Proyecto de Sistemas de Bases de Datos II

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
```
python manage.py runserver
```

## DataMart

- [x] top3 espectáculos por país y continente según total de asistentes (año, semestre);
  - [x] por pais
    - [x] año 
    - [x] semestre
  - [x] por continente
    - [x] año
    - [x] semestre
- [x] top3 espectáculos según ingresos generados (año, bienio);
  - [x] año
  - [x] bienio
- [ ] espectáculo por tipo(itinerante, residente) con mayor crecimiento (asistentes) anual
  - [ ] itinerante
  - [ ] residente


- [ ] % de audiciones con resultados positivos por semestre (aquellas audiciones en las que la compañía logró captar los artistas requeridos); 
- [x] crecimiento anual por disiciplina (aspirantes inscritos en audiciones de un año vs el año anterior).




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


```pgsql
CALL dev_llenar_entradas(101);
\i C:/CirqueDuSoleil/transicion.sql;
\i C:/CirqueDuSoleil/datamart.sql;

```