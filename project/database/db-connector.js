/*
    Module is adapted from:
    Exploration - Web Application Technology Node.js starter code
*/

// Load variables from .env into process.env
require('dotenv').config();

// Get an instance of mysql we can use in the app
let mysql = require('mysql2')

// Create a 'connection pool' using credentials from environment variables
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : 10,
    host              : process.env.DB_HOST,
    user              : process.env.DB_USER,
    password          : process.env.DB_PASSWORD,
    database          : process.env.DB_NAME
}).promise(); // This makes it so we can use async / await rather than callbacks

// Export it for use in our application
module.exports = pool;
