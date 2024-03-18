import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/mobile_API.dart';
import 'package:frontend/widgets/loader_bars.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  bool _fetchFailed = false;
  late Timer _timer = Timer(Duration.zero, () => {});

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    debugShowMaterialGrid:
    true;
    fetchDataAndUpdateState();
  }

  Future<void> fetchDataAndUpdateState() async {
    try {
      await AppDataStore.fetchDataAtAppLaunch();
      // Data fetched successfully, do something if needed
    } on Exception {
      // Fetching data failed
      setState(() {
        _fetchFailed = true; // Set a flag to indicate fetch failure
        _isLoading = false; // Stop the loading indicator
      });
    }
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
                      if (_isLoading)
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Establishing Connection...'),
                          ],
                        ),
                      if (_fetchFailed)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('lib/assets/disruption.png'),
                              width: 60, // Set the desired width
                              height: 60, // Set the desired height
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Something went wrong!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Check your internet connection and try again.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                  _fetchFailed = false;
                                });
                                fetchDataAndUpdateState();
                                LoaderBar.showLoading(context, 'Retrying...');
                              },
                              child: const Text('Retry'),
                            ),
                          ],
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
