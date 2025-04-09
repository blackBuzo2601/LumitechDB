/*
VALIDATE_USER
Este procedure, se utiliza para validar en la PANTALLA DE REGISTRO de usuario que 
tanto el nickname como el correo proporcionado por el usuario, no existan en
la BD para poder registrarse. De lo contrario, devuelve un mensaje de que no puede 
registrarse.
El backend usa PRIMERO ESTE PROCEDURE, para decidir si el usuario puede registrarse,
si efectivamente el usuario ni el correo están en uso en la BD, se procede con el
procedure de REGISTER_USER.

*/

USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE validate_user(
    IN p_user_nickname VARCHAR(15),
    IN p_user_email VARCHAR(100),
    OUT p_result VARCHAR(100)
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
    ELSEIF email_exists > 0 THEN
        SET p_result = 'Error: Email ya registrado';
    ELSE
        SET p_result = 'VALID';
    END IF;
END $$

DELIMITER ;
