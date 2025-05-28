use lumitechDB;

DELIMITER $$

CREATE PROCEDURE reset_user_password(
    IN reset_token VARCHAR(36), 
    IN new_password VARCHAR(60)
)
BEGIN
    DECLARE user_uuid CHAR(36);
    DECLARE token_expiration DATETIME;
    DECLARE result_message VARCHAR(100);

    SELECT uuid, token_expiration_time INTO user_uuid, token_expiration
    FROM user 
    WHERE reset_password_token = reset_token;

    IF user_uuid IS NULL THEN
        SET result_message = 'Token invalido';

    ELSEIF token_expiration < NOW() THEN
        UPDATE user 
        SET reset_password_token = NULL, token_expiration_time = NULL 
        WHERE uuid = user_uuid;

        SET result_message = 'Token expirado';

    ELSE
        UPDATE user 
        SET user_password = new_password, 
            reset_password_token = NULL, 
            token_expiration_time = NULL 
        WHERE uuid = user_uuid;

        SET result_message = 'Contraseña actualizada correctamente';
    END IF;

    -- Devolver el mensaje directamente
    SELECT result_message AS result_message;
END$$

DELIMITER ;
