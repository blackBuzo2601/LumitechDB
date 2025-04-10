/*
CHANGE_USER_NAME
Este procedure recibe el nombre con el que el usuario quiere reemplazar su nombre en la 
información de su cuenta.
El parametro p_user_email corresponde al campo que usa el backend para buscar el usuario
en la db y reemplazar su información.
*/
USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_name(
    IN p_uuid CHAR(36),
    IN p_user_name VARCHAR(50)
)
BEGIN
    UPDATE user
    SET user_name = p_user_name
    WHERE uuid = p_uuid;
END $$

DELIMITER ;
