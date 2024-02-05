const mongoose = require('mongoose')
const subVenueSchema = require('./subVenueModel').schema
const reviewSchema = require('./reviewModel').schema
const imageUrlSchema = require('./imageUrl').schema

const venueSchema = new mongoose.Schema({
    timestamp: {
        type: String,
        required: false,
    },
    ranking: {
        type: String,
        required: false,
    },
    nameOfVenue: {
        type: String,  
        required: true,
        min: 3,
        max: 30
    },
    locationOfVenue: {
        type: String,
        required: true,
        min: 3,
        max: 255
    },
    plusCode: {
        type: String, 
        required: false
    },
    typeOfVenue: {
        type: [String],
        required: true
    },
    numberOfReviews: {
        type: String,
        required: true
    },
    serviceOptions: {
        type: [String],
        required: true
    },
    accessabilityOptions: {
        type: [String],
        required: false
    },
    rating: {
        type: String,
        required: true,
    },
    parkingSpace: {
        type: String,
        required: true,
        min: 0,
        max: 150
    },
    numberOfSubhalls: {
        type: String,
        required: true,
        min: 1,
        max: 7
    },
    city: {
        type: String,
        required: true
    },
    totalHallsCapacity: {
        type: String,
        required: true
    },
    refundPolicy: {
        type: [String],
        required: true
    },
    contactNumber: {
        type: String,
        required: true
    },
    websiteLink: {
        type: String,
    },
    pricePerPerson: {
        type: Number,
        required: true
    },
    description: {
        type: String,
        required: false
    },
    arEnabled: {
        type: Boolean,
        required: true
    },
    paranomaEnabled: {
        type: Boolean,
        required: true
    },
    verifiedStatus: {
        type: Boolean,
        required: true
    },
    images: [imageUrlSchema],
    wifi: {
        type: Boolean,
    },
    wifiCost: {
        type: Number,
    },
    subVenues: [subVenueSchema],
     //Array of subVenueSchema

    reviews: [reviewSchema]

})

module.exports = mongoose.model('Venue', venueSchema)