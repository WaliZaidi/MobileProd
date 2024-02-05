const express = require('express')
const router = express.Router()
const { OAuth2Client } = require('google-auth-library')

const dotenv = require('dotenv')
dotenv.config()

router.post('/login', async function (req, res) {
    console.log("I am called wipee")
    res.header('Access-Control-Allow-Origin', '*')
    res.header('Referrer-Policy', 'no-referrer')

    const redirectUrl = 'http://localhost:4000/oauth/login'

    const oAuth2Client = new OAuth2Client(
        process.env.CLIENT_ID,
        process.env.CLIENT_SECRET,
        redirectUrl
    );

    const authorizeUrl = oAuth2Client.generateAuthUrl({
        access_type: 'offline',
        scope: 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email openid',
        prompt: 'consent'
    })

    res.json({ url: authorizeUrl })

    
})

module.exports = router
