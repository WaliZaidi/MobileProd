const express = require('express')
const User = require('../models/userModel.js')
const Venue = require('../models/venueModel.js')

const router = express.Router()

router.get('/adduser', (req, res) => {
    res.send('Add user')

    const user = new User({
        name: 'Sheheryar',
        email: 'younis.sheheryar12@outlook.com',
        password: '123456',
        CNIC: '1234567890123',
        phone: '1234567890'
    })

    user.save()
    .then(result => {
        console.log(result)
    })
    .catch(err => {
        console.log(err)
    })
})

router.get('/addvenue', (req, res) => {
    const venue = new Venue({
        nameOfVenue: 'Test Venue 1',
        locationOfVenue: 'Test Location 1',
        plusCode: '46220',
        typeOfVenue: ['Banquet, Wedding'],
        numberOfReviews: '1',
        serviceOptions: ['Catering', 'Decoration'],
        accessabilityOptions: ['Wheelchair Accessable'],
        rating: '3.4',
        parkingSpace: '149',
        numberOfSubhalls: '2',
        city: 'Islamabad',
        totalHallsCapacity: '200',
        refundPolicy: 'Yes',
        contactNumber: '1234567890',
        websiteLink: 'www.google.com',
        pricePerPerson: '1000',
        description: 'Test Description 1',
        verifiedStatus: true,
        menuOptions: ['Menu 1', 'Menu 2'],
        subVenues: [
            {
                nameOfSubVenue: 'Test SubVenue 1',
                capacityOfSubVenue: '100',
                availableTimeSlots: [
                    {
                        startTime: '10:00',
                        endTime: '12:00'
                    }
                ]
            },
            {
                nameOfSubVenue: 'Test SubVenue 2',
                capacityOfSubVenue: '100',
                availableTimeSlots: [
                    {
                        startTime: '10:00',
                        endTime: '12:00'
                    }
                ]
            }
        ]
    })

    venue.save()

    console.log("Test function executed successfully")
})

module.exports = router;