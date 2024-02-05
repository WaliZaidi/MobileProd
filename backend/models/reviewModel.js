const mongoose = require('mongoose')

const reviewSchema = new mongoose.Schema({
    nameOfVenue: {
        type: String,
        required: true,
        min: 3,
        max: 30
    },
    totalScore: {
        type: Number,
    },
    rating: {
        type: String,
    },
    stars: {
        type: Number,
    },
    sentiment: {
        type: String,
        default: ''
    },
    text: {
        type: String,
    }
})

module.exports = mongoose.model('Review', reviewSchema)