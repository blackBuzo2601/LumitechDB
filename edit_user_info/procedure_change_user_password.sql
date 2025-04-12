USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_password(
    IN p_uuid CHAR(36),
    IN p_new_password_hashed VARCHAR(60),
    OUT p_message VARCHAR(50)
)
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists
    FROM user
    WHERE uuid = p_uuid;

    IF user_exists = 1 THEN
    
        UPDATE user
        SET user_password = p_new_password_hashed
        WHERE uuid = p_uuid;

        SET p_message = 'Contraseña actualizada correctamente';
    ELSE
       
        SET p_message = 'Usuario no encontrado';
    END IF;
END $$

DELIMITER ;

