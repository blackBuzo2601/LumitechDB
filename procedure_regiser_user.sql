/*
REGISTER_USER
Este procedure lo utiliza el backend DESPUÉS de usar el procedure VALIDATE_USER, si
el resultado del procedure mencionado es "VALID", si no, este procedure NO SE TOCA.
Este procedure inserta todos los campos proporcionados por el usuario en la BD, pero
como se mencionó anteriormente, primero con VALIDATE_USER verificamos si el nickname
y el email no existen en la BD.
*/

USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE register_user(
    IN p_user_name VARCHAR(50),
    IN p_user_last_name VARCHAR(50),
    IN p_user_nickname VARCHAR(15),
    IN p_user_email VARCHAR(100),
    IN p_user_password VARCHAR(60),
    IN p_token_verification VARCHAR(36),
    IN p_uuid CHAR(36) 
)
BEGIN
    INSERT INTO user (
        user_name, user_last_name, user_nickname, user_email, 
        user_password, token_verification, uuid
    )
    VALUES (
        p_user_name, p_user_last_name, p_user_nickname, p_user_email, 
        p_user_password, p_token_verification, p_uuid
    );
END $$

DELIMITER ;


