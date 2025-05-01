USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE update_rosette_credentials(
    IN p_wifi_ssid VARCHAR(50),
    IN p_wifi_password VARCHAR(60),
    IN p_owner_uuid CHAR(36),
    OUT p_message VARCHAR(100)
)
BEGIN
    UPDATE rosette
    SET wifi_ssid = p_wifi_ssid,
        wifi_password = p_wifi_password
    WHERE owner_uuid = p_owner_uuid;

    SET p_message = 'Datos Wi-Fi actualizados exitosamente';
END $$

DELIMITER ;
