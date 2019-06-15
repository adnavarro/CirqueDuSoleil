# KURIOS PRESENTACIONES

"""
  Referencia a insert-lugar-sl-prenseta-kurios.sql

  - Todos los shows se insertan a las 8 (No es un requeriimiento)
  - Los id del final corresponden al lugar de presentacion
  - El codigo es repetitvo (while), son los dias de inicio, fin y el lugar

"""

from random import random

def siguiente_dia(dia, mes, ano):
  dia += 2 if random() > 0.5 else 3  # Dos o tes veces a la semana
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

archivo = open('kurios-presentaciones.txt', 'w+')

i = 1001

archivo.write("-- 2015\n")

# Seattle, WA - From 29 Jan to 22 Mar 2015
archivo.write("-- Seattle, WA - From 29 Jan to 22 Mar 2015\n")
dia = 29
mes = 1
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 3 or (mes == 3 and dia >= 22):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,1),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# Calgary, AB - From 9 Apr to 24 May 2015
archivo.write("-- Calgary, AB - From 9 Apr to 24 May 2015\n")
dia = 9
mes = 4
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 5 or (mes == 5 and dia >= 24):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,2),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Denver, CO - From 11 Jun to 26 Jul 2015
archivo.write("-- Denver, CO - From 11 Jun to 26 Jul 2015\n")
dia = 11
mes = 6
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 7 or (mes == 7 and dia >= 26):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,3),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Chicago, IL - From 6 Aug to 30 Sep 2015
archivo.write("-- Chicago, IL - From 6 Aug to 30 Sep 2015\n")
dia = 6
mes = 8
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 9 or (mes == 9 and dia >= 30):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,4),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Costa Mesa, CA - From 15 Oct to 29 Nov 2015
archivo.write("-- Costa Mesa, CA - From 15 Oct to 29 Nov 2015\n")
dia = 15
mes = 10
ano = 2015
while i < 20000:
  if ano > 2015 or mes > 11 or (mes == 11 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,5),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Los Angeles, CA - From 10 Dec 2015 to 7 Feb 2016
archivo.write("-- Los Angeles, CA - From 10 Dec 2015 to 7 Feb 2016\n")
dia = 10
mes = 12
ano = 2015
while i < 20000:
  if ano > 2016 or (ano == 2016 and mes > 2) or (mes == 2 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,6),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2016\n")

# Atlanta, GA - From 3 Mar to 8 May 2016
archivo.write("-- Atlanta, GA - From 3 Mar to 8 May 2016\n")
dia = 3
mes = 3
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 5 or (mes == 5 and dia >= 8):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,7),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Boston, MA - From 26 May to 10 Jul 2016
archivo.write("-- Boston, MA - From 26 May to 10 Jul 2016\n")
dia = 26
mes = 5
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 7 or (mes == 7 and dia >= 10):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,8),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Washington, DC - From 21 Jul to 18 Sep 2016
archivo.write("-- Washington, DC - From 21 Jul to 18 Sep 2016\n")
dia = 21
mes = 7
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 9 or (mes == 9 and dia >= 18):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,9),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# New York, NY - From 30 Sep to 27 Nov 2016
archivo.write("-- New York, NY - From 30 Sep to 27 Nov 2016\n")
dia = 30
mes = 9
ano = 2016
while i < 20000:
  if ano > 2016 or mes > 11 or (mes == 11 and dia >= 27):
    break
  archivo.write(
      "({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,10),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# Miami, FL - From 9 Dec 2016 to 29 Jan 2017
archivo.write("-- Miami, FL - From 9 Dec 2016 to 29 Jan 2017\n")
dia = 9
mes = 12
ano = 2016
while i < 20000:
  if ano > 2017 or (ano == 2017 and mes > 1) or (mes == 1 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,11),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2017\n")


# Dallas, TX - From 17 Feb to 26 Mar 2017
archivo.write("-- Dallas, TX - From 17 Feb to 26 Mar 2017\n")
dia = 17
mes = 2
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 3 or (mes == 3 and dia >= 26):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,12),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Houston, TX - From 6 Apr to 21 May 2017
archivo.write("-- Houston, TX - From 6 Apr to 21 May 2017\n")
dia = 6
mes = 4
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 5 or (mes == 5 and dia >= 21):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,13),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Winnipeg, MB - From 2 Jun to 9 Jul 2017
archivo.write("-- Winnipeg, MB - From 2 Jun to 9 Jul 2017\n")
dia = 2
mes = 6
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 7 or (mes == 7 and dia >= 9):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,14),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# Edmonton, AB - From 20 Jul to 13 Aug 2017
archivo.write("-- Edmonton, AB - From 20 Jul to 13 Aug 2017\n")
dia = 20
mes = 7
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 8 or (mes == 8 and dia >= 13):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,15),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# Portland, OR - From 28 Aug to 8 Oct 2017
archivo.write("-- Portland, OR - From 28 Aug to 8 Oct 2017\n")
dia = 28
mes = 8
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 10 or (mes == 10 and dia >= 8):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,16),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  

