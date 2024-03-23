const User = require('../models/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
// const venueModel = require('../models/venueModel');
const nodemailer = require('nodemailer');
// const bodyParser = require('body-parser');
const { exec } = require('child_process');
const Venue = require('../models/venueModel');

// const currentWorkingDirectory = process.cwd();

let forgetPassword = (req, res) => {
    const { email } = req.body

    User.findOne({email: email})
    .then(user => {
        if (!user)
        {
            return res.json({status: "Email not found"})
        }

        const token = jwt.sign({id: user._id}, process.env.SECRET_KEY, {expiresIn: '20m'})
        
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL,
                pass: process.env.PASSWORD,
            }
        })

        var mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: 'Reset Password Request for Festivo Account',
            text: `Dear ${user.name},\n\nWe have received a request to reset the password for your Festivo account. If you made this request, please click on the link below to reset your password. If you did not make this request, please ignore this email.\n\nhttp://localhost:3000/resetPassword/${user._id}/${token}\n\nRegards,\nFestivo Team`
        }

        transporter.sendMail(mailOptions, function(error, info){
            if (error) {
                console.log(error)
            } else {
                console.log('Email sent: ' + info.response) //info.response is the response from the server
                return res.json({status: "Success"})
            }
        })
    })
};

let resetPassword = (req, res) => {
    console.log("Reset Password route called. ID is: " + req.params.id + " and token is: " + req.params.token)
    const { id, token } = req.params
    const { password } = req.body

    jwt.verify(token, process.env.SECRET_KEY, (err, decodedToken) => {
        if (err)
        {
            return res.json({status: "Incorrect or Expired Link"})
        }

        else
        {
            bcrypt.hash(password, 10) //10 is the salt which is the number of rounds of hashing
            .then(hash => {
                User.findByIdAndUpdate({_id: id}, {password: hash})
                .then(u => res.send({status: "Success"}))
                .catch(err => res.send({status: err}))
            })
            .catch(err => res.send({status: err}))
        }
    })
}

let query = async (req, res) => {
    const page = parseInt(req.query.currentPage) //page number
        const limit = parseInt(req.query.limit) || 1 //limit of venues per page
        const search = req.query.searchQuery || '' //search query
        const rating = req.query.rating || ''
        const typeOfVenue = req.query.typeOfVenue || ''
        const city = req.query.city || ''
        const pricePerPerson = req.query.pricePerPerson || '' 
        const accessabilityOptions = req.query.accessabilityOptions || ''
        const totalHallsCapacity = req.query.totalHallsCapacity || ''
        const refundPolicy = req.query.refundPolicy || ''
        
        console.log("Here are the query parameters: ")
        console.log("page: " + page)
        console.log("limit: " + limit)
        console.log("search: " + search)
        console.log("rating: " + rating)
        console.log("typeOfVenue: " + typeOfVenue)
        console.log("city: " + city)
        console.log("pricePerPerson: " + pricePerPerson)
        console.log("accessabilityOptions: " + accessabilityOptions)
        console.log("totalHallsCapacity: " + totalHallsCapacity)
        console.log("refundPolicy: " + refundPolicy)


        const query = {}

        if (search)
        {
            query.nameOfVenue = {$regex: search, $options: 'i'}
        }

        const [minRating, maxRating] = rating.split('-').map(Number)

        if (!isNaN(minRating) && !isNaN(maxRating)) //if both minRating and maxRating are numbers
        {
            query.rating = {$gte: minRating, $lte: maxRating} //this will find the venues that have a rating greater than or equal to minRating and less than or equal to maxRating
        }

        if (typeOfVenue)
        {
            query.typeOfVenue = {$regex: typeOfVenue, $options: 'i'}
        }

        if (city)
        {
            query.city = city
        }

        
        if (pricePerPerson === '5000+')
        {
            query.pricePerPerson = {$gte: 5000}
        }

        else
        {
            const [minPricePerPerson, maxPricePerPerson] = pricePerPerson.split('-').map(Number) //this will split the totalHallsCapacity into two numbers and then map them to the minCapacity and maxCapacity variables

        
            if (!isNaN(minPricePerPerson) && !isNaN(maxPricePerPerson)) //if both minCapacity and maxCapacity are numbers
            {
                query.pricePerPerson = {$gte: minPricePerPerson, $lte: maxPricePerPerson} //this will find the venues that have a totalHallsCapacity greater than or equal to minCapacity and less than or equal to maxCapacity

            }
        }

        if (Array.isArray(accessabilityOptions))
        {
            query.accessabilityOptions = {$all: accessabilityOptions}
        }

        if (refundPolicy)
        {
            query.refundPolicy = refundPolicy
        }

        let venues = await Venue.find(query)
        // .limit(limit)
        // .skip((page - 1) * limit) //For example, if page is 1, we will skip 0 venues

        const totalVenues = await Venue.countDocuments(query) //this will give us the total number of venues after applying the query

        const totalPages = Math.ceil(totalVenues / limit) //this will give us the total number of pages

        //Process the halls capacity problem by adding in this code
        if (totalHallsCapacity === '1000+')
        {
            venues = venues.filter(venue => venue.totalHallsCapacity >= 1000)
        }

        else
        {
            const [minCapacity, maxCapacity] = totalHallsCapacity.split('-').map(Number) //this will split the totalHallsCapacity into two numbers and then map them to the minCapacity and maxCapacity variables

        
            if (!isNaN(minCapacity) && !isNaN(maxCapacity)) //if both minCapacity and maxCapacity are numbers
            {
                venues = venues.filter(venue => venue.totalHallsCapacity >= minCapacity && venue.totalHallsCapacity <= maxCapacity) //this will find the venues that have a totalHallsCapacity greater than or equal to minCapacity and less than or equal to maxCapacity

            }
        }

        let returnOption = [venues, totalPages, currentPage = page]
        return returnOption
}

