USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_lastname(
    IN p_uuid CHAR(36),
     IN p_user_last_name VARCHAR(50),
    OUT p_message VARCHAR(50)
)
BEGIN
    UPDATE user
    SET user_last_name = p_user_last_name
    WHERE uuid = p_uuid;

    SET p_message = 'Apellido actualizado correctamente';
END $$

DELIMITER ;