# Vancouver, BC - From 19 Oct to 31 Dec 2017
archivo.write("-- Vancouver, BC - From 19 Oct to 31 Dec 2017\n")
dia = 19
mes = 10
ano = 2017
while i < 20000:
  if ano > 2017 or mes > 12 or (mes == 12 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,17),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  
archivo.write("-- 2018\n")

# Tokyo, JP - From 7 Feb to 8 Jul 2018
archivo.write("-- Tokyo, JP - From 7 Feb to 8 Jul 2018\n")
dia = 7
mes = 2
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 7 or (mes == 7 and dia >= 8):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,18),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Osaka, JP - From 26 Jul to 4 Nov 2018
archivo.write("-- Osaka, JP - From 26 Jul to 4 Nov 2018\n")
dia = 26
mes = 7
ano = 2018
while i < 20000:
  if ano > 2018 or mes > 11 or (mes == 11 and dia >= 4):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,19),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Nagoya, JP - From 22 Nov 2018 to 27 Jan 2019
archivo.write("-- Nagoya, JP - From 22 Nov 2018 to 27 Jan 2019\n")
dia = 22
mes = 11
ano = 2018
while i < 20000:
  if ano > 2019 or (ano == 2019 and mes > 1) or (mes == 1 and dia >= 27):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,20),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1
  
archivo.write("-- 2019\n")

# Fukuoka, JP - From 15 Feb to 31 Mar 2019
archivo.write("-- Fukuoka, JP - From 15 Feb to 31 Mar 2019\n")
dia = 15
mes = 2
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 3 or (mes == 3 and dia >= 31):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,21),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Sendai, JP - From 18 Apr to 29 May 2019
archivo.write("-- Sendai, JP - From 18 Apr to 29 May 2019\n")
dia = 18
mes = 4
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 5 or (mes == 5 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',TRUE,null,null,22),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- Proximos eventos\n")

# Singapore, SG - From 5 Jul to 18 Aug 2019
archivo.write("-- Singapore, SG - From 5 Jul to 18 Aug 2019\n")
dia = 5
mes = 7
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 8 or (mes == 8 and dia >= 18):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,null,23),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Sydney, AU – From 2 Oct to 3 Nov 2019
archivo.write("-- Sydney, AU - From 2 Oct to 3 Nov 2019\n")
dia = 2
mes = 10
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 11 or (mes == 11 and dia >= 3):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,null,24),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1

archivo.write("-- 2020\n")


# Brisbane, AU – From 10 Jan to 26 Jan 2020
archivo.write("-- Brisbane, AU - From 10 Jan to 26 Jan 2020\n")
dia = 10
mes = 1
ano = 2020
while i < 20000:
  if ano > 2020 or mes > 1 or (mes == 1 and dia >= 26):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,null,25),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


# Melbourne, AU – From 12 Mar to 29 Mar 2020
archivo.write("-- Melbourne, AU - From 12 Mar to 29 Mar 2020\n")
dia = 12
mes = 3
ano = 2019
while i < 20000:
  if ano > 2019 or mes > 3 or (mes == 3 and dia >= 29):
    break
  archivo.write("({:d},'{:02d}-{:02d}-{:d} 20:00:00',FALSE,null,null,26),\n".format(i, dia, mes, ano))
  dia, mes, ano = siguiente_dia(dia, mes, ano)
  i += 1


archivo.close()