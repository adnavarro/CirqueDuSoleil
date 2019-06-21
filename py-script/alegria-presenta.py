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

archivo = open('alegria-presentaciones.txt', 'w+')

i = 2001

archivo.write("-- 2012\n")


archivo.write("--London From 19 May to 14 Jul 2012\n")
dia = 19
mes = 5
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 7 or (mes == 7 and dia >= 14):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,80,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Milan QC From 25 agos to 19 sep 2012\n")
dia = 25
mes = 8
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 9 or (mes == 9 and dia >= 19):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,81,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Roma - From 7 Oct to 4 Dec 2012\n")
dia = 7
mes = 10
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 12 or (mes == 12 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,82,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Amsterdam - From 12 Dec 2012 to 25 Dec 2012\n")
dia = 12
mes = 12
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 12 or (mes == 12 and dia >= 25):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,83,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2013\n")


archivo.write("--Bruselas - From 1 Jan to 24 Feb 2013\n")
dia = 1
mes = 1
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 2 or (mes == 2 and dia >= 24):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,84,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Madrid - From 4 Mar to 19 April 2013\n")
dia = 4
mes = 3
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 4 or (mes == 4 and dia >= 19):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,85,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--London - From 29 April to 23 May 2013\n")
dia = 29
mes = 4
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 5 or (mes == 5 and dia >= 23):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,80,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Barcelona - From 18 Jun to 25 Jul 2013\n")
dia = 18
mes = 6
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 7 or (mes == 7 and dia >= 25):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,86,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Paris - From 26 Ago to 20 Sep 2013\n")
dia = 26
mes = 8
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 9 or (mes == 9 and dia >= 20):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,87,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Gijon - From 13 Oct 2013 to 24 Oct 2013\n")
dia = 13
mes = 10
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 10 or (mes == 10 and dia >= 24):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,88,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Curitiba - From 29 Oct 2013 to 12 Nov 2013\n")
dia = 29
mes = 10
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 11 or (mes == 11 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,89,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2014\n")

archivo.write("--Brasilia - From 22 Jan to 2 Feb 2014\n")
dia = 22
mes = 1
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 2 or (mes == 2 and dia >= 2):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,90,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Belo Horizonte- From 20 Feb to 18 Mar 2014\n")
dia = 20
mes = 2
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 3 or (mes == 3 and dia >= 18):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,91,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Rio de Janeiro - From 29 Apr to 6 May 2014\n")
dia = 29
mes = 4
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 5 or (mes == 5 and dia >= 6):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,92,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Sao Paulo - From 30 May to 10 Jun 2014\n")
dia = 30
mes = 5
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 6 or (mes == 6 and dia >= 10):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,93,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Porto Alegre - From 3 Oct to 30 Nov 2014\n")
dia = 3
mes = 10
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 11 or (mes == 11 and dia >= 30):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,94,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Buenos Aires- From 01 Dec 2014 to 10 Dec 2014\n")
dia = 1
mes = 12
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 12 or (mes == 12 and dia >= 10):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,95,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("-- 2015\n")


archivo.write("--Santiago- From 1 Jan to 22 Jan 2015\n")
dia = 1
mes = 1
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 1 or (mes == 1 and dia >= 22):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,96,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  


archivo.write("--Seoul- From 6 Marc to 21 Apr 2015\n")
dia = 6
mes = 3
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 4 or (mes == 4 and dia >= 21):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,97,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("--Taipei - From 3 Jun to 23 Jul 2015\n")
dia = 3
mes = 6
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 7 or (mes == 7 and dia >= 23):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,98,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Dubai - From 10 Oct to 25 Nov 2015\n")
dia = 10
mes = 10
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 11 or (mes == 11 and dia >= 25):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,99,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.close()
