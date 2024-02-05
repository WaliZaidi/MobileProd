const { MongoClient } = require('mongodb');

const MONGODB_URI = process.env.DATABASE_ACCESS;


let dbConnector = () => {
    MongoClient.connect(MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true }, (err, client) => {
        if (err) {
            console.error('Error connecting to MongoDB:', err);
            return;
        }
        console.log('Connected to MongoDB');
        db = client.db(); // Use your specific database if needed
    });

}

// let db;

// // Connect to MongoDB
// MongoClient.connect(MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true }, (err, client) => {
//   if (err) {
//     console.error('Error connecting to MongoDB:', err);
//     return;
//   }
//   console.log('Connected to MongoDB');
//   db = client.db(); // Use your specific database if needed
// });

module.exports = dbConnector;