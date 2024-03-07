// import 'package:flutter/material.dart';
// class LoaderBar {
//   static void showMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 3), // Adjust the duration as needed
//         backgroundColor: const Color.fromARGB(255, 230, 111, 109),
//       ),
//     );
//   }

//   static void showLoading(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const CircularProgressIndicator(),
//             const SizedBox(width: 16),
//             Text(message),
//           ],
//         ),
//         duration: const Duration(seconds: 1), // Adjust the duration as needed
//         backgroundColor: const Color.fromARGB(255, 230, 111, 109),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LoaderBar {
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 230, 111, 109),
      ),
    );
  }

  static void showLoading(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(255, 230, 111, 109),
      ),
    );
  }
}
