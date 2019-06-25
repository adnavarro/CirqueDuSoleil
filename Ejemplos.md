# Ejemplos de uso de procedimientos almacenados

## Listas

### Listar shows activos
Muestra **id, nombre y tipo** de show si estan activos
```pgsql
SELECT * FROM listar_shows_activos();
```

### Listar presentaciones disponibles
Muestra **id, nombre y fecha** de show dado su **id** si el estatus es falso (no se han presentado)
```pgsql
SELECT * FROM listar_presentaciones_disponibles(2);
```

### Listar paises
Muestra **id, nombre y continente** de TODOS el mundo (de la base de datos)
```pgsql
SELECT * FROM listar_paises();
```
Muestra **id, nombre y continente** de un **continente**
```pgsql
SELECT * FROM listar_paises('EU');
SELECT * FROM listar_paises('America');
SELECT * FROM listar_paises('asia');
```

###  Listar ciudades
Muestra **id, nombre** de un pais dado su **id**
```pgsql
SELECT * FROM listar_ciudades(1);
```

## Insertar datos

### Insertar presentación
Ver los los id de los shows activos para seleccionar uno
```pgsql
SELECT * FROM listar_shows_activos();
```
#### Itinerante
Ver los paises y ciudades para seleccionar una
```pgsql
SELECT * FROM listar_paises('EU');
SELECT * FROM listar_ciudades(56);
```
Insertar una presentacion de **Amaluna** para el **20-10-2020 a las 20:00** en **Manchester**
```pgsql
CALL insertar_presentacion(2, '20-10-2020 20:00', 57);
```
Insertar una presentación de **Alegría** para el **10-10-2005 a las 16:30** en **Singapore** sin validar la fecha y permitir insertar en el pasado
```pgsql
CALL insertar_presentacion(3, '10-10-2005 16:30', 36, false);
```
#### Residente
*Nota: Faltan mejores validaciones para los residentes*
Insertar una presentación de **Bazzar** para el **10-10-2020 a las 18:30**
```pgsql
CALL insertar_presentacion(6, '10-10-2020 18:30');
```
Insertar una presentación de **Bazzar** para el **10-10-2005 a las 18:30** sin validar la fecha
```pgsql
CALL insertar_presentacion(6, '10-10-2005 18:30', null, false);
CALL insertar_presentacion(6, '10-10-2005 18:30', 0, false);
```

### Generar calendario
Al igual que un itinerante, quiero generar para **Kurios** en **Miami** de **10-06-2022** a **10-08-2022** a las **20:00** todos los días
```pgsql
CALL generar_calendario(4, 23, '10-06-2022', '10-08-2022', '20:00');
```
Al igual que un itinerante, quiero generar para **Kurios** en **Miami** de **10-06-2022** a **10-08-2022** a las **16:00** y **20:00** todos los días
```pgsql
CALL generar_calendario(4, 23, '10-06-2022', '10-08-2022', '16:00', '20:00');
```
Al igual que un itinerante, quiero generar para **Kurios** en **Miami** de **10-06-2022** a **10-08-2022** a las **16:00** y **20:00** cada **3 dias**
```pgsql
CALL generar_calendario(4, 23, '10-06-2022', '10-08-2022', '16:00', '20:00', 3);
```
Al igual que un itinerante, quiero generar para **Kurios** en **Miami** de **10-06-2022** a **10-08-2022** a las **16:00** cada **3 dias**
```pgsql
CALL generar_calendario(4, 23, '10-06-2022', '10-08-2022', '16:00', null, 3);
```

### Vender entradas
Ver shows activos
```pgsql
SELECT * FROM listar_shows_activos();
```
Ver proximas presentaciones de **Volta**
```pgsql
SELECT * FROM listar_presentaciones_disponibles(7);
```
Vender una entrada para **Volta el 03-08-2019** a **50** (x precio) una entrada tipo **A** para un **adulto**, **hoy**
```pgsql
CALL vender_entrada(6995, '50', 'A');
```
Vender una entrada para **Volta el 03-08-2019** a **50** (x precio) una entrada tipo **A** para un **niño**, **hoy** y **asociarlo a un adulto**
```pgsql
SELECT MAX(id) FROM entrada;
CALL vender_entrada(6995, '50', 'A', 'Menor',NOW(), 7986);
```
Vender una entrada para **Volta el 03-08-2019** a **50** (x precio) una entrada tipo **VIP** para un **tercera edad**, el **03-08-2019 16:00**
```pgsql
CALL vender_entrada(6995, '500', 'VIP', 'Tercera edad', '03-08-2019 16:00');
```

## Procedimientos de uso interno

```pgsql
validar_fechas_presentaciones(timestamp '20-10-2020 20:00', timestamp '20-10-2020 21:00', 1)
get_proxima_fecha(timestamp '20-10-2020 20:00', 2)
distancia_ciudades(19, 93)
```

## Procedimientos de desarrollo

```pgsql
CALL dev_llenar_entradas(400);
```