const createVenue = async (req, res) => { 
    try {
        const {nameOfVenue, typeOfVenue, city, pricePerPerson, totalHallsCapacity, refundPolicy, accessabilityOptions, rating, description, website, mainImage, images} = req.body;
        const venue = new Venue({nameOfVenue, typeOfVenue, city, pricePerPerson, totalHallsCapacity, refundPolicy, accessabilityOptions, rating, description, address, phoneNumber, email, website, mainImage, images});
        const venueCreated = await venue.save();
        if(venueCreated){
            res.status(201).json({message:"Venue Created Successfully"});
        }
        else{
            res.status(500).json({message:"Unable to create Venue"})
        }
    }
    catch(err) {
        console.log(err);
    }
}

const signUp = async (req,res) => {
    try {
            const {name,email,phoneNumber,password,confirmPassword,cnic}=req.body;
            const Emailexists= await User.findOne({email:email});
            if (Emailexists) {
                return await res.status(422).json({error:"Email already exists"})
            }

            else if(!name || !email || !cnic || !phoneNumber || !password || !confirmPassword ){
                return await res.status(422).json({error:"Give input to all the fields"});
            }

            else if (password!=confirmPassword) {
                return await res.status(422).json({error:"Password Does not match"});
            }

            else {
                    const user = new User({name,email,phoneNumber, password,confirmPassword,cnic});
                    const userRegistered = await user.save();
                    if(userRegistered){
                        res.status(201).json({message:"User Registered Successfully"});
                    }
                    else{
                        res.status(500).json({message:"Unable to register User"})
                    }
            }
    }
    catch(err) {
        console.log(err);
    }

}

const login=async(req,res)=>{

    const {email, password}=req.body;
    if(!email || !password){
        return await res.status(422).json({error:"Give Input to all the fields"});
    }

    try{
        const userLogin=await User.findOne({email:email});
        if(userLogin){
            const passwordCheck=await bcrypt.compare(password,userLogin.password);
            token=await userLogin.generateauthtoken();
            if(!passwordCheck){
                res.status(400).json({error:"Invlaid Password"})
            }
            else{
                res.status(201).json({message:"User Login Successfully",token:token})
                
            }
        }else{
            res.status(400).json({error:"Invlaid Credentials"})
        }

    }catch(err){
        res.status(400).json({error:"err"});
        console.log(err);
    }

}

const venueDetail = async (req, res) => {
    try {
        console.log("Venue Detail route called. ID is: " + req.params.id)
        const venue = await Venue.findById(req.params.id);
        res.status(200).json(venue);
    }
    catch(err) {
        console.log(err);
    }
}

