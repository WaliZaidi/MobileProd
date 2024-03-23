import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import '../store/store.dart';
import '../theme/theme.dart';
import '../widgets/venue_card_widget.dart';

class SearchResults extends StatefulWidget {
  final int dynamicModifier;

  const SearchResults({Key? key, required this.dynamicModifier})
      : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  AppDataStore.filteredVenues.clear();
                  if (widget.dynamicModifier == 1) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else if (widget.dynamicModifier == 2 ||
                      widget.dynamicModifier == 3) {
                    Navigator.of(context).pop();
                  }
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
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red), // Error icon
                      const SizedBox(height: 16),
                      const Text(
                        'No venues found!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          print("Going home");
                        },
                        child: const Text(
                            'Back to Search?'), // Button to navigate back
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
