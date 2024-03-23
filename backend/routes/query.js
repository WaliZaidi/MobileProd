const express = require('express')
const { query, queryByName } = require('../controllers/query.js')

const router = express.Router()

router.get('/search', query)
router.get('/search/name', queryByName)

module.exports = router;