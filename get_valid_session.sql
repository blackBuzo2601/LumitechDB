use lumitechDB;

DELIMITER //
CREATE PROCEDURE get_valid_session(
  IN p_user_uuid VARCHAR(255),
  IN p_refresh_token TEXT
)
BEGIN
  SELECT * FROM user_session 
  WHERE user_uuid = p_user_uuid 
    AND refresh_token = p_refresh_token 
    AND expires_at > NOW() 
  LIMIT 1;
END //
DELIMITER ;
