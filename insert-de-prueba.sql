/*
  Los array de TDA necestian Castearse
*/

INSERT INTO public.cirqueshow VALUES(1, 
  'Amulana', 
  'Itinerante', 
  'abc\\030',  
  CAST(ARRAY [('Baile', 'Es donde bailan'),('lolololo','Es donde lololean')] AS ACTO[]),
  CAST(ARRAY [('ROMERO', 'JOSE','DIRECTOR'),('ALFONSO','NAVARRO','COMPOSITOR'),('JULIAN','URIBE','CEO')] AS DATOSDIRECTOR[]),
  ARRAY [ 'musica 1', 'musica 2' ],
  'Mi descripcion',
  null
);

INSERT INTO public.cirqueshow VALUES(2, 
  'Sancos de fuego', 
  'Residente', 
  'abc\\030',  
  CAST(ARRAY [('Baile', 'Es donde bailan'),('sadfasdfdsa','terwtfsdgdsfgdsfgsd')] AS ACTO[]),
  CAST(ARRAY [('Ramon', 'Perez','DIRECTOR'),('Pedro','NAVARRO','COMPOSITOR'),('Maria','URIBE','CEO')] AS DATOSDIRECTOR[]),
  ARRAY [ 'musica 1', 'musica 2' ],
  'Mi descripcion',
  null
);

INSERT INTO public.cirqueshow VALUES(3, 
  'Otro asdf', 
  'Itinerante', 
  'abc\\030',  
  CAST(ARRAY [('Bailesss', 'Es donde bailan'),('lolololox','Es donde lololean')] AS ACTO[]),
  CAST(ARRAY [('Coco', 'JOSE','DIRECTOR'),('Carlos','NAVARRO','COMPOSITOR'),('Jorge','URIBE','CEO')] AS DATOSDIRECTOR[]),
  ARRAY [ 'musica 1', 'musica 2' ],
  'Mi descripcion',
  null
);