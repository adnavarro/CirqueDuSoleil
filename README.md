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
- [ ] OVO 1 -- 1000
- [ ] Amaluna 1001 -- 2000
- [ ] Alegria 2001 -- 3000
- [ ] Kurios 3001 -- 4000
- [ ] Bazzar 5001 -- 6000
- [ ] Volta 6001 -- 7000

### RETIRADOS:
- [ ] IRIS (11-13) 4001 -- 5000
- [ ] Nouvelle Experience (90-93) 7001 -- 8000
- [ ] Delirium (06-08) 8001 -- 9000


## Procedimientos de optimizacion

### Insertar una presentación para un show

- [ ] Seleccionar un show de la lista de shows ( )
 - 

### Contratar un artista

- [ ] Seleccionar audicion de lista de audiciones (disciplina, fechas) 
  - [ ] Seleccionar participante de lista de participantes (audicion)
    - [ ] Marcar participante como aprovado (participante)
    - [x] Copiar sus datos a los artistas (participante, apodo)

### Otros procesos

- [ ] Vender entradas
- [ ] Crear una audicion
- [ ] Cambiar valor de las entradas
- [ ] Registrar datos de forma bonita
- [ ] 