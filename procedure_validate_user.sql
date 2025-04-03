use lumintechDB;

DELIMITER $$

CREATE PROCEDURE validate_user(
    IN p_user_nickname VARCHAR(15),
    IN p_user_email VARCHAR(100),
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE nickname_exists INT;
    DECLARE email_exists INT;

    -- Verificar si el nickname ya existe
    SELECT COUNT(*) INTO nickname_exists FROM user WHERE user_nickname = p_user_nickname;

    -- Verificar si el email ya existe
    SELECT COUNT(*) INTO email_exists FROM user WHERE user_email = p_user_email;

    -- Determinar el resultado
    IF nickname_exists > 0 THEN
        SET p_result = 'Error: Nickname ya registrado';
    ELSE IF email_exists > 0 THEN
        SET p_result = 'Error: Email ya registrado';
    ELSE
        SET p_result = 'VALID';
    END IF;
END $$

DELIMITER ;