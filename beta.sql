CREATE DATABASE IF NOT EXISTS lumitech_beta;
USE lumitech_beta;


    CREATE TABLE user (
        user_id INT PRIMARY KEY AUTO_INCREMENT,
        user_name VARCHAR(50) NOT NULL,
        user_last_name VARCHAR(30) NOT NULL,
        user_nickname VARCHAR(15) UNIQUE NOT NULL,
        user_email VARCHAR(100) UNIQUE NOT NULL,
        user_password VARCHAR(30) NOT NULL,
        uuid CHAR(36) UNIQUE NOT NULL
        verified TINYINT(1) NOT NULL DEFAULT 0,
        token_verification VARCHAR(255) NULL
    );


CREATE TABLE rosette (
    rosette_id INT PRIMARY KEY AUTO_INCREMENT,
    rosette_ubication VARCHAR(30) NOT NULL,
    rosette_register_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    rosette_mac VARCHAR(17) UNIQUE NOT NULL,
    owner_uuid CHAR(36) NOT NULL,
    FOREIGN KEY (owner_uuid) REFERENCES user(uuid) ON DELETE CASCADE
);


CREATE TABLE sensor_backup (
    backup_id INT PRIMARY KEY AUTO_INCREMENT,
    rosette_id INT NOT NULL,
    sensor_data JSON NOT NULL,
    backup_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rosette_id) REFERENCES rosette(rosette_id) ON DELETE CASCADE
);

CREATE TABLE logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    action VARCHAR(50) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(100) NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);
