/*
CHANGE_USER_PASSWORD
Este procedure se encarga de modificar la contraseña del usuario. El parametro p_user_email
corresponde al correo introducido por el backend para modificar los campos del usuario.
"p_current_password_hashed" corresponde a la contraseña (Ya hasheada por el backend) que introduce
el usuario para comprobar que conoce la contraseña original de la cuenta 
antes de modificarla.
"p_new_password_hashed" corresponde al campo proveniente desde el backend (hasheado) que
es lo que el usuario quiere remplazar en la contraseña original. 
El procedure valida primero que el usuario conoce la contraseña original, antes de
reemplazarla por la nueva contraseña.
Si no coincide el campo de "p_current_password_hashed" con la almacenada en la bd, no se
hace el cambio y se envía un mensaje al backend. Si la contraseña si coincide con la
almacenada en la bd, si se actualiza y de igual forma se envía un mensaje al backend
*/
USE lumitechDB;
DELIMITER $$

CREATE PROCEDURE change_user_password(
    IN p_uuid CHAR(36),
    IN p_current_password_hashed VARCHAR(60),
    IN p_new_password_hashed VARCHAR(60),
    OUT p_message VARCHAR(50)
)
BEGIN
    DECLARE stored_password VARCHAR(60);

    -- Obtener la contraseña actual de la base de datos
    SELECT user_password INTO stored_password
    FROM user
    WHERE uuid = p_uuid;

    -- Verificar si coincide con la contraseña original proporcionada
    IF stored_password = p_current_password_hashed THEN
        -- Si coincide, actualizar a la nueva contraseña
        UPDATE user
        SET user_password = p_new_password_hashed
        WHERE uuid = p_uuid;

        SET p_message = 'Contraseña modificada';
    ELSE
        -- Si no coincide, mandar mensaje de error
        SET p_message = 'La contraseña no es la misma que la original.';
    END IF;
END $$

DELIMITER ;
