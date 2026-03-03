---------------------------------------------
-- Trophy Tracker - DDL and Sample Data
-- Group 84: Alexa Jauregui & Cody Strehlow
-- CS340 Project Step 2 (DRAFT)
---------------------------------------------

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS playerAchievements;
DROP TABLE IF EXISTS playerGames;
DROP TABLE IF EXISTS gamePlatforms;
DROP TABLE IF EXISTS Achievements;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Platforms;
DROP TABLE IF EXISTS Games;

-------------------------------------------------
-- CREATE TABLES
-------------------------------------------------

CREATE TABLE Players (
    playerID int AUTO_INCREMENT UNIQUE NOT NULL,
    username varchar(100) UNIQUE NOT NULL,
    email varchar(255) UNIQUE NOT NULL,
    PRIMARY KEY (playerID)
);

CREATE TABLE Games (
    gameID INT AUTO_INCREMENT UNIQUE NOT NULL,
    title varchar(255) NOT NULL,
    developer varchar(255) NOT NULL,
    releaseYear int NOT NULL,
    PRIMARY KEY (gameID)
);

CREATE TABLE Platforms (
    platformID INT UNIQUE AUTO_INCREMENT NOT NULL,
    name varchar(100) UNIQUE NOT NULL,
    manufacturer varchar(100) NOT NULL,
    PRIMARY KEY (platformID)
);

CREATE TABLE Achievements (
    achievementID INT UNIQUE AUTO_INCREMENT NOT NULL,
    gameID INT NOT NULL,
    platformID INT NOT NULL,
    achievementName varchar(255) NOT NULL,
    description text NOT NULL,
    isHidden BOOLEAN DEFAULT FALSE,
    rarityPercentage decimal(5,2),
    PRIMARY KEY (achievementID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (platformID) REFERENCES Platforms(platformID) ON DELETE CASCADE
);

CREATE TABLE playerGames (
    playerGameID INT UNIQUE AUTO_INCREMENT NOT NULL,
    gameID INT NOT NULL,
    playerID INT NOT NULL,
    PRIMARY KEY (playerGameID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (playerID) REFERENCES Players(playerID) ON DELETE CASCADE
);

CREATE TABLE playerAchievements (
    playerAchievementID INT AUTO_INCREMENT UNIQUE NOT NULL,
    playerID INT NOT NULL,
    achievementID INT NOT NULL,
    dateAchieved date NOT NULL,
    PRIMARY KEY (playerAchievementID),
    FOREIGN KEY (playerID) REFERENCES Players(playerID) ON DELETE CASCADE,
    FOREIGN KEY (achievementID) REFERENCES Achievements(achievementID) ON DELETE CASCADE
);

CREATE TABLE gamePlatforms (
    gamePlatformID INT AUTO_INCREMENT UNIQUE NOT NULL,
    gameID INT NOT NULL,
    platformID INT NOT NULL,
    PRIMARY KEY (gamePlatformID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (platformID) REFERENCES Platforms(platformID) ON DELETE CASCADE
);

-------------------------------------------------
-- INSERT SAMPLE DATA
-------------------------------------------------

INSERT INTO Games (title, developer, releaseYear)
VALUES ('The Legend of Zelda: Breath of the Wild', 'Nintendo', 2017),
('Elden Ring', 'FromSoftware', 2022),
('Stardew Valley', 'ConcernedApe', 2016),
('Hades', 'Supergiant Games', 2020),
('Celeste', 'Maddy Makes Games', 2018);

INSERT INTO Players (username, email)
VALUES ('ProGamer99', 'progamer99@gmail.com'),
('TrophyHunter', 'trophyhunter@gmail.com'),
('CasualPlayer', 'casualplayer@gmail.com'),
('SpeedRunner2024', 'speedrunner@gmail.com');

INSERT INTO Platforms (name, manufacturer)
VALUES ('PlayStation 5', 'Sony'),
('Xbox Series X', 'Microsoft'),
('Nintendo Switch', 'Nintendo'),
('Steam', 'Valve'),
('PlayStation 4', 'Sony');

-- Achievements using subqueries to look up gameID and platformID
INSERT INTO Achievements (gameID, platformID, achievementName, description, rarityPercentage)
VALUES (
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5'),
    'Elden Lord', 
    'Achieve the "Elden Lord" ending', 
    45.30
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5'),
    'Legendary Armaments', 
    'Acquire all 9 legendary armaments', 
    5.20
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5'),
    'Shardbear Godrick', 
    'Defeat Shardbear Godrick', 
    78.40
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'Steam'),
    'Elden Lord', 
    'Achieve the "Elden Lord" ending', 
    42.10
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'Steam'),
    'Legendary Armaments', 
    'Acquire all 9 legendary armaments', 
    4.80
);

-- gamePlatforms using subqueries to lookup gameID and platformID
INSERT INTO gamePlatforms (gameID, platformID)
VALUES (
    (SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Breath of the Wild'),
    (SELECT platformID FROM Platforms WHERE name = 'Nintendo Switch')
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'Xbox Series X')
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT platformID FROM Platforms WHERE name = 'Steam')
),
(
    (SELECT gameID FROM Games WHERE title = 'Stardew Valley'),
    (SELECT platformID FROM Platforms WHERE name = 'Nintendo Switch')
);

-- playerGames using subqueries to lookup gameID and playerID
INSERT INTO playerGames (gameID, playerID)
VALUES (
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT playerID FROM Players WHERE username = 'ProGamer99')
),
(
    (SELECT gameID FROM Games WHERE title = 'Elden Ring'),
    (SELECT playerID FROM Players WHERE username = 'TrophyHunter')
),
(
    (SELECT gameID FROM Games WHERE title = 'Stardew Valley'),
    (SELECT playerID FROM Players WHERE username = 'TrophyHunter')
),
(
    (SELECT gameID FROM Games WHERE title = 'Stardew Valley'),
    (SELECT playerID FROM Players WHERE username = 'CasualPlayer')
),
(
    (SELECT gameID FROM Games WHERE title = 'Hades'),
    (SELECT playerID FROM Players WHERE username = 'ProGamer99')
);

-- playerAchievements using subqueries to look up playerID and achievementID
INSERT INTO playerAchievements (playerID, achievementID, dateAchieved)
VALUES (
    (SELECT playerID FROM Players WHERE username = 'ProGamer99'),
    (SELECT achievementID FROM Achievements 
     WHERE achievementName = 'Elden Lord' 
       AND platformID = (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')),
    '2024-03-15'
),
(
    (SELECT playerID FROM Players WHERE username = 'ProGamer99'),
    (SELECT achievementID FROM Achievements 
     WHERE achievementName = 'Legendary Armaments' 
       AND platformID = (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')),
    '2024-04-22'
),
(
    (SELECT playerID FROM Players WHERE username = 'ProGamer99'),
    (SELECT achievementID FROM Achievements 
     WHERE achievementName = 'Shardbear Godrick' 
       AND platformID = (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')),
    '2024-03-10'
),
(
    (SELECT playerID FROM Players WHERE username = 'TrophyHunter'),
    (SELECT achievementID FROM Achievements 
     WHERE achievementName = 'Elden Lord' 
       AND platformID = (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')),
    '2024-06-12'
),
(
    (SELECT playerID FROM Players WHERE username = 'TrophyHunter'),
    (SELECT achievementID FROM Achievements 
     WHERE achievementName = 'Shardbear Godrick' 
       AND platformID = (SELECT platformID FROM Platforms WHERE name = 'PlayStation 5')),
    '2024-06-05'
);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
