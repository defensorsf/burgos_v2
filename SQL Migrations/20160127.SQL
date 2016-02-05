--CREO UNA FUNCION QUE PASADO UN EXPEDIENTE DEVUELVE LAS VICTIMAS
CREATE OR REPLACE FUNCTION victimas (expediente integer)
RETURNS text AS $$
declare
	rv  RECORD; --el registro para el loop
	cadena text;
BEGIN
	cadena = '' ;
	--id_rol =1 es victima. Hace un loop por todas las victimas del expediente
	FOR rv IN SELECT id_persona, id_rol  FROM roles_vinculos  WHERE id_expediente = expediente AND id_rol = 1 LOOP
		cadena = cadena || (SELECT nombre || ' ' ||apellido FROM personas WHERE id = rv.id_persona) || ' / ';
	END LOOP;
   RETURN left(cadena, -3);
END;
$$ LANGUAGE plpgsql;

--Busca los profesionales que estuvieron en la primera entrevista. 
CREATE OR REPLACE FUNCTION responsables (expediente integer)
RETURNS text AS $$
declare
	rv  RECORD;
	cadena text;
BEGIN
	cadena = '' ;
	FOR rv IN SELECT id_personal  FROM grupos_trabajos  WHERE id_expediente = expediente AND primera_entrevista LOOP
		cadena = cadena || (SELECT nombre || ' ' ||apellido FROM personal WHERE id = rv.id_personal) || ' / ';
	END LOOP;
   
   RETURN left(cadena, -3);
END;
$$ LANGUAGE plpgsql;