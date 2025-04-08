/*
VALIDATE_SESSION
Hay que documentar este procedure otra vez
*/

USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE validate_session(
    IN p_user_nickname VARCHAR(100), 
    OUT p_password_hash VARCHAR(100),
    OUT p_user_verified TINYINT,
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE nickname_exists INT;
    DECLARE email_exists INT;
    DECLARE user_exists TINYINT DEFAULT 1;

    -- Verificar si el nickname existe
    SELECT COUNT(*) INTO nickname_exists FROM user WHERE user_nickname = p_user_nickname;

    -- Si el nickname NO existe, verificar si el email SI existe
    IF nickname_exists = 0 THEN
        SELECT COUNT(*) INTO email_exists FROM user WHERE user_email = p_user_nickname;

        IF email_exists = 0 THEN
            SET p_result = 'USER_NOT_FOUND';
            SET user_exists = 0;
        ELSE
            -- Obtener la contraseña hasheada y estado verificado por email
            SELECT user_password, verified 
            INTO p_password_hash, p_user_verified
            FROM user 
            WHERE user_email = p_user_nickname 
            LIMIT 1;
        END IF;
    ELSE
        -- Obtener la contraseña hasheada y estado verificado por nickname
        SELECT user_password, verified 
        INTO p_password_hash, p_user_verified
        FROM user 
        WHERE user_nickname = p_user_nickname 
        LIMIT 1;
    END IF;

    IF user_exists = 1 THEN
        SET p_result = 'USER_FOUND';
    END IF;

END $$
DELIMITER ;
