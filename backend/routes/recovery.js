const express = require('express')
const { forgetPassword, resetPassword } = require('../controllers/recovery.js')

const router = express.Router()

router.post('/forgetpassword', forgetPassword)
router.post('/resetpassword/:id/:token', resetPassword)

module.exports = router;