const queryByName = async (req, res) => {
    const search = req.query.searchQuery || '';
    const rating = req.query.rating || '';
    const typeOfVenue = req.query.typeOfVenue || '';
    const city = req.query.city || '';
    const pricePerPerson = req.query.pricePerPerson || ''; 
    const accessabilityOptions = req.query.accessabilityOptions || '';
    const totalHallsCapacity = req.query.totalHallsCapacity || '';
    const refundPolicy = req.query.refundPolicy || '';
        
    const query = {};

    console.log("Here are the query parameters FOR NAMES: ")
    console.log("search: " + search)
    console.log("rating: " + rating)
    console.log("typeOfVenue: " + typeOfVenue)
    console.log("city: " + city)
    console.log("pricePerPerson: " + pricePerPerson)
    console.log("accessabilityOptions: " + accessabilityOptions)
    console.log("totalHallsCapacity: " + totalHallsCapacity)
    console.log("refundPolicy: " + refundPolicy)


    if (search) {
        query.nameOfVenue = {$regex: search, $options: 'i'};
    }

    if (rating) {
        const [minRating, maxRating] = rating.split('-').map(Number);
        if (!isNaN(minRating) && !isNaN(maxRating)) {
            query.rating = {$gte: minRating, $lte: maxRating};
        }       
    }

    if (typeOfVenue) {
        query.typeOfVenue = {$regex: typeOfVenue, $options: 'i'};
    }

    if (city) {
        query.city = city;
    }

    if (pricePerPerson) {
        if (pricePerPerson === '5000+') {
            query.pricePerPerson = {$gte: 5000};
        } else {
            const [minPricePerPerson, maxPricePerPerson] = pricePerPerson.split('-').map(Number);
            if (!isNaN(minPricePerPerson) && !isNaN(maxPricePerPerson)) {
                query.pricePerPerson = {$gte: minPricePerPerson, $lte: maxPricePerPerson};
            }
        }
    }

    if (totalHallsCapacity) { 
        if (totalHallsCapacity === '1000+') {
            query.totalHallsCapacity = {$gte: 1000};
        } else {
            const [minCapacity, maxCapacity] = totalHallsCapacity.split('-').map(Number);
            if (!isNaN(minCapacity) && !isNaN(maxCapacity)) {
                query.totalHallsCapacity = {$gte: minCapacity, $lte: maxCapacity};
            }
        }
    }


    if (Array.isArray(accessabilityOptions) && accessabilityOptions.length > 0) {
        query.accessabilityOptions = {$all: accessabilityOptions};
    }

    if (refundPolicy) {
        query.refundPolicy = refundPolicy;
    }

    const venues = await Venue.find(query).select('nameOfVenue');

    const venueNames = venues.map(venue => venue.nameOfVenue);

    console.log(venueNames);

    return venueNames;
};



const sentiment_analysis_script = (req, res) => {
    const { reviews } = req.body;

    if (!reviews || !Array.isArray(reviews)) {
        return res.status(400).json({ error: 'Invalid input. Expected an array of reviews.' });
    }

    const reviewsString = reviews.map(review => `"${review}"`).join(' ');

    exec(`python sentimentAnalysisBatch.py ${reviewsString}`, { cwd: 'E:\\Wali\\Festivo\\server\\service'  }, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing sentiment analysis script: ${error}`);
            return res.status(500).json({ error: 'Internal server error' });
        }

        const sentimentResults = JSON.parse(stdout);
        res.json({ sentiments: sentimentResults });
    });
};


/*
ok what i need to do here, is basically, i can get the sentiment of whatever review(s) i pass to the sentimentAnalysisBatch.py script, now i need some way to feed it the data
so i'd like to take all the reviews that dont have a sentiment, put them into a json format, and give it to the sentiment_analysis_script, which then updates the rank of the venue
so i just need to make the collator, edit the review model for that, and then make the route for it
*/

const updateReviewSentiment = async (req, res) => {
    
    const venues = await Venue.find({});
    let count = 0;

    if (!venues || !Array.isArray(venues)) {
        return res.status(400).json({ error: 'Invalid input. Expected an array of venues.' });
    }

    for (let i = 0; i < venues.length; i++) {
        const venue = venues[i];
        const reviews = venue.reviews;
        for (let j = 0; j < reviews.length; j++) {
            const review = reviews[j];
            if (review.sentiment === '') {
                // const reviewSentiment = await getReviewSentiment(review.text);
                // review.sentiment = reviewSentiment;
                review.sentiment = sentiment_analysis_script(review.text);
                console.log("Review sentiment is: " + review.sentiment)


            }
        }
        // venue.save();
    }
    
    

   

    

    //now we need a loop that goes through all the venues, all of their reviews, and gets the sentiment for that review
}

// let sentiment_analysis_update = (req, res) => {
//     const { review, sentiment } = req.body;

//     exec(`python sentimentAnalysisUpdate.py "${review}" ${sentiment}`, { cwd: 'C:\\Users\\Student_2\\FYPWork\\Festivo\\server\\service' }, (error, stdout, stderr) => {
//         if (error) {
//             console.error(`Error executing sentiment analysis update script: ${error}`);
//             return res.status(500).json({ error: 'Internal server error' });
//         }

//         const sentimentResult = JSON.parse(stdout);
//         res.json({ sentiment: sentimentResult.sentiment });
//     });
// };

module.exports = {
    forgetPassword, resetPassword, query, signUp, login, venueDetail, queryByName, createVenue, sentiment_analysis_script, updateReviewSentiment //sentiment_analysis_update
}