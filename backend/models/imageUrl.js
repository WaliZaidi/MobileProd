const mongoose = require('mongoose')

const imageUrlSchema = new mongoose.Schema({
    nameOfVenue: {
        type: String,
        required: true,
        min: 3,
        max: 30
    },
    link1: { 
        type: String,
        required: true,
    },
    link2: { 
        type: String,
        required: false,
    },
    link3: { 
        type: String,
        required: false,
    },
    link4: { 
        type: String,
        required: false,
    },
    link5: { 
        type: String,
        required: false,
    },
})

module.exports = mongoose.model('ImageUrl', imageUrlSchema)