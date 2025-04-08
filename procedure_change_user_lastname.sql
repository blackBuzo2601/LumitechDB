/*
CHANGE_USER_LAST_NAME
Este procedure recibe el apellido con el que el usuario quiere reemplazar su apellido en la 
información de su cuenta.
El parametro p_user_email corresponde al campo que usa el backend para buscar el usuario
en la db y reemplazar su información.
*/
USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_last_name(
    IN p_user_email VARCHAR(100),
    IN p_user_last_name VARCHAR(50)
)
BEGIN
    UPDATE user
    SET user_last_name = p_user_last_name
    WHERE user_email = p_user_email;
END $$

DELIMITER ;
