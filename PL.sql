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
