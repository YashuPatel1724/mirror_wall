import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/web_controller.dart';

class HistoryScreen extends StatelessWidget {
  final WebController webController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await webController.clearSearchHistory(); // Clear history
              Get.snackbar("History Cleared", "Your search history has been cleared");
            },
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: webController.searchHistory.length,
        itemBuilder: (context, index) {
          final historyItem = webController.searchHistory[index];
          return ListTile(
            title: Text(historyItem),
            onTap: () {
              webController.navigateToHistory(historyItem);
              Get.back(); // Go back to the WebView after selection
            },
          );
        },
      )),
    );
  }
}

//
// class HistoryScreen extends StatelessWidget {
//   final WebController webController = Get.find<WebController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search History'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () async {
//               await webController.clearSearchQueries(); // Clear search queries only
//               Get.snackbar("History Cleared", "Your search history has been cleared");
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (webController.searchQueries.isEmpty) {
//           return Center(child: Text('No search queries found'));
//         }
//         return ListView.builder(
//           itemCount: webController.searchQueries.length,
//           itemBuilder: (context, index) {
//             final queryItem = webController.searchQueries[index];
//             return ListTile(
//               title: Text(queryItem),
//               onTap: () {
//                 webController.navigateToHistory(queryItem);  // Load the search query as a search
//                 Get.back(); // Go back to the WebViewScreen after selection
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }
