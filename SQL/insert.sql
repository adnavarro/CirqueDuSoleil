

INSERT INTO public.cirqueshow VALUES
	(1, 'OVO', 'Itinerante', 'abc\\030',  
  	CAST(ARRAY [('Opening', 'El emocionante y ajetreado mundo está representado por la música de samba y las luces brillantes, luego una 		calma repentina, las luces brillantes cambian a luz natural cálida y la samba pesada se convierte en una canción de guitarra calmante'),
	('Malabarismo de Pies y Juegos Icarianos','un grupo de hormigas hacen malabares con kiwis, maíz, rebanadas de berenjena y otras		hormigas, todas en sus pies'),
	('Balance de Mano', 'Una libélula solitaria se balancea precariamente en un bloque alto y giratorio'),
	('Correas Aéreas', 'Las artistas vuelan sobre la audiencia suspendidas de cuerdas que cuelgan de un transportador con un elemento 		rotativo sobre sus cabezas. Es un vuelo en cuatro dimensiones que exige precisión además de las habilidades y la fuerza física 		necesarias para moverse a alta velocidad en 360 grados'),
	('Diábolo', ' una luciérnaga manipula y lanza múltiples diabolos a la vez'),
	('Creatura', 'Parte sinuosa, parte insecto, la Criatura danza en un tema que es todo suyo, el se curva, tuerce en nudos sus 		miembros elásticos en constante movimiento.'),
	('Marco Aéreo', 'Un hombre fuerte y una muñeca con cara de porcelana que despiertan por una descarga eléctrica emergen de su caja 		musical y cobran vida. Los dos artistas escalan a la cima del aparado de 4 metros de altura. En un número basado en la confianza mutua, 	el atrapador se convierte en un trapecio humano y lanza a su compañera en el aire donde realiza saltos mortales cada vez más 			intrincados'),
	('Contorsión', 'Una araña usa la misma cuerda vertical que las mariposas para crear múltiples posturas flexibles, mientras que otra en el suelo usa los apoyabrazos para mantener el equilibrio mientras la espalda y las piernas se retuercen en múltiples posiciones'),
	('Trío Acrobático', 'dos artistas varones usan técnicas similares a las de la gimnasia acrobática (acrosport) para lanzar al aire a una mujer'),
	('Slack Wire', 'En un cable suelto (y algunas veces en movimiento), una araña se balancea con sus piernas y manos, y en un punto monta un monociclo'),
	('Piernas', 'Un baile único, múltiples piernas emergen a través de agujeros en el escenario'),
	('Trampolín, Power Track y Muro', 'los grillos rebotan en un trampolín largo en el suelo llamado una vía de poder, realizan giros a una velocidad asombrosa. Los grillos también utilizan un trampolín para saltar a la pared, en la pared el salto y aterrizar en el trampolín'),
	('Banquete', 'El final del espectáculo')] AS ACTO[]),
  	CAST(ARRAY [('DEBORAH', 'COLKE','DIRECTOR'),
	('GRINGO', 'CARDIA','ESCENARIO'),('BERNA','CEPPAS','COMPOSITOR'),('LIZ','VANDAL','VESTUARIO')] AS DatosExtra[]),
  	ARRAY [ 'Brisa Do Mar','Extranjero','Hormigas','Capullo','Frevo Zumbido','Orvalho (balanceo de manos)','Carimbo da Creatura','Dueto de amor','Correas Duo','Scarabee','Cuna rusa','Sexy Web','Piernas','Chicas de pulgas','Acro trio','Superhéroe (Slackwire)','Secret Samba Luv','Parede (Muro)','Banquete (Banquete y Arcos)'],
	'Ovo es una producción de circo itinerante del Cirque du Soleil que se estrenó en Montreal , Canadá , en 2009. La creadora y directora de Ovo , Deborah Colker , se inspiró en el mundo de los insectos . La idea para Ovo no era ser sobre los actos, ni el baile, ni los insectos, sino sobre el movimiento. El movimiento de la vida impregna todo el espectáculo con criaturas que vuelan, saltan, saltan y se arrastran. La compositora Berna Ceppas le dio vida adicional a Ovo con una música inspirada en la música de Brasil . Ovo significa "huevo" en portuguésy representa el hilo subyacente a través del show. Gráficamente, dentro del logo de Ovo , hay un insecto. Las dos O representan los ojos y la V forma la nariz y las antenas.', null);

INSERT INTO public.personaje VALUES
	(1,'Maestro Flipo','El personaje principal, Master Flipo, mantiene todo en orden en este mundo caótico',1),
	(2,'La Mariquita','Es la tercera directora que trae vida y alegría al mundo de los insectos, y también termina enamorándose del extranjero',1),
	(3,'El Extranjero','El extranjero, otro personaje principal, es una mosca de una tierra lejana que trae consigo el misterioso ovo',1),
	(4,'La Libélula','La libélula revolotea a lo largo de toda la actuación y realiza el acto de equilibrio de la mano',1),
	(5,'Arañas','Cuatro arañas proporcionan misterio y precaución a lo largo del espectáculo',1),
	(6,'Pulgas','Tres pulgones saltan con destellos de rojo y amarillo mientras realizan acro-trío',1),
	(7,'Hormigas','Las hormigas llevan kiwi y maíz con ellos en su viaje mientras realizan malabares con el pie',1)
	(8,'Mariposas','El dúo las mariposas vuelan por el aire',1),
	(9,'La Luciérnaga','La luciérnaga revolotea acerca de actuar con diabolos',1),
	(10,'El Mosquito','El mosquito agrega carácter a la actuación al tiempo que forma parte del powertrack, el trampolín y el acto de pared',1),
	(11,'Escarabajos','Los escarabajos fuertes vuelan por el aire girando y girando',1),
	(12,'Grillos','Los 10 grillos saltan y saltan en rayas verdes como lo hacen la pista de aire, el trampolín y la pared',1),
	(13,'Creatura','Una misteriosa creatura le da vida a la fiesta con su baile',1),
	(14,'Cucarachas','Las 9 cucarachas se ven cantando y tocando música durante toda la actuación',1);

