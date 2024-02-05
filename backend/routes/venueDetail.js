const express = require('express')
const { venueDetail } = require('../controllers/venueDetail.js')
const router = express.Router()

router.get('/:id', venueDetail)

module.exports = router