/*
VALIDATE_SESSION
Este procedure se encarga de validar un inicio de sesión de un usuario EXISTENTE.
El valor introducido desde el front, es un campo que puede ser un NICKNAME o un Email.
El procedure verifica primero si el valor recibido EXISTE en los registros de la columna
nickname, si no es así, entonces verifica si el valor recibido EXISTE en los registros
de la columna email.
En caso de que el valor no se encuentre en nickname ni email, devuelve un error al backend
de que el correo o nickname no existen.
En caso de si encontrar primero el nickname, o el email guarda la contraseña en
stored_password para compararla con la contraseña que recibe el backend.
Al final evalúa si las credenciales coinciden. SI COINCIDEN, hace una ultima validación
que consiste en permitir la sesión SI EL USUARIO ESTÁ VERIFICADO, si el usuario NO ESTÁ 
VERIFICADO, a pesar de que las credenciales coincidan, no podrá iniciar sesión.

*/

USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE validate_session(
    IN p_user_nickname VARCHAR(100), --nickname o correo aquí
    IN p_user_password VARCHAR(100),
    OUT p_result VARCHAR(255)
)
BEGIN
    DECLARE nickname_exists INT;
    DECLARE email_exists INT;
    DECLARE stored_password VARCHAR(100);
    DECLARE user_verified TINYINT;
    DECLARE user_exists TINYINT DEFAULT 1;  -- Inicializamos en 1, asumiendo que el usuario existe al inicio

    -- Verificar si el nickname existe
    SELECT COUNT(*) INTO nickname_exists FROM user WHERE user_nickname = p_user_nickname;

    -- Si el nickname NO existe, verificar si el email SI existe
    IF nickname_exists = 0 THEN
        SELECT COUNT(*) INTO email_exists FROM user WHERE user_email = p_user_nickname;

        -- Si tampoco es un email registrado, devolver error y establecer user_exists a 0
        IF email_exists = 0 THEN
            SET p_result = 'Error: El nickname o el correo no existen';
            SET user_exists = 0;  -- Usuario no existe
        ELSE
            -- Si el email SI existe, obtener la contraseña usando el email
            SELECT user_password, verified INTO stored_password, user_verified 
            FROM user WHERE user_email = p_user_nickname LIMIT 1;
        END IF;
    ELSE
        -- Si el nickname SI existe, obtener la contraseña usando el nickname
        SELECT user_password, verified INTO stored_password, user_verified 
        FROM user WHERE user_nickname = p_user_nickname LIMIT 1;
    END IF;

    -- Verificar si el usuario no existe, en cuyo caso no continuamos con la verificación de contraseña
    IF user_exists = 0 THEN
        SET p_result = 'Error: El nickname o el correo no existen';
    ELSE
        -- Verificar la contraseña solo si el usuario existe
        IF stored_password = p_user_password THEN
            -- Verificar si el usuario está verificado
            IF user_verified = 1 THEN
                SET p_result = 'LOGIN_OK';
            ELSE
                SET p_result = 'ERROR. USUARIO NO VERIFICADO';
            END IF;
        ELSE
            SET p_result = 'Error: Contraseña incorrecta';
        END IF;
    END IF;

END $$

DELIMITER ;
