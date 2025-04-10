/*
REGISTER_ROSETTE
Este procedure se encarga de registrar la roseta del usuario, recibiendo como
parametros el nombre que el usuario quiere asignar a su roseta, la dirección
MAC de la roseta y el UUID del usuario que está registradno esa roseta.
Al registrar la roseta, en la tabla rosette_user tambine se hace
la inserción del UUID y de la MAC, reforzando así la seguridad para que solo el usuario
con el UUID especificado pueda manipular su roseta
*/


USE lumitechDB;

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