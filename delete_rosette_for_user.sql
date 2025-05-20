use lumitechDB;

DELIMITER $$

CREATE PROCEDURE delete_rosette_for_user(
    IN p_uuid CHAR(36),
    IN p_rosette_mac VARCHAR(17),
    OUT p_message VARCHAR(100)
)
BEGIN
    DECLARE rosette_id_to_delete INT;

    -- Obtener el ID de la roseta
    SELECT rosette_id INTO rosette_id_to_delete
    FROM rosette
    WHERE rosette_mac = p_rosette_mac AND owner_uuid = p_uuid;

    -- Verificar si existe la roseta antes de eliminar
    IF rosette_id_to_delete IS NOT NULL THEN
        -- Manejo de errores simplificado
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            SET p_message = 'Error al eliminar la roseta o su relación';

            -- Eliminar la relación
            DELETE FROM rosette_user
            WHERE uuid = p_uuid AND rosette_mac = p_rosette_mac;

            -- Eliminar la roseta
            DELETE FROM rosette
            WHERE rosette_id = rosette_id_to_delete;

            -- Insertar log de acción
            INSERT INTO logs (user_id, action, details)
            SELECT user_id, 'delete_rosette', CONCAT('Se eliminó roseta con MAC: ', p_rosette_mac)
            FROM user
            WHERE uuid = p_uuid;

            SET p_message = 'Roseta eliminada correctamente';
        END;
    ELSE
        SET p_message = 'Esta roseta no existe o no pertenece al usuario';
    END IF;
END$$

DELIMITER ;
