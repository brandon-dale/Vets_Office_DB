const mysql = require('mysql');

// Create a new mysql database connection
const connection = mysql.createConnection({
    debug: false,
    host: '127.0.0.1',
    port: 3306,
    database: 'bdale_cs355sp23',
    user: 'bdale_cs355sp23',
    password: 'da008030380',
});

// Export the above database connection
module.exports = connection;