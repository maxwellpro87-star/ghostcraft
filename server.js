const express = require('express');
const app = express();
app.get('/', (req, res) => res.sendFile(__dirname + '/index.html'));
app.listen(3000, () => console.log('GhostCraft running on http://localhost:3000'));
// Full backend for generators, emails, etc.