USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE register_user(
    IN p_user_name VARCHAR(50),
    IN p_user_last_name VARCHAR(50),
    IN p_user_nickname VARCHAR(15),
    IN p_user_email VARCHAR(100),
    IN p_user_password VARCHAR(60),
    IN p_token_verification VARCHAR(36)
)
BEGIN
    INSERT INTO user (
        user_name, user_last_name, user_nickname, user_email, 
        user_password, token_verification, uuid
    )
    VALUES (
        p_user_name, p_user_last_name, p_user_nickname, p_user_email, 
        p_user_password, p_token_verification, UUID()
    );
END $$

DELIMITER ;


