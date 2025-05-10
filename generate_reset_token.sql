USE lumitechDB;

DELIMITER $$

CREATE PROCEDURE generate_reset_token(
  IN user_email_input VARCHAR(100), 
  IN reset_token VARCHAR(36), 
  OUT verified_flag TINYINT,
  OUT found_flag TINYINT,
  OUT user_name_out VARCHAR(50) 
)
BEGIN
    DECLARE user_uuid CHAR(36);
    DECLARE is_verified TINYINT;
    DECLARE user_name_val VARCHAR(50);

    -- Buscar UUID, estado de verificación y nombre
    SELECT uuid, verified, user_name 
    INTO user_uuid, is_verified, user_name_val
    FROM user 
    WHERE user_email = user_email_input;

    -- Usuario no encontrado
    IF user_uuid IS NULL THEN
        SET verified_flag = 0;
        SET found_flag = 0;
        SET user_name_out = NULL;
    ELSEIF is_verified = 0 THEN
        SET verified_flag = 0;
        SET found_flag = 1;
        SET user_name_out = user_name_val;
    ELSE
        SET verified_flag = 1;
        SET found_flag = 1;
        SET user_name_out = user_name_val;

        -- Actualiza el token
        UPDATE user 
        SET reset_password_token = reset_token
        WHERE uuid = user_uuid;
    END IF;
END$$

DELIMITER ;
