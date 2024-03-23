const mongoose = require('mongoose');

let dbConnector = async() => {
    try {
        await mongoose.connect(process.env.MONGO_URL, {
                useNewUrlParser: true, //these are just to get rid of warnings
                useUnifiedTopology: true
            });
        console.log('Connected to DB');
    }
    catch (err) {
        console.log('Error connecting to DB');
    }
}

module.exports = dbConnector;