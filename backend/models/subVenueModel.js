const mongoose = require('mongoose')

const subVenueSchema = new mongoose.Schema({
    nameOfSubVenue: {
        type: String,
        required: true,
        min: 3,
        max: 50
    },

    capacityOfSubVenue: {
        type: Number,
        required: true,
        min: 0
    },

    availableDates: [
        {
            date: {
                type: Date,
                required: true
            },
            
            startTime: {
                type: String,
                required: true
            },

            endTime: {
                type: String,
                required: true
            }
        }
    ],

    menuOptions: [
        {
            packageName: {
                type: String,
                required: true
            },

            packageDescription: {
                type: String,
                required: true
            },

            packageItems: [
                {
                    itemCategoryName: {
                        type: String,
                        required: true
                    },

                    itemOptions: [
                        {
                            itemName: {
                                type: String,
                                required: true
                            }
                        }
                    ]
                }
            ],

            packagePrice: {
                type: Number,
                required: true
            }
        }
    ],

    decorOptions: [
        {
            decorName: {
                type: String,
                required: true
            },

            forEventType: {
                type: String,
                required: true
            },

            decorPrice: {
                type: Number,
                required: true
            }
        }
    ],

    bookingCharges: [
        {
            bookingChargeName: {
                type: String,
                required: true
            },

            bookingChargePrice: {
                type: Number,
                required: true
            }
        }
    ]

})

module.exports = mongoose.model('SubVenue', subVenueSchema)