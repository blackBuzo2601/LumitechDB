USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_name(
    IN p_uuid CHAR(36),
    IN p_user_name VARCHAR(50),
    OUT p_message VARCHAR(50)
)
BEGIN
    UPDATE user
    SET user_name = p_user_name
    WHERE uuid = p_uuid;

    SET p_message = 'Nombre actualizado correctamente';
END $$

DELIMITER ;
