const User = require('../models/userModel.js');
const bcrypt = require('bcryptjs');
const backendService = require('../service/backendService.js');

require("dotenv").config();

const signUp = async (req, res) => {
    try {
        backendService.signUp(req, res);
    }

    catch (err) {
        console.log(err)
    }
}

const login = async (req, res) => {
    try {
        backendService.login(req, res);
    }

    catch (err) {
        console.log(err)
    }
}




module.exports={
    signUp,
    login
}