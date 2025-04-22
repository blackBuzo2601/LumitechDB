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

CREATE PROCEDURE register_rosette(
    IN p_rosette_ubication VARCHAR(30),
    IN p_rosette_mac VARCHAR(17),
    IN p_owner_uuid CHAR(36),
    OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE rosette_exists INT;

    -- Verificar si la roseta ya está registrada
    SELECT COUNT(*) INTO rosette_exists
    FROM rosette
    WHERE rosette_mac = p_rosette_mac;

    IF rosette_exists > 0 THEN
        SET p_message = 'Esta roseta ya está registrada';
    ELSE
        -- Insertar en tabla rosette
        INSERT INTO rosette (
            rosette_ubication,
            rosette_register_date,
            rosette_mac,
            owner_uuid
        )
        VALUES (
            p_rosette_ubication,
            NOW(),
            p_rosette_mac,
            p_owner_uuid
        );

        -- Asociar la roseta al usuario
        INSERT INTO rosette_user (uuid, rosette_mac)
        VALUES (p_owner_uuid, p_rosette_mac);

        SET p_message = 'Roseta registrada y asociada exitosamente';
    END IF;
END $$

DELIMITER ;
