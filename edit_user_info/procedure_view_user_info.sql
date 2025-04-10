/*
VIEW_USER_INFO
Este procedure recibe como parametro el correo del usuario del cual vamos a extraer
la información para mostrarla en el front. La información se guarda en cuatro variables
de salida de forma que el back pueda obtener esa información en cuatro variables diferentes
y que pueda consumirlo el front

*/

USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE view_user_info(
    IN p_uuid CHAR(36),
    OUT result_user_name VARCHAR(50),
    OUT result_user_last_name VARCHAR(50),
    OUT result_user_nickname VARCHAR(15),
    OUT result_user_email VARCHAR(100)
)
BEGIN
    SELECT 
        user_name,
        user_last_name,
        user_nickname,
        user_email
    INTO
        result_user_name,
        result_user_last_name,
        result_user_nickname,
        result_user_email
    FROM user
    WHERE uuid = p_uuid
    LIMIT 1;
END $$

DELIMITER ;