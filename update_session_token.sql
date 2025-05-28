use lumitechDB;

DELIMITER //
CREATE PROCEDURE update_session_token(
  IN p_session_id INT,
  IN p_new_refresh_token TEXT
)
BEGIN
  UPDATE user_session 
  SET refresh_token = p_new_refresh_token,
      expires_at = DATE_ADD(NOW(), INTERVAL 7 DAY)
  WHERE session_id = p_session_id;
END //
DELIMITER ;
