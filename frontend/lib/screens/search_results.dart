import 'package:flutter/material.dart';
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
