USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE generate_reset_token(IN user_email_input VARCHAR(100), IN reset_token VARCHAR(36), OUT expiration_time DATETIME)
BEGIN
  
    DECLARE user_uuid CHAR(36);

    
    SELECT uuid INTO user_uuid FROM user WHERE user_email = user_email_input;

    
    IF user_uuid IS NULL THEN
        SET reset_token = NULL;
        SET expiration_time = NULL;
    ELSE
    
        SET expiration_time = DATE_ADD(NOW(), INTERVAL 1 HOUR);

        UPDATE user SET reset_password_token = reset_token, token_expiration_time = expiration_time WHERE uuid = user_uuid;
    END IF;
END$$

DELIMITER ;



