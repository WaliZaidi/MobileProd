import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import your custom theme here
import '../store/store.dart'; // Import your store.dart file
import '../screens/search_results.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  void initState() {
    super.initState();
    AppDataStore.filteredVenues = AppDataStore.venues;
  }
}
