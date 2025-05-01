USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE update_rosette_ubication(
    IN p_rosette_ubication VARCHAR(30),
    IN p_owner_uuid CHAR(36),
    OUT p_message VARCHAR(100)
)
BEGIN
    UPDATE rosette
    SET rosette_ubication = p_rosette_ubication
    WHERE owner_uuid = p_owner_uuid;

    SET p_message = 'Ubicación de roseta actualizada exitosamente';
END $$

DELIMITER ;
