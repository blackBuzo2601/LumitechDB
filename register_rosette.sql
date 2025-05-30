USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE register_rosette(
    IN p_rosette_mac VARCHAR(17),
    IN p_rosette_ip VARCHAR(45),
    IN p_wifi_ssid VARCHAR(50),
    IN p_wifi_password VARCHAR(60),
    IN p_owner_uuid CHAR(36),
    OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE rosette_exists INT;
    DECLARE p_rosette_ubication VARCHAR(30);

    -- Verificar si la roseta ya está registrada
    SELECT COUNT(*) INTO rosette_exists
    FROM rosette
    WHERE rosette_mac = p_rosette_mac;

    IF rosette_exists > 0 THEN
        SET p_message = 'Esta roseta ya está registrada';
    ELSE
		SET p_rosette_ubication = 'Ubicacion Pendiente';
        -- Insertar en tabla rosette con nuevos campos
        INSERT INTO rosette (
            rosette_ubication,
            rosette_register_date,
            rosette_mac,
            rosette_ip,
            wifi_ssid,
            wifi_password,
            owner_uuid
        )
        VALUES (
            p_rosette_ubication, 
            NOW(),
            p_rosette_mac,
            p_rosette_ip,
            p_wifi_ssid,
            p_wifi_password,
            p_owner_uuid
        );

        -- Asociar la roseta al usuario
        INSERT INTO rosette_user (uuid, rosette_mac)
        VALUES (p_owner_uuid, p_rosette_mac);

        SET p_message = 'Roseta registrada y asociada exitosamente';
    END IF;
END $$

DELIMITER ;
