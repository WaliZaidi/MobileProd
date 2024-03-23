const backendService = require('../service/backendService.js')

const query = async (req, res) => {
    var returnOptions = await backendService.query(req, res);
    var venues = returnOptions[0];
    var currentPage = returnOptions[1];

    try {
        res.status(200).json({ venues, currentPage })
    }

    catch (err) {
        res.status(404).json({ message: err.message })
    }
}

const queryByName = async (req, res) => {
    var returnOptions = await backendService.queryByName(req, res);
    var venues = returnOptions;

    try {
        res.status(200).json({ venues})
    }

    catch (err) {
        res.status(404).json({ message: err.message })
    }
}

module.exports = { query, queryByName }