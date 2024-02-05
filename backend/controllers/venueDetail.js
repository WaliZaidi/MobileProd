const backendService = require('../service/backendService.js')

const venueDetail = async (req, res) => {
    try {
        backendService.venueDetail(req, res);
    }

    catch (err) {
        console.log(err)
    }
}

module.exports = { venueDetail }