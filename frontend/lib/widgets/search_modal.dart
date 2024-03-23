import 'package:flutter/material.dart';
import '../store/store.dart';
import '../screens/search_results.dart';
import '../widgets/loader_bars.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String searchQuery;
  final TextEditingController _searchController = TextEditingController();
  late String selectedRatings;
  late String selectedTypeOfVenue;
  late String selectedCity;
  late String selectedPricePerPerson;
  late String selectedAccessibilityOptions;
  late String selectedCapacity;
  late String selectedRefundPolicy;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              0.0, MediaQuery.of(context).size.height * _animation.value),
          child: GestureDetector(
            onTap: () {
              _controller.reverse().then((value) {
                Navigator.pop(context);
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0), // Add padding here
                child: Material(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _controller.reverse().then((value) {
                                Navigator.pop(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Icon(Icons.arrow_back),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller:
                                    _searchController, //Assign the controller to the TextField
                                onChanged: (value) {
                                  //Save the value in the searchQuery variable
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              AppDataStore.filteredVenues.clear();
                              AppDataStore.resolveSearchQuery(searchQuery);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchResults(
                                    dynamicModifier: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Popular Searches',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppDataStore.filterVenues(
                                    selectedRatings = '',
                                    selectedTypeOfVenue = 'Banquet',
                                    selectedCity = '',
                                    selectedPricePerPerson = '',
                                    selectedAccessibilityOptions = '',
                                    selectedCapacity = '',
                                    selectedRefundPolicy = '',
                                  );

                                  // Wait for 2 seconds before navigating
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    LoaderBar.showLoading(
                                        context, 'Loading...');
                                    LoaderBar.showMessage(
                                        context, 'Selected: Banquet Halls');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResults(
                                                dynamicModifier: 2),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  width: 160, //Adjust the width as needed
                                  height: 160, //Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(
                                          'lib/images/banquet.jpg'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(
                                            0.3), //Adjust the opacity as needed
                                        BlendMode.srcOver, //Set the blend mode
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Banquet Halls',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppDataStore.filterVenues(
                                    selectedRatings = '',
                                    selectedTypeOfVenue = 'Birthday',
                                    selectedCity = '',
                                    selectedPricePerPerson = '',
                                    selectedAccessibilityOptions = '',
                                    selectedCapacity = '',
                                    selectedRefundPolicy = '',
                                  );

                                  // Wait for 2 seconds before navigating
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    LoaderBar.showLoading(
                                        context, 'Loading...');
                                    LoaderBar.showMessage(
                                        context, 'Selected: Birthday Parties');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResults(
                                                dynamicModifier: 2),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  width: 160, // Adjust the width as needed
                                  height: 160, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(
                                          'lib/images/birthday.jpg'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.srcOver,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Birthday Parties',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppDataStore.filterVenues(
                                    selectedRatings = '',
                                    selectedTypeOfVenue = 'Wedding',
                                    selectedCity = '',
                                    selectedPricePerPerson = '',
                                    selectedAccessibilityOptions = '',
                                    selectedCapacity = '',
                                    selectedRefundPolicy = '',
                                  );

                                  // Wait for 2 seconds before navigating
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    LoaderBar.showLoading(
                                        context, 'Loading...');
                                    LoaderBar.showMessage(
                                        context, 'Selected: Wedding Venues');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResults(
                                                dynamicModifier: 2),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  width: 160, // Adjust the width as needed
                                  height: 160, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(
                                          'lib/images/wedding.jpg'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.srcOver,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Wedding Venues',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppDataStore.filterVenues(
                                    selectedRatings = '',
                                    selectedTypeOfVenue = 'Corporate',
                                    selectedCity = '',
                                    selectedPricePerPerson = '',
                                    selectedAccessibilityOptions = '',
                                    selectedCapacity = '',
                                    selectedRefundPolicy = '',
                                  );

                                  // Wait for 2 seconds before navigating
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    LoaderBar.showLoading(
                                        context, 'Loading...');
                                    LoaderBar.showMessage(
                                        context, 'Selected: Corporate Events');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResults(
                                                dynamicModifier: 2),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  width: 160, // Adjust the width as needed
                                  height: 160, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(
                                          'lib/images/corporate.jpg'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.srcOver,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Corporate Events',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
