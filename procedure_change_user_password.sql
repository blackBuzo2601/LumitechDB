/*
CHANGE_USER_PASSWORD
Este procedure se encarga de modificar la contraseña del usuario. El parametro p_user_email
corresponde al correo introducido por el backend para modificar los campos del usuario.
p_current_password_hashed corresponde a la contraseña (Ya hasheada por el backend) que introduce
el usuario para comprobar que conoce la contraseña original antes de modificarla.
*/
USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_password(
    IN p_user_email VARCHAR(100),
    IN p_current_password_hashed VARCHAR(60),
    IN p_new_password_hashed VARCHAR(60),
    OUT p_message VARCHAR(50)
)
BEGIN
    DECLARE stored_password VARCHAR(60);

    -- Obtener la contraseña actual de la base de datos
    SELECT user_password INTO stored_password
    FROM user
    WHERE user_email = p_user_email;

    -- Verificar si coincide con la contraseña original proporcionada
    IF stored_password = p_current_password_hashed THEN
        -- Si coincide, actualizar a la nueva contraseña
        UPDATE user
        SET user_password = p_new_password_hashed
        WHERE user_email = p_user_email;

        SET p_message = 'Contraseña modificada';
    ELSE
        -- Si no coincide, mandar mensaje de error
        SET p_message = 'La contraseña no es la misma que la original.';
    END IF;
END $$

DELIMITER ;
