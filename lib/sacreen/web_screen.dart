import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../controller/web_controller.dart';
import 'history_screen.dart';

// class WebViewScreen extends StatelessWidget {
//   final WebController webController = Get.put(WebController());
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   String value = searchController.text;
//                   webController.loadUrl(value);
//                   webController.addSearchHistory(value); // Save search history
//                   searchController.clear();
//                 },
//               ),
//               hintText: 'Enter URL or search query',
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50))
//               ),
//             ),
//             onSubmitted: (value) {
//               webController.loadUrl(value);
//               webController.addSearchHistory(value); // Save search history
//               searchController.clear(); // Clear the search bar after submission
//             },
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Bookmark functionality to be implemented later
//             },
//             icon: Icon(Icons.bookmark),
//           ),
//           PopupMenuButton<String>(
//             onSelected: webController.changeSearchEngine,
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(
//                     value: 'https://www.google.com', child: Text('Google')),
//                 PopupMenuItem(
//                     value: 'https://www.bing.com', child: Text('Bing')),
//                 PopupMenuItem(
//                     value: 'https://duckduckgo.com', child: Text('DuckDuckGo')),
//                 PopupMenuItem(
//                     value: 'https://in.search.yahoo.com/?fr2=inr', child: Text('Yashoo!')),
//               ];
//             },
//             child: Icon(Icons.more_vert),
//           ),
//           SizedBox(width: 10,)
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => InAppWebView(
//               initialUrlRequest: URLRequest(
//                   url: WebUri(webController.searchEngine.value)),
//               onWebViewCreated: (controller) {
//                 webController.webViewController = controller;
//               },
//               onLoadStop: (controller, url) {
//                 webController.searchHistory.add(url?.toString() ?? "");
//               },
//             )),
//           ),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.arrow_back_ios),
//                   onPressed: () => webController.goBack(),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.arrow_forward_ios),
//                   onPressed: () => webController.goForward(),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () => webController.refreshPage(),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.home),
//                   onPressed: () => webController.loadHome(),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.history),
//                   onPressed: () {
//                     Get.to(HistoryScreen());
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
class WebViewScreen extends StatelessWidget {
  final WebController webController = Get.put(WebController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  String value = searchController.text;
                  webController.loadUrl(value);
                  webController.addSearchHistory(value); // Save search history
                  searchController.clear();
                },
              ),
              hintText: 'Enter URL or search query',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            onSubmitted: (value) {
              webController.loadUrl(value);
              webController.addSearchHistory(value); // Save search history
              searchController.clear(); // Clear the search bar after submission
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Bookmark functionality to be implemented later
            },
            icon: Icon(Icons.bookmark),
          ),
          PopupMenuButton<String>(
            onSelected: webController.changeSearchEngine,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'https://www.google.com',
                  child: Text('Google'),
                ),
                PopupMenuItem(
                  value: 'https://www.bing.com',
                  child: Text('Bing'),
                ),
                PopupMenuItem(
                  value: 'https://duckduckgo.com',
                  child: Text('DuckDuckGo'),
                ),
                PopupMenuItem(
                  value: 'https://in.search.yahoo.com/?fr2=inr',
                  child: Text('Yahoo!'),
                ),
              ];
            },
            child: Icon(Icons.more_vert),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Linear Progress Indicator
          Obx(() => webController.isLoading.value
              ? LinearProgressIndicator(
            value: webController.progress.value / 100,  // Progress from 0 to 100
          )
              : SizedBox.shrink()),  // Empty widget when not loading
          Expanded(
            child: Obx(() => InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(webController.searchEngine.value),
              ),
              onWebViewCreated: (controller) {
                webController.webViewController = controller;
              },
              onLoadStart: (controller, url) {
                webController.isLoading.value = true; // Start loading
              },
              onLoadStop: (controller, url) {
                webController.isLoading.value = false; // Stop loading
                webController.searchHistory.add(url?.toString() ?? "");
              },
              onProgressChanged: (controller, progress) {
                webController.progress.value = progress.toDouble();
              },
            )),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => webController.goBack(),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => webController.goForward(),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () => webController.refreshPage(),
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => webController.loadHome(),
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    Get.to(HistoryScreen());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
