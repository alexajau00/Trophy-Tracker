-- -------------------------------------------
-- Trophy Tracker - PL/SQL Stored Procedures
-- Group 84: Alexa Jauregui & Cody Strehlow
-- CS340 Project Step 4 (DRAFT)
-- -------------------------------------------

-- -------------------------------------------
-- Players
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

-- -------------------------------------------
-- Games
-- -------------------------------------------

-- INSERT game sp
DROP PROCEDURE IF EXISTS sp_insert_game;
DELIMITER //
CREATE PROCEDURE sp_insert_game(
    IN p_title VARCHAR(255),
    IN p_developer VARCHAR(255),
    IN p_releaseYear INT
)
BEGIN
    INSERT INTO Games (title, developer, releaseYear)
    VALUES (p_title, p_developer, p_releaseYear);
END //
DELIMITER ;

-- UPDATE game sp
DROP PROCEDURE IF EXISTS sp_update_game;
DELIMITER //
CREATE PROCEDURE sp_update_game(
    IN p_gameID INT,
    IN p_title VARCHAR(255),
    IN p_developer VARCHAR(255),
    IN p_releaseYear INT
)
BEGIN
    UPDATE Games
    SET title = p_title, developer = p_developer, releaseYear = p_releaseYear
    WHERE gameID = p_gameID;
END //
DELIMITER ;

-- DELETE game sp
DROP PROCEDURE IF EXISTS sp_delete_game;
DELIMITER //
CREATE PROCEDURE sp_delete_game(
    IN p_gameID INT
)
BEGIN
    DELETE FROM Games
    WHERE gameID = p_gameID;
END //
DELIMITER ;

-- -------------------------------------------
-- Platforms
-- -------------------------------------------

-- INSERT platform sp
DROP PROCEDURE IF EXISTS sp_insert_platform;
DELIMITER //
CREATE PROCEDURE sp_insert_platform(
    IN p_name VARCHAR(255),
    IN p_manufacturer VARCHAR(255)
)
BEGIN
    INSERT INTO Platforms (name, manufacturer)
    VALUES (p_name, p_manufacturer);
END //
DELIMITER ;

-- UPDATE platform sp
DROP PROCEDURE IF EXISTS sp_update_platform;
DELIMITER //
CREATE PROCEDURE sp_update_platform(
    IN p_platformID INT,
    IN p_name VARCHAR(255),
    IN p_manufacturer VARCHAR(255)
)
BEGIN
    UPDATE Platforms
    SET name = p_name, manufacturer = p_manufacturer
    WHERE platformID = p_platformID;
END //
DELIMITER ;

-- DELETE platform sp
DROP PROCEDURE IF EXISTS sp_delete_platform;
DELIMITER //
CREATE PROCEDURE sp_delete_platform(
    IN p_platformID INT
)
BEGIN
    DELETE FROM Platforms
    WHERE platformID = p_platformID;
END //
DELIMITER ;

-- -------------------------------------------
-- Achievements
-- -------------------------------------------

-- INSERT achievement sp
DROP PROCEDURE IF EXISTS sp_insert_achievement;
DELIMITER //
CREATE PROCEDURE sp_insert_achievement(
    IN p_gameID INT,
    IN p_platformID INT,
    IN p_achievementName VARCHAR(255),
    IN p_description TEXT,
    IN p_isHidden TINYINT(1),
    IN p_rarityPercentage DECIMAL(5,2)
)
BEGIN
    INSERT INTO Achievements (gameID, platformID, achievementName, description, isHidden, rarityPercentage)
    VALUES (p_gameID, p_platformID, p_achievementName, p_description, p_isHidden, p_rarityPercentage);
END //
DELIMITER ;

-- UPDATE achievement sp
DROP PROCEDURE IF EXISTS sp_update_achievement;
DELIMITER //
CREATE PROCEDURE sp_update_achievement(
    IN p_achievementID INT,
    IN p_gameID INT,
    IN p_platformID INT,
    IN p_achievementName VARCHAR(255),
    IN p_description TEXT,
    IN p_isHidden TINYINT(1),
    IN p_rarityPercentage DECIMAL(5,2)
)
BEGIN
    UPDATE Achievements
    SET gameID = p_gameID, platformID = p_platformID, achievementName = p_achievementName,
        description = p_description, isHidden = p_isHidden, rarityPercentage = p_rarityPercentage
    WHERE achievementID = p_achievementID;
END //
DELIMITER ;

