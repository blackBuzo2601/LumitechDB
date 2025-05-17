DELIMITER $$

CREATE PROCEDURE get_token_version(IN p_uuid CHAR(36))
BEGIN
  SELECT token_version FROM user WHERE uuid = p_uuid LIMIT 1;
END$$

DELIMITER ;
