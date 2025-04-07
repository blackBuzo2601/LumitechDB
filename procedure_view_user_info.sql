USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE view_user_info(
    IN p_user_nickname VARCHAR(15),
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
    WHERE user_nickname = p_user_nickname
    LIMIT 1;
END $$

DELIMITER ;