-- DELETE achievement sp
DROP PROCEDURE IF EXISTS sp_delete_achievement;
DELIMITER //
CREATE PROCEDURE sp_delete_achievement(
    IN p_achievementID INT
)
BEGIN
    DELETE FROM Achievements
    WHERE achievementID = p_achievementID;
END //
DELIMITER ;

-- -------------------------------------------
-- playerGames
-- -------------------------------------------

-- INSERT playerGame sp
DROP PROCEDURE IF EXISTS sp_insert_playerGame;
DELIMITER //
CREATE PROCEDURE sp_insert_playerGame(
    IN p_playerID INT,
    IN p_gameID INT
)
BEGIN
    INSERT INTO playerGames (playerID, gameID)
    VALUES (p_playerID, p_gameID);
END //
DELIMITER ;

-- UPDATE playerGame sp
DROP PROCEDURE IF EXISTS sp_update_playerGame;
DELIMITER //
CREATE PROCEDURE sp_update_playerGame(
    IN p_playerGameID INT,
    IN p_playerID INT,
    IN p_gameID INT
)
BEGIN
    UPDATE playerGames
    SET playerID = p_playerID, gameID = p_gameID
    WHERE playerGameID = p_playerGameID;
END //
DELIMITER ;

-- DELETE playerGame sp
DROP PROCEDURE IF EXISTS sp_delete_playerGame;
DELIMITER //
CREATE PROCEDURE sp_delete_playerGame(
    IN p_playerGameID INT
)
BEGIN
    DELETE FROM playerGames
    WHERE playerGameID = p_playerGameID;
END //
DELIMITER ;

-- -------------------------------------------
-- playerAchievements
-- -------------------------------------------

-- INSERT playerAchievement sp
DROP PROCEDURE IF EXISTS sp_insert_playerAchievement;
DELIMITER //
CREATE PROCEDURE sp_insert_playerAchievement(
    IN p_playerID INT,
    IN p_achievementID INT,
    IN p_dateAchieved DATE
)
BEGIN
    INSERT INTO playerAchievements (playerID, achievementID, dateAchieved)
    VALUES (p_playerID, p_achievementID, p_dateAchieved);
END //
DELIMITER ;

-- UPDATE playerAchievement sp
DROP PROCEDURE IF EXISTS sp_update_playerAchievement;
DELIMITER //
CREATE PROCEDURE sp_update_playerAchievement(
    IN p_playerAchievementID INT,
    IN p_playerID INT,
    IN p_achievementID INT,
    IN p_dateAchieved DATE
)
BEGIN
    UPDATE playerAchievements
    SET playerID = p_playerID, achievementID = p_achievementID, dateAchieved = p_dateAchieved
    WHERE playerAchievementID = p_playerAchievementID;
END //
DELIMITER ;

-- DELETE playerAchievement sp
DROP PROCEDURE IF EXISTS sp_delete_playerAchievement;
DELIMITER //
CREATE PROCEDURE sp_delete_playerAchievement(
    IN p_playerAchievementID INT
)
BEGIN
    DELETE FROM playerAchievements
    WHERE playerAchievementID = p_playerAchievementID;
END //
DELIMITER ;

-- -------------------------------------------
-- gamePlatforms
-- -------------------------------------------

-- INSERT gamePlatform sp
DROP PROCEDURE IF EXISTS sp_insert_gamePlatform;
DELIMITER //
CREATE PROCEDURE sp_insert_gamePlatform(
    IN p_gameID INT,
    IN p_platformID INT
)
BEGIN
    INSERT INTO gamePlatforms (gameID, platformID)
    VALUES (p_gameID, p_platformID);
END //
DELIMITER ;

-- UPDATE gamePlatform sp
DROP PROCEDURE IF EXISTS sp_update_gamePlatform;
DELIMITER //
CREATE PROCEDURE sp_update_gamePlatform(
    IN p_gamePlatformID INT,
    IN p_gameID INT,
    IN p_platformID INT
)
BEGIN
    UPDATE gamePlatforms
    SET gameID = p_gameID, platformID = p_platformID
    WHERE gamePlatformID = p_gamePlatformID;
END //
DELIMITER ;

-- DELETE gamePlatform sp
DROP PROCEDURE IF EXISTS sp_delete_gamePlatform;
DELIMITER //
CREATE PROCEDURE sp_delete_gamePlatform(
    IN p_gamePlatformID INT
)
BEGIN
    DELETE FROM gamePlatforms
    WHERE gamePlatformID = p_gamePlatformID;
END //
DELIMITER ;
