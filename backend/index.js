const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const appConnector = require('./connections/routerconnecter.js');
const dbConnector = require('./connections/dbconnecter.js');
const ws = require('ws');   

const app = express()
app.use(express.json())
app.use(cors())

app.use(bodyParser.json({limit: "30mb", extended: true})) //extended: true allows us to send complex objects in our request
app.use(bodyParser.urlencoded({limit: "30mb", extended: true})) //urlencoded is a way of sending data to the server

const PORT = process.env.PORT || 4000

appConnector(app);

dotenv.config()

dbConnector();

app.listen(PORT, '0.0.0.0', () => console.log(`Server running on port: ${PORT}`))


module.exports = app;
