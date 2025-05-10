/*
VERIFY_EMAIL
Este procedure se usa cuando el usuario desea verificar su cuenta para poder iniciar sesion.
El parametro p_verification_token corresponde al token que el usuario recibe para poder
verificar su cuenta.
El procedure busca en todas las filas de la tabla user en el campo token_verification
que exista el token ingresado por el usuario. Si no existe, devuelve un error al backend.
Si encuentra el token ingresado, el campo de verified de user se asigna en 1. Lo que 
significa que el usuario está verificado y ahora PUEDE INICIAR SESIÓN cuando se use
el procedure de "validate_session", porque éste ultimo al verificar las credenciales,
se asegura de que el usuario esté "verificado".

*/

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