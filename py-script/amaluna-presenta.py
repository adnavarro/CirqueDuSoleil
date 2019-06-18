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

archivo = open('amaluna-presentaciones.txt', 'w+')

i = 1001

archivo.write("-- 2012\n")

#jaja
archivo.write("--Montreal, QC From 19 Apr to 15 Jul 2012\n")
dia = 19
mes = 4
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 7 or (mes == 7 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,37,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Quebec, QC From 25 jul to 19 agos 2012\n")
dia = 25
mes = 7
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 8 or (mes == 8 and dia >= 19):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,38,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Toronto, ON - From 7 Sep to 4 Nov 2012\n")
dia = 7
mes = 9
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 11 or (mes == 11 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,39,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Vancouver, BC - From 23 Nov 2012 to 20 Dec 2013\n")
dia = 23
mes = 11
ano = 2012
while i < 20000:
  if ano > 2012 or mes > 12 or (mes == 12 and dia >= 20):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,40,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2013\n")


archivo.write("--Seattle, WA - From 31 Jan to 24 Mar 2013\n")
dia = 31
mes = 1
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 3 or (mes == 3 and dia >= 24):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,41,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Calgary, AB - From 10 Apr to 19 May 2013\n")
dia = 10
mes = 4
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 5 or (mes == 5 and dia >= 19):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,42,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Edmonton, AB - From 29 May to 23 Jun 2013\n")
dia = 29
mes = 5
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 6 or (mes == 6 and dia >= 23):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,43,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Denver, CO - From 18 Jul to 25 Aug 2013\n")
dia = 18
mes = 7
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 8 or (mes == 8 and dia >= 18):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,44,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Minneapolis, MN - From 26 Sep to 20 Oct 2013\n")
dia = 26
mes = 9
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 10 or (mes == 10 and dia >= 20):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,45,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--San Francisco, CA - From 13 Nov 2013 to 12 Dec 2014\n")
dia = 13
mes = 11
ano = 2013
while i < 20000:
  if ano > 2013 or mes > 12 or (mes == 12 and dia >= 12):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,46,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2014\n")

archivo.write("--San Jose, CA - From 22 Jan to 2 Mar 2014\n")
dia = 22
mes = 1
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 3 or (mes == 3 and dia >= 2):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,47,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--New York, NY - From 20 Mar to 18 May 2014\n")
dia = 20
mes = 3
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 5 or (mes == 5 and dia >= 18):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,48,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Boston, MA - From 29 May to 6 Jul 2014\n")
dia = 29
mes = 5
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 7 or (mes == 7 and dia >= 6):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,49,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Washington, DC - From 31 Jul to 10 Sep 2014\n")
dia = 31
mes = 7
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 9 or (mes == 9 and dia >= 10):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,50,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Atlanta, GA - From 3 Oct to 30 Nov 2014\n")
dia = 3
mes = 10
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 11 or (mes == 11 and dia >= 30):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,51,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Miami, FL- From 11 Dec 2014 to 19 Dec 2014\n")
dia = 11
mes = 12
ano = 2014
while i < 20000:
  if ano > 2014 or mes > 12 or (mes == 12 and dia >= 19):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,52,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("-- 2015\n")


archivo.write("--Houston, TX - From 11 Feb to 22 Mar 2015\n")
dia = 11
mes = 2
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 3 or (mes == 3 and dia >= 22):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,53,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  


archivo.write("--Madrid, ES - From 6 May to 21 Jun 2015\n")
dia = 6
mes = 5
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 6 or (mes == 6 and dia >= 21):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,54,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("--PortAventura World, ES - From 3 Jul to 23 Aug 2015\n")
dia = 3
mes = 7
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 8 or (mes == 8 and dia >= 23):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,55,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Brussels, BE - From 10 Sep to 25 Oct 2015\n")
dia = 10
mes = 9
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 10 or (mes == 10 and dia >= 25):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,56,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Paris, FR - From 5 Nov 2015 to 31 Dec 2015\n")
dia = 5
mes = 11
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 12 or (mes == 12 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,57,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("-- 2016\n")

archivo.write("--Amsterdam, NL - From 17 Mar to 1 May 2016\n")
dia = 17
mes = 3
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 5 or (mes == 5 and dia >= 1):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,58,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1



archivo.write("--Frankfurt, DE - From 12 May to 12 Jun 2016\n")
dia = 12
mes = 5
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 6 or (mes == 6 and dia >= 12):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,59,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1



archivo.write("--Knokke-Heist, BE - From 14 Jul 2016 to 21 Aug 2016\n")
dia = 14
mes = 7
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 8 or (mes == 8 and dia >= 21):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,60,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  


archivo.write("--Manchester, UK - From 7 Sep to 2 Oct 2016\n")
dia = 7
mes = 9
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 10 or (mes == 10 and dia >= 2):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,61,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

archivo.write("--Dusseldorf, DE - From 11 Nov to 28 Dec 2016\n")
dia = 11
mes = 11
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 12 or (mes == 12 and dia >= 28):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,62,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2017\n")


archivo.write("--Vienna, AT - From 9 Mar to 17 Apr 2017\n")
dia = 9
mes = 3
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 4 or (mes == 4 and dia >= 17):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,63,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("--Rome, IT - From 30 Apr to 11 Jun 2017\n")
dia = 30
mes = 4
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 6 or (mes == 6 and dia >= 11):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,64,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Asuncion, PY - From 26 Jul 2017 to 13 Aug 2017\n")
dia = 26
mes = 7
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 8 or (mes == 8 and dia >= 13):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,65,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

archivo.write("--Montevideo, UY - From 30 Aug 2017 to 15 Sep 2017\n")
dia = 30
mes = 8
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 9 or (mes == 9 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,66,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

archivo.write("--Sao Paulo, BR - From 5 Oct 2017 to 17 Dec 2017\n")
dia = 5
mes = 10
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 12 or (mes == 12 and dia >= 17):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,67,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  
archivo.write("--Rio de Janeiro, BR - From 28 Dec 2017 to 31 Dec 2017\n")
dia = 28
mes = 12
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 12 or (mes == 12 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,68,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  
archivo.write("-- 2018\n")

archivo.write("--Rosario, AR - From 14 Feb to 4 Mar 2018\n")
dia = 14
mes = 2
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 3 or (mes == 3 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,69,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Buenos Aires, AR - From 15 Mar to 15 Apr 2018\n")
dia = 15
mes = 3
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 4 or (mes == 4 and dia >= 15):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,70,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Cordoba, AR - From 26 Apr to 13 May 2018\n")
dia = 26
mes = 4
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 5 or (mes == 5 and dia >= 13):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,71,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Santiago, CL - From 31 May to 1 Jul 2018\n")
dia = 31
mes = 5
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 7 or (mes == 7 and dia >= 1):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,72,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Quito, EC - From 6 Sep to 30 Sep 2018\n")
dia = 6
mes = 9
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 9 or (mes == 9 and dia >= 30):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,73,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Bogota, CO - From 26 Oct to 16 Dec 2018\n")
dia = 26
mes = 10
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 12 or (mes == 12 and dia >= 16):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,74,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  
  
archivo.write("-- 2019\n")

archivo.write("--Dallas, TX - From 23 Jan to 3 Mar 2019\n")
dia = 23
mes = 1
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 3 or (mes == 3 and dia >= 3):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,75,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- Phoenix, AZ - From 15 Mar to 14 Apr 2019\n")
dia = 15
mes = 3
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 4 or (mes == 4 and dia >= 14):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,76,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("--Los Angeles, CA - From 25 Apr to 9 Jun 2019\n")
dia = 25
mes = 4
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 6 or (mes == 6 and dia >= 9):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,77,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1



archivo.write("--Oaks, PA - From 24 Jul to 25 Aug 2019\n")
dia = 24
mes = 7
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 8 or (mes == 8 and dia >= 25):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,78,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.write("--Winnipeg, MB - From 14 Sep to 20 Oct 2019\n")
dia = 14
mes = 9
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 10 or (mes == 10 and dia >= 20):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,79,null),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.close()
