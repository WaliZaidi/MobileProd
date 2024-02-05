const User = require('../models/userModel.js')

const landingPage = async (req, res) => {
    try {
        const users = await User.find()
        res.status(200).json(users)
    }
    catch (err) {
        res.status(404).json({ message: err.message })
    }
}

module.exports = { landingPage }