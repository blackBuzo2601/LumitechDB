USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE resend_verification_token(
  IN user_email_input VARCHAR(100),
  IN new_token VARCHAR(36),
  OUT found_flag TINYINT,
  OUT verified_flag TINYINT,
  OUT user_name_out VARCHAR(50)
)
BEGIN
    DECLARE user_uuid CHAR(36);
    DECLARE is_verified TINYINT;
    DECLARE user_name_val VARCHAR(100);

    SELECT uuid, verified, user_name 
    INTO user_uuid, is_verified, user_name_val
    FROM user
    WHERE user_email = user_email_input;

    IF user_uuid IS NULL THEN
        SET found_flag = 0;
        SET verified_flag = 0;
        SET user_name_out = NULL;
    ELSEIF is_verified = 1 THEN
        SET found_flag = 1;
        SET verified_flag = 1;
        SET user_name_out = user_name_val;
    ELSE
        SET found_flag = 1;
        SET verified_flag = 0;
        SET user_name_out = user_name_val;

        -- Actualiza el token
        UPDATE user
        SET token_verification = new_token
        WHERE uuid = user_uuid;
    END IF;
END$$

DELIMITER ;
