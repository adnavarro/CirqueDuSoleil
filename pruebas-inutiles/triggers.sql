CREATE FUNCTION insert_update_lugargeo() RETURNS trigger AS $insert_update_lugargeo$
    BEGIN
        -- Solo para los paises
        IF NEW.tipo_geo = 'P' THEN
			IF NEW.idiomas IS NULL THEN
				RAISE EXCEPTION 'Necesitas agregarle los idiomas al pais';
        	END IF;
			IF NEW.moneda IS NULL THEN
				RAISE EXCEPTION 'Necesitas declarar la moneda del pais';
        	END IF;
			IF NEW.contine IS NULL THEN
				RAISE EXCEPTION 'Necesitas declarar el continente al que pertenece el pais';
        	END IF;
        END IF;

        RETURN NEW;
    END;
$insert_update_lugargeo$ LANGUAGE plpgsql;

CREATE TRIGGER insert_update_lugargeo BEFORE INSERT OR UPDATE ON lugargeo
    FOR EACH ROW EXECUTE FUNCTION insert_update_lugargeo();