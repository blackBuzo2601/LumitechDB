USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_nickname(
    IN p_uuid CHAR(36),
     IN p_user_nick_name VARCHAR(50),
    OUT p_message VARCHAR(50)
)
BEGIN
    UPDATE user
    SET user_nickname = p_user_nick_name
    WHERE uuid = p_uuid;

    SET p_message = 'Nickname actualizado correctamente';
END $$

DELIMITER ;
