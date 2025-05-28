use lumitechDB;

DELIMITER $$

CREATE PROCEDURE get_rosettes_by_user(
    IN p_owner_uuid CHAR(36)
)
BEGIN
    SELECT 
        rosette_id,
        rosette_mac,
        rosette_ip,
        rosette_ubication,
        wifi_ssid,
        rosette_register_date
    FROM rosette
    WHERE owner_uuid = p_owner_uuid;
END $$

DELIMITER ;
