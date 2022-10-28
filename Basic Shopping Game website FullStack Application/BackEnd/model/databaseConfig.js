//name: Muhammad Nuhsyah Putra Bin Ramlee
//adminNumber:2045302
//class:DIT/FT/1B02
const mysql = require("mysql");

var dbconnect = {
  getConnection: function () {
    var conn = mysql.createConnection({
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'Putra2206', //your own password
      database: 'sp_games',
      dateStrings: true
    });
    return conn;
  }
};

// put this at the end of the file
module.exports = dbconnect;