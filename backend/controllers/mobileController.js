const mobileBackendService = require('../service/mobileService');

const mobileMessage = async (req, res) => {
    try {
        mobileBackendService.mobileMessage(req, res);
    }

    catch (err) {
        console.log(err)
    }
}


module.exports = { mobileMessage }