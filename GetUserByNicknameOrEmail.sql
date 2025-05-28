use lumitechDB;

DELIMITER //

CREATE PROCEDURE GetUserByNicknameOrEmail(
    IN p_nickname VARCHAR(15),
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT 
        uuid, 
        user_name AS userName, 
        user_nickname AS nickName, 
        user_email AS email, 
        token_version
    FROM user
    WHERE user_nickname = p_nickname OR user_email = p_email
    LIMIT 1;
END //

DELIMITER ;