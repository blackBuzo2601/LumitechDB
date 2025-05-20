use lumitechDB;

DELIMITER $$

CREATE PROCEDURE increment_token_version(IN p_uuid CHAR(36))
BEGIN
  UPDATE user
  SET token_version = token_version + 1
  WHERE uuid = p_uuid;
END$$

DELIMITER ;
