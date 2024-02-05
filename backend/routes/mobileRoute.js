const express = require('express');

const { mobileMessage } = require('../controllers/mobileController');

const router = express.Router();

router.get('/echo', mobileMessage);

module.exports = router;