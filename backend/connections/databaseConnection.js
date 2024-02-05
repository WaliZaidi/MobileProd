const { MongoClient } = require('mongodb');

const MONGO_URL = process.env.MONGO_URL;
let db; // Declare db variable here

let dbConnector = async () => {
    try {
        const client = await MongoClient.connect(MONGO_URL, { useNewUrlParser: true, useUnifiedTopology: true });
        db = client.db(); // Use your specific database if needed
        console.log('Connected to MongoDB');
    } catch (err) {
        console.error('Error connecting to MongoDB:', err);
    }
}

module.exports = { dbConnector, db };
