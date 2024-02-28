import 'package:flutter/material.dart';
import '../widgets/app_nav_bar.dart';
import '../store/store.dart';
import '../theme/theme.dart';
import "../widgets/top_app_bar.dart";
import '../widgets/venue_card_widget.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: theme,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('Search Results'),
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: true,
            ),
            if (AppDataStore.filteredVenues.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final venue = AppDataStore.filteredVenues[index];
                    return VenueCardWidget(venue: venue);
                  },
                  childCount: AppDataStore.filteredVenues.length,
                ),
              )
            else if (AppDataStore.filteredVenues.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('No results found. Please try again.'),
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
