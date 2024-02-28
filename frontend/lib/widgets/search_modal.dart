import 'package:flutter/material.dart';

class SearchModal extends StatelessWidget {
  SearchModal({super.key});

  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: controller,
      builder:(context, controller) {
        //build this later
      },
      
      
      
    );
  }
}