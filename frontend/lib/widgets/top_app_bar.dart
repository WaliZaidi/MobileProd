import 'package:flutter/material.dart';
import '../widgets/property_type_list.dart';
import '../widgets/filter_search.dart';
import '../widgets/search_modal.dart';
import '../widgets/top_modal.dart'; 
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0), // Add padding to the top of the screen
        child: AppBar(
          toolbarHeight: 200, // Increased height
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0.0, 1.0),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return const TopModal(
                                  child: SearchModal(),
                                );
                              },
                            ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.8, // Change the width of the search bar
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 8.0,
                                  spreadRadius: 8.0,
                                  offset: const Offset(0.0, 4.0),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Where to?'),
                                    Text('Anywhere • Any week • Add guest'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0), // Adjust the padding as needed
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 120, 120, 120),
                              width: 0.3, // Adjust the width as needed
                            ),
                            borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                          ),
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) => SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.8, // Adjust the fraction as needed
                                      width: double.infinity,
                                  child: const FilterWidget(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.tune),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 6.0), // Add vertical spacing between rows
                  const PropertyTypeList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
