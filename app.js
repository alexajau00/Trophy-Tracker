/**
 * Code Adapted from CS340 bsg_people sample web application
 */
// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 5206;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/players', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = 'SELECT * FROM Players;';
        const [players] = await db.query(query1);

        // Render the players.hbs file, and also send the renderer
        //  an object that contains our players information
        res.render('players', { players: players });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.post('/players/add', async function (req, res) {
    try {
        const username = req.body.create_player_username;
        const email = req.body.create_player_email;

        const query1 = `INSERT INTO Players (username, email) \
        VALUES (?, ?);`;

        await db.query(query1, [username, email]);

        res.redirect('/players');
    } catch (error) {
        console.error('Error inserting player:', error);
        res.status(500).send(
            'Error inserting player.');
    }
});

app.post('/players/delete', async function(req, res) {
    try {
        const playerID = req.body.delete_player_ID;

        const query1 = `DELETE FROM Players WHERE playerID = ?;`;

        db.pool.query(query1, [playerID]);

        res.redirect('/players');
    } catch (error) {
        console.log(error);
        res.status(400).send(
            'Error deleting player.'
        );
    }
});

app.post('/players/update', async function(req, res) {
    try{
        const playerID = req.body.update_player_id;
        const username = req.body.update_player_username;
        const email = req.body.update_player_email;

        const query1 = `UPDATE Players \
        SET username = ?, email = ? \
        WHERE playerID = ?;`;

        db.pool.query(query1, [username, email, playerID]);
    } catch (error) {
        console.log(error);
        res.status(400).send(
            'Error updating player.'
        )
    }
    res.redirect('/players');
});

app.get('/games', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = 'SELECT * FROM Games;';
        const [games] = await db.query(query1);

        // Render the games.hbs file, and also send the renderer
        //  an object that contains our games information
        res.render('games', { games: games });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/platforms', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = 'SELECT * FROM Platforms;';
        const [platforms] = await db.query(query1);

        // Render the platforms.hbs file, and also send the renderer
        //  an object that contains our platforms information
        res.render('platforms', { platforms: platforms });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/achievements', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = `SELECT Achievements.achievementID, Games.title, Platforms.name, \
        Achievements.achievementName, Achievements.isHidden, Achievements.rarityPercentage \
        FROM Achievements JOIN Games ON Achievements.gameID = Games.gameID \
        JOIN Platforms ON Achievements.platformID = Platforms.platformID;`;
        const [achievements] = await db.query(query1);

        // Render the acheivements.hbs file, and also send the renderer
        //  an object that contains our acheivements information
        res.render('achievements', { achievements: achievements });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/players_games', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = `SELECt playerGames.playerGameID, playerGames.playerID, playerGames.gameID, Players.username, Games.title\ 
        FROM playerGames JOIN Players On playerGames.playerID = Players.playerID \
        JOIN Games ON playerGames.gameID = Games.gameID;`;

        const query2 = `SELECT playerID, username FROM Players;`

        const query3 = `SELECT gameID, title FROM Games;`
        
        const [playerGames] = await db.query(query1);
        const [users] = await db.query(query2);
        const [games] = await db.query(query3);

        // Render the player_games.hbs file, and also send the renderer
        //  an object that contains our player game information
        res.render('players_games', { playerGames: playerGames, users, games });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.post('/players_games/add', async function (req, res) {
    try {
        const playerID = req.body.create_playerGames_username;
        const gameID = req.body.create_playerGames_title;

        const query1 = `INSERT INTO playerGames (playerID, gameID) \
        VALUES (?, ?);`;

        await db.query(query1, [playerID, gameID]);

        res.redirect('/players_games');
    } catch (error) {
        console.error('Error inserting playerGames:', error);
        res.status(500).send(
            'Error inserting playerGames.');
    }
});

app.post('/players_games/delete', function(req, res) {
    try {
        const playerGameID = req.body.delete_playerGame_ID;

        const query1 = `DELETE FROM playerGames WHERE playerGameID = ?;`;

        db.pool.query(query1, [playerGameID]);
    } catch (error) {
        console.log(error);
        res.status(400).send(
            'Error deleting Players Games.'
        );
    }
    res.redirect('/players_games');
});

app.get('/players_achievements', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = `SELECT playerAchievements.playerAchievementID, playerAchievements.playerID, playerAchievements.achievementID, Players.username, Achievements.achievementName, playerAchievements.dateAchieved\ 
        FROM playerAchievements JOIN Players ON playerAchievements.playerID = Players.playerID\ 
        JOIN Achievements On playerAchievements.achievementID = Achievements.achievementID;`;
        
        const query2 = `SELECT playerID, username FROM Players;`

        const query3 = `SELECT achievementID, achievementName FROM Achievements;`

        const [playerAchievements] = await db.query(query1);
        const [players] = await db.query(query2);
        const [achievements] = await db.query(query3);

        // Render the acheivements.hbs file, and also send the renderer
        //  an object that contains our player acheivements information
        res.render('players_achievements', { playerAchievements: playerAchievements, players, achievements });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/game_platforms', async function (req, res) {
    try {
        // Create and execute our queries
        const query1 = `SELECT gamePlatforms.gamePlatformID, gamePlatforms.gameID, gamePlatforms.platformID, Games.title, Platforms.name\ 
        FROM gamePlatforms JOIN Games On gamePlatforms.gameID = Games.gameID\ 
        JOIN Platforms ON gamePlatforms.platformID = Platforms.platformID`;

        const query2 = `SELECT gameID, title FROM Games;`

        const query3 = `SELECT platformID, name FROM Platforms;`

        const [gamePlatforms] = await db.query(query1);
        const [games] = await db.query(query2);
        const [platforms] = await db.query(query3);

        // Render the game_platforms.hbs file, and also send the renderer
        //  an object that contains our game platform information
        res.render('game_platforms', { gamePlatforms: gamePlatforms, games, platforms });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});