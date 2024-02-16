// import 'package:flutter/material.dart';
// import '../widgets/property_type_list.dart';
// import '../widgets/filter_search.dart';
// import 'package:go_router/go_router.dart';
// import '../theme/theme.dart';

// class TopNavBar extends StatelessWidget {
//   const TopNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return SliverAppBar(
//       expandedHeight: 165,
//       floating: false,
//       pinned: true,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 1.0,
//               spreadRadius: 1.0,
//               offset: const Offset(0.0, 1.0),
//             ),
//           ],
//         ),
//         child: FlexibleSpaceBar(
//           collapseMode: CollapseMode.pin,
//           background: Padding(
//             padding: const EdgeInsets.only(top: 60.0),
//             child: Container(
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
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       context.pushNamed('booking-details');
//                     },
//                     child: Container(
//                       width: 60.0,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 8.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 0.5,
//                         ),
//                         borderRadius: BorderRadius.circular(32.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             blurRadius: 8.0,
//                             spreadRadius: 8.0,
//                             offset: const Offset(0.0, 4.0),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.search),
//                           const SizedBox(width: 8.0),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Where to?',
//                                 style: textTheme.bodyMedium!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Anywhere • Any week • Add events',
//                                 style: textTheme.bodyMedium,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Stack(
//                     children: [
//                       const Align(
//                         alignment: Alignment.bottomCenter,
//                         child: PropertyTypeList(),
//                       ),
//                       Positioned(
//                         top: 65.0,
//                         right: 8.0,
//                         child: IconButton(
//                           onPressed: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 return const Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 0),
//                                   child: FilterWidget(),
//                                 );
//                               },
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20.0),
//                                   topRight: Radius.circular(20.0),
//                                 ),
//                               ),
//                             );
//                           },
//                           icon: const Icon(Icons.tune),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// -----------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import '../widgets/property_type_list.dart';
// import '../widgets/filter_search.dart';
// import 'package:go_router/go_router.dart';
// import '../theme/theme.dart';

// class TopNavBar extends StatelessWidget {
//   const TopNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: AppBar(
//         toolbarHeight: 160, // Increased height
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 1.0,
//                 spreadRadius: 1.0,
//                 offset: const Offset(0.0, 1.0),
//               )
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           context.pushNamed('booking-details');
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                             vertical: 8.0,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: Colors.grey,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(32.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 blurRadius: 8.0,
//                                 spreadRadius: 8.0,
//                                 offset: const Offset(0.0, 4.0),
//                               ),
//                             ],
//                           ),
//                           child: const Row(
//                             children: [
//                               Icon(Icons.search),
//                               SizedBox(width: 8.0),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Where to?'),
//                                   Text('Anywhere • Any week • Add guest'),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           builder: (BuildContext context) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 0),
//                               child: FilterWidget(),
//                             );
//                           },
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20.0),
//                               topRight: Radius.circular(20.0),
//                             ),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.tune),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                     height: 16.0), // Add vertical spacing between rows
//                 const PropertyTypeList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../widgets/property_type_list.dart';
import '../widgets/filter_search.dart';
import 'package:go_router/go_router.dart';
import '../theme/theme.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0), // Add padding to the top of the screen
        child: AppBar(
          toolbarHeight: 160, // Increased height
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
                            context.pushNamed('booking-details');
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
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              // return Container(
                              //   decoration: const BoxDecoration(
                              //     borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(20.0),
                              //       topRight: Radius.circular(20.0),
                              //     ),
                              //   ),
                              //   child: const Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: FilterWidget(),
                              //   ),
                              // );
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: FilterWidget(),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.tune),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 16.0), // Add vertical spacing between rows
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
