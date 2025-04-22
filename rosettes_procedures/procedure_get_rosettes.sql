/*
GET_ROSETTES
Este procedure se encarga de obtener la información de todas las rosetas
asociadas a el usuario en la sesión actual, tomando como base su UUID (el backend
toma el UUID del usuario desde la sesión actual).
De la tabla roseta obtenemos: rosette_mac, rosette_ubication y rosette_register_date
después de mezclar las tablas: rosette_user y rosette, usando el atributo de rosette_mac
de ambas tablas.

*/
USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE get_rosettes(
    IN p_user_uuid CHAR(36),
    OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE rosettes_count INT;

    SELECT 
        rosette.rosette_mac,
        rosette.rosette_ubication,
        rosette.rosette_register_date
    FROM rosette_user
    INNER JOIN rosette ON rosette_user.rosette_mac = rosette.rosette_mac
    WHERE rosette_user.uuid = p_user_uuid;

    -- Verificar cuántas rosetas hay asociadas
    SELECT COUNT(*) INTO rosettes_count
    FROM rosette_user
    WHERE uuid = p_user_uuid;

    IF rosettes_count > 0 THEN
        SET p_message = 'Rosetas encontradas exitosamente';
    ELSE
        SET p_message = 'No se encontraron rosetas asociadas al usuario';
    END IF;
END $$

DELIMITER ;
