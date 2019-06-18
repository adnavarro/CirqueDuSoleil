# KURIOS PRESENTACIONES

"""
  Referencia a insert-lugar-sl-prenseta-kurios.sql

  - Todos los shows se insertan a las 8 (No es un requeriimiento)
  - Los id del final corresponden al lugar de presentacion
  - El codigo es repetitvo (while), son los dias de inicio, fin y el lugar

"""

from random import random

def siguiente_dia(dia, mes, ano):
  dia += 2 if random() > 0.6 else 3  # Dos o tes veces a la semana
  if mes == 1 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 2 and dia >= 28:
    dia = 1
    mes += 1
  elif mes == 3 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 4 and dia >= 30:
    dia = 1
    mes += 1
  elif mes == 5 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 6 and dia >= 30:
    dia = 1
    mes += 1
  elif mes == 7 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 8 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 9 and dia >= 30:
    dia = 1
    mes += 1
  elif mes == 10 and dia >= 31:
    dia = 1
    mes += 1
  elif mes == 11 and dia >= 30:
    dia = 1
    mes += 1
  elif mes == 12 and dia >= 31:
    dia = 1
    mes = 1
    ano += 1
  return dia, mes, ano

archivo = open('bazzar-presentaciones.txt', 'w+')

i = 5001

archivo.write("-- 2008\n")

dia = 14
mes = 11
ano = 2008
while i < 20000:
  if ano > 2008 or mes > 12 or (mes == 12 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2009\n")

dia = 5
mes = 9
ano = 2009
while i < 20000:
  if ano > 2009 or mes > 12 or (mes == 12 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2010\n")

dia = 5
mes = 4
ano = 2010
while i < 20000:
  if ano > 2010 or mes > 11 or (mes == 11 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2011\n")

dia = 5
mes = 4
ano = 2011
while i < 20000:
  if ano > 2011 or mes > 11 or (mes == 11 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2012\n")

dia = 5
mes = 4
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 10 or (mes == 10 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2013\n")

dia = 5
mes = 6
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 10 or (mes == 10 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2014\n")

dia = 5
mes = 6
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 10 or (mes == 10 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2015\n")

dia = 10
mes = 8
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 11 or (mes == 11 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2016\n")

dia = 10
mes = 8
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 11 or (mes == 11 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2017\n")

dia = 10
mes = 8
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 11 or (mes == 11 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2018\n")

dia = 10
mes = 8
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 11 or (mes == 11 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2019\n")

dia = 1
mes = 1
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 12 or (mes == 12 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,6,null,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.close()
