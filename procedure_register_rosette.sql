USE lumitech_beta;

DELIMITER $$

-- parametros que recibe el procedure
CREATE PROCEDURE register_rosette(
    IN p_rosette_ubication VARCHAR(30),
    IN p_rosette_mac VARCHAR(17),
    IN p_owner_uuid CHAR(36)
)
BEGIN
    -- campos originales de la tabla rosette
    INSERT INTO rosette (
        rosette_ubication,
        rosette_register_date,
        rosette_mac,
        owner_uuid
    )
    -- argumentos recibidos
    VALUES (
        p_rosette_ubication,
        NOW(),  -- Fecha actual
        p_rosette_mac,
        p_owner_uuid
    );

-- Insertar relacion de uuid y mac en rosette_user para asociar cada roseta a un usuario
    INSERT INTO rosette_user (uuid, rosette_mac)
    VALUES (p_owner_uuid, p_rosette_mac);


END $$

DELIMITER ;