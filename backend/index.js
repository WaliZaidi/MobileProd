const express = require('express');
const { createServer } = require('http'); // Import http module
const { Server } = require('ws');
const dotenv = require('dotenv');
const cors = require('cors');
const bodyParser = require('body-parser');
const appConnector = require('./connections/routerConnection');
const {dbConnector} = require('./connections/databaseConnection');

const PORT = process.env.PORT || 3000;

// Create an HTTP server and listen on the same port as your Express app
const server = createServer(express().use((req, res) => res.send('Hello World')));
const wss = new Server({ server });

// The existing Express app
const app = express();
app.use(express.json());
app.use(cors());
app.use(bodyParser.json({ limit: '30mb', extended: true }));
app.use(bodyParser.urlencoded({ limit: '30mb', extended: true }));

// WebSocket connection handling
wss.on('connection', (ws) => {
  console.log('Client connected');
  ws.on('close', () => console.log('Client disconnected'));
});

wss.on('message', (message) => {
  console.log('Received message => ', message);
});

// Include your existing routes
appConnector(app);

dotenv.config();

// Start both HTTP and WebSocket servers on the same port
server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

dbConnector();

module.exports = app;