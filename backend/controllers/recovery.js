const backendService = require('../service/backendService.js')

const forgetPassword = async (req, res) => {
    try {
        backendService.forgetPassword(req, res);
    }

    catch (err) {
        console.log(err)
    }
}

const resetPassword = async (req, res) => {

    try {
        backendService.resetPassword(req, res);
    }
    catch (err) {
        console.log(err)
    }

    // console.log("Reset Password route called. ID is: " + req.params.id + " and token is: " + req.params.token)
    // const { id, token } = req.params
    // const { password } = req.body

    // jwt.verify(token, process.env.SECRET_KEY, (err, decodedToken) => {
    //     if (err)
    //     {
    //         return res.json({status: "Incorrect or Expired Link"})
    //     }

    //     else
    //     {
    //         bcrypt.hash(password, 10) //10 is the salt which is the number of rounds of hashing
    //         .then(hash => {
    //             User.findByIdAndUpdate({_id: id}, {password: hash})
    //             .then(u => res.send({status: "Success"}))
    //             .catch(err => res.send({status: err}))
    //         })
    //         .catch(err => res.send({status: err}))
    //     }
    // })
}

module.exports = { forgetPassword, resetPassword }