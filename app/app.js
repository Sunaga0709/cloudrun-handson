const express = require("express");
const mysql = require("mysql");
const app = express();
const port = 8080;

// Create connection・・・１
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Connect・・・２
db.connect((err) => {
  console.log("error: ", err);
  if (err) {
    throw err;
  }
  console.log("MySQL Connected...");

  let sql = `CREATE TABLE IF NOT EXISTS users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
  )`;
  db.query(sql, (err, result) => {
    if (err) throw err;
    console.log("User table created...");

    // Insert dummy data
    sql = `INSERT INTO users(name, email) VALUES
      ('John Doe', 'john@gmail.com'),
      ('Jane Doe', 'jane@gmail.com')`;
    db.query(sql, (err, result) => {
      if (err) throw err;
      console.log("Inserted dummy data...");
    });
  });
});

// Route Handler ・・・３
app.get("/", (req, res) => {
  let sql = "SELECT * FROM users";
  let query = db.query(sql, (err, results) => {
    if (err) throw err;
    res.send(results);
  });
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
