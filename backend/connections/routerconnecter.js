const landingPageRoute = require('../routes/landingpage');
const recoveryRoute = require('../routes/recovery');
const testRoute = require('../routes/test');
const queryRoute = require('../routes/query');
const authRoute = require('../routes/auth')
const googleRoute = require('../routes/google')
const oauthRoute = require('../routes/oauth')
const venueDetail = require('../routes/venueDetail')
const sentimentAnalysisRoute = require('../routes/sentimentAnalysis');

let appConnector = (express) => {
    express.use('/', landingPageRoute);
    express.use('/recovery', recoveryRoute);
    express.use('/test', testRoute);
    express.use('/query', queryRoute);
    express.use('/auth', authRoute);
    express.use('/google', googleRoute);
    express.use('/oauth', oauthRoute);
    express.use('/venues', venueDetail);
    express.use('/sentiment', sentimentAnalysisRoute);
}

module.exports = appConnector;