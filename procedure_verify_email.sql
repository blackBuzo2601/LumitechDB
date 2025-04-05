use lumitechDB;

DELIMITER $$

CREATE PROCEDURE verify_email(
    IN p_verification_token VARCHAR(36)
)
    BEGIN
    DECLARE user_exists INT;

    -- Verificar si el token existe y corresponde a un usuario
    SELECT COUNT(*) INTO user_exists
    FROM user
    WHERE token_verification = p_verification_token;

    -- Si es mayor a 1 (Existe):
    IF user_exists > 0 THEN
        -- Actualizar el estado de verificación del usuario
        UPDATE user
        SET verified = 1, token_verification = NULL
        WHERE token_verification = p_verification_token;
    ELSE
        -- Si no se encuentra el token, lanzar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR. Token de verificación inválido';
    END IF;
END $$

DELIMITER ;