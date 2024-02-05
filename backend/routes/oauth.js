const express = require('express')
const router = express.Router()
const dotenv = require('dotenv')
const { OAuth2Client } = require('google-auth-library')
const User = require('../models/userModel')


dotenv.config()

let googlePictureURL = ''

async function getUserData(access_token, res)
{
    const response = await fetch(`https://www.googleapis.com/oauth2/v3/userinfo?access_token=${access_token}`)
    const data = await response.json()

    console.log('data', data)
    
    const email = data.email

    const existingUser = await User.findOne({ email: email})

    if (existingUser)
    {
        console.log('User exists. Re-directing to home page')
        googlePictureURL = data.picture
        res.redirect('http://localhost:3000/home')
    }

    else
    {
        console.log('User does not exist. Re-directing to complete sign up')
        const redirectUrl = `http://localhost:3000/complete-signup`
        res.redirect(`${redirectUrl}?email=${encodeURIComponent(email)}&name=${encodeURIComponent(data.name)}`)
    }   
    

}

router.get('/login', async function (req, res) {
    const code = req.query.code

    try
    {
        const redirectUrl = 'http://localhost:4000/oauth/login';

        const oAuth2Client = new OAuth2Client(
            process.env.CLIENT_ID,
            process.env.CLIENT_SECRET,
            redirectUrl
        );

        const response = await oAuth2Client.getToken(code)
        await oAuth2Client.setCredentials(response.tokens)
        console.log('Tokens acquired')
        const user = oAuth2Client.credentials
        console.log('credentials', user)
        await getUserData(user.access_token, res)

    }

    catch (err)
    {
        console.log("Error signing into google: " + err)
    }
})

router.get('/picture', async function (req, res) {
    console.log("Sending picture URL to frontend")
    console.log(googlePictureURL)
    res.send(googlePictureURL)
})
module.exports = router

