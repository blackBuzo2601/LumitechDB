USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE change_rosette_ubication(
    IN p_rosette_ubication VARCHAR(30),
    IN p_owner_uuid CHAR(36),
    IN p_rosette_mac VARCHAR(17), 
    OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE rosetta_count INT;

    -- Validar si existe la roseta con ese owner y mac
    SELECT COUNT(*) INTO rosetta_count
    FROM rosette
    WHERE owner_uuid = p_owner_uuid AND rosette_mac = p_rosette_mac;

    IF rosetta_count = 0 THEN
        SET p_message = 'No se encontró una roseta con esos datos.';
    ELSE
        UPDATE rosette
        SET rosette_ubication = p_rosette_ubication
        WHERE owner_uuid = p_owner_uuid AND rosette_mac = p_rosette_mac;

        SET p_message = 'Ubicación de roseta actualizada exitosamente';
    END IF;
END $$

DELIMITER ;
