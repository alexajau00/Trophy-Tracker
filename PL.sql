-- -------------------------------------------
-- Trophy Tracker - PL/SQL Stored Procedures
-- Group 84: Alexa Jauregui & Cody Strehlow
-- CS340 Project Step 4 (DRAFT)
-- -------------------------------------------

-- DELETE player sp to demonstrate RESET
DROP PROCEDURE IF EXISTS sp_demo_delete_player;
DELIMITER //
CREATE PROCEDURE sp_demo_delete_player()
BEGIN
    DELETE FROM Players WHERE username = 'ProGamer99';
END //
DELIMITER ;

-- CREATE player sp
DROP PROCEDURE IF EXISTS sp_insert_player;
DELIMITER //
CREATE PROCEDURE sp_insert_player(
    IN p_username VARCHAR(100),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO Players (username, email)
    VALUES (p_username, p_email);
END //
DELIMITER ;

-- UPDATE player sp
DROP PROCEDURE IF EXISTS sp_update_player;
DELIMITER //
CREATE PROCEDURE sp_update_player(
    IN p_playerID INT,
    IN p_username VARCHAR(100),
    IN p_email VARCHAR(255)
)
BEGIN
    UPDATE Players
    SET username = p_username, email = p_email
    WHERE playerID = p_playerID;
END //
DELIMITER ;

-- DELETE player sp
DROP PROCEDURE IF EXISTS sp_delete_player;
DELIMITER //
CREATE PROCEDURE sp_delete_player(
    IN p_playerID INT
)
BEGIN
    DELETE FROM Players 
    WHERE playerID = p_playerID;
END //
DELIMITER ;