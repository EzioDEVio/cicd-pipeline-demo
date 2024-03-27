const express = require('express');
const path = require('path');
const app = express();

// Middleware to serve static files
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Additional endpoint to keep the /date functionality
app.get('/date', (req, res) => {
  res.send(`Current Date and Time: ${new Date().toISOString()}`);
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log(`Application is listening at http://localhost:${port}`);
});

module.exports = { app };
