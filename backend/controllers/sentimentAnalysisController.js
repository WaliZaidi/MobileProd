const backendService = require('../service/backendService');

const sentimentAnalysisController = async (req, res) => {
    try {
        backendService.sentimentAnalysis(req, res);
    }

    catch (err) {
        console.log(err)
    }
}

const sentimentAnalysisUpdateController = async (req, res) => {
    try {
        backendService.updateReviewSentiment(req, res);
    }

    catch (err) {
        console.log(err)
    }
}

// const sentimentAnalysisUpdateController = async (req, res) => {
//     try {
//         backendService.sentimentAnalysisUpdate(req, res);
//     }

//     catch (err) {
//         console.log(err)
//     }
// }

module.exports = { sentimentAnalysisController, sentimentAnalysisUpdateController }