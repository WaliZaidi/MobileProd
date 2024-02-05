const venue = new Venue({
    nameOfVenue: 'Test Venue 1',
    locationOfVenue: 'Test Location 1',
    plusCode: '46220',
    typeOfVenue: ['Banquet, Wedding'],
    numberOfReviews: '1',
    serviceOptions: ['Catering', 'Decoration'],
    accessabilityOptions: ['Wheelchair Accessable'],
    rating: '3.4',
    parkingSpace: '149',
    numberOfSubhalls: '2',
    city: 'Islamabad',
    totalHallsCapacity: '200',
    refundPolicy: 'Yes',
    contactNumber: '1234567890',
    websiteLink: 'www.google.com',
    pricePerPerson: '1000',
    description: 'Test Description 1',
    verifiedStatus: true,
    menuOptions: ['Menu 1', 'Menu 2'],
    reviews: [
        {
            rating: '3.4',
            review: 'Test Review 1',
        }
    ],
    subVenues: [
        {
            nameOfSubVenue: 'Marco Polo',
            capacityOfSubVenue: '100',
            availableDates: [
                {
                    date: isoDateString,
                    startTime: '18:00',
                    endTime: '20:00'
                }
            ],
            menuOptions: [
                {
                    packageName: 'Basic Package',
                    packageDescription: 'Includes basic food items',
                    packageItems: [
                        {
                            itemCategoryName: 'Desserts',
                            itemOptions: [
                                {
                                    itemName: 'Kheer',
                                },
                                {
                                    itemName: 'Gulab Jamun',
                                }
                            ]
                            
                        },
    
                        {
                            itemCategoryName: 'Main Course',
                            itemOptions: [
                                {
                                    itemName: 'Chicken Karahi',
                                },
    
                                {
                                    itemName: 'Chicken Biryani',
                                },
    
                                {
                                    itemName: 'Live Roghni Naan (Variety)'
                                },
    
                                {
                                    itemName: 'Fresh Salad'
                                }
                            ]
                        },
                    ],
                    packagePrice: 1750
                }
            ],
    
            decorOptions: [
                {
                    decorName: 'Basic Wedding Decor',
                    forEventType: 'Wedding',
                    decorPrice: 8000
                },
    
                {
                    decorName: 'Premium Wedding Decor',
                    forEventType: 'Wedding',
                    decorPrice: 10000
                },
    
                {
                    decorName: 'Sound System',
                    forEventType: 'Wedding',
                    decorPrice: 5000
                },
    
                {
                    decorName: 'Birthday Decor',
                    forEventType: 'Birthday',
                    decorPrice: 5000
                }
            ],

            bookingCharges: [
                {
                    bookingChargeName: 'Venue Booking Charges',
                    bookingChargePrice: 40000
                },

                {
                    bookingChargeName: 'AC/Heating Charges',
                    bookingChargePrice: 10000
                }
            ]
        },
        {
            nameOfSubVenue: 'The Grand Ballroom',
            capacityOfSubVenue: '100',
            availableDates: [
                {
                    date: '2023-09-25',
                    startTime: '10:00',
                    endTime: '12:00'
                }
            ]
        }
    ],
    
})