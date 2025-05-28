use lumitechDB;

DELIMITER //

CREATE PROCEDURE store_user_session(
    IN p_user_uuid VARCHAR(36),
    IN p_refresh_token TEXT
)
BEGIN
    DECLARE existing_count INT;
    DECLARE now_time DATETIME;
    DECLARE exp_time DATETIME;

    SET now_time = NOW();
    SET exp_time = DATE_ADD(now_time, INTERVAL 7 DAY);

    SELECT COUNT(*) INTO existing_count
    FROM user_session
    WHERE user_uuid = p_user_uuid AND expires_at > NOW();

    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El usuario ya tiene una sesión activa.';
    ELSE
        INSERT INTO user_session (user_uuid, refresh_token, expires_at)
        VALUES (p_user_uuid, p_refresh_token, exp_time);
    END IF;
END //

DELIMITER ;
