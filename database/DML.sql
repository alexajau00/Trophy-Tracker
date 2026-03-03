-- -------------------------------------------
-- Trophy Tracker - DML 
-- Group 84: Alexa Jauregui & Cody Strehlow
-- CS340 Project Step 3 (FINAL)
-- -------------------------------------------

-- -------------------------------------------
-- CRUD Operations for Players Table
-- -------------------------------------------

-- SELECT all players
SELECT playerID, username, email 
FROM Players;

-- Add a new player (Create)
INSERT INTO Players (username, email)
VALUES (:usernameInput, :emailInput);

-- Remove a player (Delete)
DELETE FROM Players WHERE playerID = :playerIDSelected;

-- Update Player information (Update)
SELECT playerID, username, email
FROM Players
WHERE playerID = :playerIDSelected;

UPDATE Players
SET username = :usernameInput, email = :emailInput
WHERE playerID = :playerIDSelected;

-- -------------------------------------------
-- CRUD Operations for Games Table
-- -------------------------------------------

-- SELECT all games 
SELECT gameID, title, developer, releaseYear 
FROM Games;

-- Add a new game (Create)
INSERT INTO Games (title, developer, releaseYear) 
VALUES (:titleInput, :developerInput, :releaseYearInput);

-- Remove a Game (DELETE)
DELETE FROM Games 
WHERE gameID = :gameIDSelected;

-- Update Game information (Update)
UPDATE Games
SET title = :titleInput, developer = :developerInput, releaseYear = :releaseYearInput 
WHERE gameID = :gameIDSelected;

-- -------------------------------------------
-- CRUD Operations for Platforms Table
-- -------------------------------------------

-- SELECT all for platforms
SELECT platformID, name, manufacturer FROM Platforms;

-- Add a new Platform (Create)
INSERT INTO Platforms (name, manufacturer) 
VALUES (:nameInput, :manufacturerInput);

-- Delete a Platform (Delete)
DELETE FROM Platforms 
WHERE platformID = :platformIDSelected;

-- Update a Platform (Update)
UPDATE Platforms
SET name = :nameInput, manufacturer = :manufacturerInput
WHERE platformID = :platformIDSelected; 

-- -------------------------------------------
-- CRUD Operations for Achievements Table
-- -------------------------------------------

-- SELECT Achivements and join games and platforms
SELECT Achievements.achievementID, Games.title, Platforms.name, Achievements.achievementName, Achievements.isHidden, Achievements.rarityPercentage
FROM Achievements
JOIN Games ON Achievements.gameID = Games.gameID
JOIN Platforms ON Achievements.platformID = Platforms.platformID;

-- populate games title dropdown
SELECT gameID, title FROM Games;

-- populate platforms name dropdown
SELECT platformID, name FROM Platforms;

-- Add a new Achievements
INSERT INTO Achievements (gameID, platformID, achievementName, isHidden, rarityPercentage)
VALUES (:gameIDInput, :platformIDInput, :achievementNameInput, :isHiddenInput, :rarityPercentageInput);

-- delete a Achievement
DELETE FROM Achievements
WHERE achievementID = :achievementIDInput;

-- update a Achievement
UPDATE Achievements
SET gameID = :gameIDInput, platformID = :platformIDInput, achievementName = :achievementNameInput, 
isHidden = :isHiddenInput, rarityPercentage = :rarityPercentageInput
WHERE achievementID = :achievementIDInput;

-- -------------------------------------------
-- CRUD Operations for playerGames Table
-- -------------------------------------------
-- SELECT playerGames (who owns what) and join games and players
SELECT playerGames.playerGameID, Players.username, Games.title
FROM playerGames
JOIN Players On playerGames.playerID = Players.playerID
JOIN Games ON playerGames.gameID = Games.gameID;

-- populate username dropdown for playerGames
SELECT playerID, username FROM Players;
-- populate game dropdown for playerGames
SELECT gameID, title FROM Games;

-- Add playerGames
INSERT INTO playerGames (playerID, gameID)
VALUES (:playerIDInput, :gameIDInput);

-- Remove playerGames
DELETE FROM playerGames
WHERE playerGameID = :playerGameIDInput;

-- Update playerGames
UPDATE playerGames
SET playerID = :playerIDInput, gameID = :gameIDInput
WHERE playerGameID = :playerGameIDInput; 

-- -------------------------------------------
-- CRUD Operations for playerAchievements Table
-- -------------------------------------------

-- SELECT playerAchievements join players and achievements
SELECT playerAchievements.playerAchievementID, Players.username, Achievements.achievementName, playerAchievements.dateAchieved
FROM playerAchievements
JOIN Players ON playerAchievements.playerID = Players.playerID
JOIN Achievements On playerAchievements.achievementID = Achievements.achievementID;

-- populate players dropdown
SELECT playerID, username FROM Players;

-- populate achievement dropdown 
SELECT achievementID, achievementName FROM Achievements;

-- add a players achievement
INSERT INTO playerAchievements (playerID, achievementID, dateAchieved) 
VALUES (:playerIDInput, :achievementIDInput, :dateAchievedInput);

-- delete a players achievement
DELETE FROM playerAchievements WHERE playerAchievementID = :playerAchievementIDInput;

-- update a players achievement
UPDATE playerAchievements 
SET playerID = :playerIDInput, achievementID = :achievementIDInput, dateAchieved = :dateAchievedInput 
WHERE playerAchievementID = :playerAchievementIDInput;

-- -------------------------------------------
-- CRUD Operations for gamePlatforms Table
-- -------------------------------------------

-- SELECT gamePlatforms join games and platforms
SELECT gamePlatforms.gamePlatformID, Games.title, Platforms.name
FROM gamePlatforms
JOIN Games On gamePlatforms.gameID = Games.gameID
JOIN Platforms ON gamePlatforms.platformID = Platforms.platformID;

-- populate games dropdown
SELECT gameID, title FROM Games;

-- populate platform dropdown
SELECT platformID, name FROM Platforms;

-- Add a gamePlatforms
INSERT INTO gamePlatforms (gameID, platformID) 
VALUES (:gameIDInput, :platformIDInput);

-- Delete a gamePlatform
DELETE FROM gamePlatforms 
WHERE gamePlatformID = :gamePlatformIDInput;

-- Update a gamePlatform
UPDATE gamePlatforms 
SET gameID = :gameIDInput, platformID = :platformIDInput 
WHERE gamePlatformID = :gamePlatformIDInput;
