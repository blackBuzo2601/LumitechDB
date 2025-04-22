/*
CHANGE_USER_NICKNAME
Este procedure recibe el nickname con el que el usuario quiere reemplazar su nickname en la 
información de su cuenta.
El parametro p_user_email corresponde al campo que usa el backend para buscar el usuario
en la db y reemplazar su información.
*/
USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_nickname(
    IN p_uuid CHAR(36),
    IN p_user_nickname VARCHAR(15),
    OUT p_message VARCHAR(100)
)
BEGIN
    UPDATE user
    SET user_nickname = p_user_nickname
    WHERE uuid = p_uuid;

    SET p_message = 'Apodo modificado exitosamente';
END $$

DELIMITER ;

