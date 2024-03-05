import 'package:flutter/material.dart';
import '../store/store.dart';
import '../screens/search_results.dart';

// class SearchModal extends StatefulWidget {
//   const SearchModal({Key? key}) : super(key: key);

//   @override
//   _SearchModalState createState() => _SearchModalState();
// }

// class _SearchModalState extends State<SearchModal>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late String searchQuery;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _animation = Tween<double>(
//       begin: -1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     //dispose the controller after the work is done
//     _controller.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(
//               0.0, MediaQuery.of(context).size.height * _animation.value),
//           child: GestureDetector(
//             onTap: () {
//               _controller.reverse().then((value) {
//                 Navigator.pop(context);
//               });
//             },
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.3,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 1.0,
//                     spreadRadius: 1.0,
//                     offset: const Offset(0.0, 1.0),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 15.0), // Add padding here
//                 child: Material(
//                   // Wrap TextField with Material widget
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               _controller.reverse().then((value) {
//                                 Navigator.pop(context);
//                               });
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                             ),
//                             child: const Icon(Icons.arrow_back),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextField(
//                                 controller:
//                                     _searchController, // Assign the controller to the TextField
//                                 onChanged: (value) {
//                                   // Save the value in the searchQuery variable
//                                   setState(() {
//                                     searchQuery = value;
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   hintText: 'Search',
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.search),
//                             onPressed: () {
//                               // Add your search logic here, using the searchQuery variable
//                               AppDataStore.resolveSearchQuery(searchQuery);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const SearchResults(
//                                         dynamicModifier: 2)),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       // Add more search widgets or content here
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Add this import statement at the top
import 'package:flutter/material.dart';

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
                  // Wrap TextField with Material widget
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
                                    _searchController, // Assign the controller to the TextField
                                onChanged: (value) {
                                  // Save the value in the searchQuery variable
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
                              // Add your search logic here, using the searchQuery variable
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for this button
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                            child: Container(
                              width: 64, // Adjust the width as needed
                              height: 64, // Adjust the height as needed
                              child: const Icon(Icons.filter_1,
                                  size: 32), // Add icon inside the button
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for this button
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                            child: Container(
                              width: 64, // Adjust the width as needed
                              height: 64, // Adjust the height as needed
                              child: const Icon(Icons.filter_2,
                                  size: 32), // Add icon inside the button
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for this button
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 255, 255, 255),
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                            child: Container(
                              width: 64, // Adjust the width as needed
                              height: 64, // Adjust the height as needed
                              child: const Icon(Icons.filter_3,
                                  size: 32), // Add icon inside the button
                            ),
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
