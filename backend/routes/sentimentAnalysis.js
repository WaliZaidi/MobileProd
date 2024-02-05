const express = require('express');
const router = express.Router();
const backendService = require('../service/backendService');

router.post('/sentimentAnalysis', async (req, res) => {
    try {
        backendService.sentiment_analysis_script(req, res);
    }

    catch (err) {
        console.log(err)
    }
});

router.get('/sentimentAnalysis', async (req, res) => {
    try {
        backendService.updateReviewSentiment(req, res);
    }

    catch (err) {
        console.log(err)
    }
});

// router.post('/sentimentAnalysisUpdate', async (req, res) => {
//     try {
//         backendService.sentiment_analysis_update(req, res);
//     }

//     catch (err) {
//         console.log(err)
//     }
// }
// );

module.exports = router;