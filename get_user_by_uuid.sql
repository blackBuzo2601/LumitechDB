use lumitechDB;

DELIMITER $$

CREATE PROCEDURE get_user_by_uuid(
  IN p_uuid CHAR(36)
)

BEGIN
  SELECT 
    uuid, 
    user_name AS userName, 
    verified AS verify,
    user_last_name AS userLastName, 
    user_email AS email, 
    user_nickname AS userNickName,
    token_version
  FROM user
  WHERE uuid = p_uuid
  LIMIT 1;
END$$

DELIMITER ;
