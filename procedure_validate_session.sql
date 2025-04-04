USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE validate_session(
    IN p_user_nickname VARCHAR(15),
    IN p_user_password VARCHAR(100),
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE nickname_exists INT;
    DECLARE stored_password VARCHAR(100);

    -- Verificar si el nickname existe
    SELECT COUNT(*) INTO nickname_exists FROM user WHERE user_nickname = p_user_nickname;

    -- Si el nickname no existe, devolver error y salir
    IF nickname_exists = 0 THEN
        SET p_result = 'Error: Usuario no encontrado';
    ELSE
        -- Obtener la contraseña almacenada del usuario
        SELECT user_password INTO stored_password FROM user WHERE user_nickname = p_user_nickname;

        -- Comparar la contraseña
        IF stored_password = p_user_password THEN
            SET p_result = 'LOGIN OK';
        ELSE
            SET p_result = 'Error: Contraseña incorrecta';
        END IF;
    END IF;
END $$

DELIMITER ;