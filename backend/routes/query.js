const express = require('express')
const { query } = require('../controllers/query.js')

const router = express.Router()

router.get('/search', query)

module.exports = router;