use lumitechDB;


DELIMITER $$

CREATE PROCEDURE get_user_password_by_token(
  IN p_token VARCHAR(36),
  OUT p_password VARCHAR(255)
)
BEGIN
  SELECT user_password INTO p_password
  FROM user
  WHERE reset_password_token = p_token;
END $$

DELIMITER ;

