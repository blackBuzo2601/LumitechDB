USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE get_user_password(
    IN p_uuid CHAR(36),
    OUT p_user_password VARCHAR(60) 
)
BEGIN
    
    SELECT user_password INTO p_user_password
    FROM user
    WHERE uuid = p_uuid
    LIMIT 1;
END $$

DELIMITER ;
