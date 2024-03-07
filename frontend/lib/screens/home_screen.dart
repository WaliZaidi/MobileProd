import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/app_nav_bar.dart';
import '../store/store.dart';
import '../theme/theme.dart';
import "../widgets/top_app_bar.dart";
import '../widgets/venue_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// class _HomeScreenState extends State<HomeScreen> {
//   bool _isLoading = true;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     debugShowMaterialGrid:
//     true;
//     fetchDataAndUpdateState();
//   }

//   Future<void> fetchDataAndUpdateState() async {
//     await AppDataStore.fetchDataAtAppLaunch();
//     _timer = Timer(const Duration(seconds: 5), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: CustomTheme.theme,
//       child: Scaffold(
//         appBar: const PreferredSize(
//           preferredSize: Size.fromHeight(140),
//           child: TopNavBar(),
//         ),
//         bottomNavigationBar: const AppNavBar(),
//         body: CustomScrollView(
//           slivers: [
//             if (AppDataStore.dataList.isNotEmpty)
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     final venue = AppDataStore.dataList[index];
//                     return VenueCardWidget(venue: venue);
//                   },
//                   childCount: AppDataStore.dataList.length,
//                 ),
//               )
//             else if (AppDataStore.dataList.isEmpty)
//               SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(),
//                       const SizedBox(height: 16),
//                       const Text('Establishing Connection...'),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           print('Retry button pressed');
//                           fetchDataAndUpdateState();
//                         },
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  late Timer _timer = Timer(Duration.zero, () => {});

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    debugShowMaterialGrid:
    true;
    fetchDataAndUpdateState();
  }

  // Future<void> fetchDataAndUpdateState() async {
  //   await AppDataStore.fetchDataAtAppLaunch();
  //   _timer = Timer(const Duration(seconds: 5), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  Future<void> fetchDataAndUpdateState() async {
    await AppDataStore.fetchDataAtAppLaunch();
    _timer = Timer(const Duration(seconds: 5), () {
      if (!mounted) {
        return; // Widget is disposed, do nothing
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(140),
          child: TopNavBar(),
        ),
        bottomNavigationBar: const AppNavBar(),
        body: CustomScrollView(
          slivers: [
            if (AppDataStore.dataList.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final venue = AppDataStore.dataList[index];
                    return VenueCardWidget(venue: venue);
                  },
                  childCount: AppDataStore.dataList.length,
                ),
              )
            else if (AppDataStore.dataList.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      const Text('Establishing Connection...'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          print('Retry button pressed');
                          fetchDataAndUpdateState();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
