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
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // ignore: unused_label
    debugShowMaterialGrid:
    true;
    AppDataStore.fetchDataAtAppLaunch().then((_) {
      _timer = Timer(const Duration(seconds: 5), () {
        setState(() {
          _isLoading = false;
        });
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
            // const TopNavBar(),
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
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Establishing Connection...'),
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
