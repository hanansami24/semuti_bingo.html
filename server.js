const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// SQLite Database Setup
const db = new sqlite3.Database('./bingo.db', (err) => {
    if (err) {
        console.error('Database error', err.message);
    } else {
        console.log('Connected to SQLite database for Sami Tsehaye - Semuti Bingo.');
        db.run(`CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            phone TEXT,
            balance INTEGER DEFAULT 0
        )`);

        db.run(`CREATE TABLE IF NOT EXISTS transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone TEXT,
            amount INTEGER,
            telebirr_account TEXT,
            status TEXT DEFAULT 'Pending',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )`);
    }
});

// API: Register User
app.post('/api/register', (req, res) => {
    const { username, phone } = req.body;
    db.run(`INSERT INTO users (username, phone, balance) VALUES (?, ?, 10)`, [username, phone], function(err) {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ success: true, userId: this.lastID, message: 'Welcome to Semuti Bingo by Sami Tsehaye!' });
    });
});

// API: Telebirr Deposit Request (ትክክለኛው ቁጥር: 0972226999)
app.post('/api/deposit', (req, res) => {
    const { phone, amount } = req.body;
    const targetTelebirr = '0972226999'; // ሳሚ ፀሀይ

    db.run(`INSERT INTO transactions (phone, amount, telebirr_account, status) VALUES (?, ?, ?, 'Pending')`, 
    [phone, amount, targetTelebirr], function(err) {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ success: true, message: `Deposit request to Sami Tsehaye's Telebirr (${targetTelebirr}) received successfully!` });
    });
});

app.listen(PORT, () => {
    console.log(`Semuti Bingo server running on port ${PORT}`);
});
