import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class WebController extends GetxController {
//   late InAppWebViewController webViewController;
//   var searchHistory = <String>[].obs;
//   var searchEngine = 'https://www.google.com'.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadSearchHistory();
//   }
//
//   void loadUrl(String url) {
//     if (!url.startsWith('https://') && !url.startsWith('http://')) {
//
//       url = '$searchEngine?q=$url';
//     }
//     webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
//   }
//
//
//   void addSearchHistory(String search) async {
//     if (search.isNotEmpty && !searchHistory.contains(search)) {
//       searchHistory.add(search);
//       await saveSearchHistory();
//     }
//   }
//
//
//   Future<void> loadSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? history = prefs.getStringList('searchHistory');
//     if (history != null) {
//       searchHistory.addAll(history);
//     }
//   }
//
//
//   Future<void> saveSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('searchHistory', searchHistory);
//   }
//
//
//   Future<void> clearSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('searchHistory');
//     searchHistory.clear();
//   }
//
//   void navigateToHistory(String url) {
//     loadUrl(url);
//   }
//
//   void goBack() {
//     webViewController.goBack();
//   }
//
//   void goForward() {
//     webViewController.goForward();
//   }
//
//   void refreshPage() {
//     webViewController.reload();
//   }
//
//   void loadHome() {
//     loadUrl(searchEngine.value);
//   }
//
//   void changeSearchEngine(String engine) {
//     searchEngine.value = engine;
//   }
// }
// class WebController extends GetxController {
//   late InAppWebViewController webViewController;
//   var searchHistory = <String>[].obs;
//   var searchEngine = 'https://www.google.com'.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadSearchHistory();
//   }
//
//   void loadUrl(String url) {
//     // Check if input is a URL or a search query
//     if (!url.startsWith('https://') && !url.startsWith('http://')) {
//       // If it's a search query, append it to the current search engine URL
//       url = '${searchEngine.value}/search?q=$url';
//     }
//     webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
//   }
//
//   void addSearchHistory(String search) async {
//     if (search.isNotEmpty && !searchHistory.contains(search)) {
//       searchHistory.add(search);
//       await saveSearchHistory();
//     }
//   }
//
//   Future<void> loadSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? history = prefs.getStringList('searchHistory');
//     if (history != null) {
//       searchHistory.addAll(history);
//     }
//   }
//
//   Future<void> saveSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('searchHistory', searchHistory);
//   }
//
//   Future<void> clearSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('searchHistory');
//     searchHistory.clear();
//   }
//
//   void navigateToHistory(String url) {
//     loadUrl(url);
//   }
//
//   void goBack() {
//     webViewController.goBack();
//   }
//
//   void goForward() {
//     webViewController.goForward();
//   }
//
//   void refreshPage() {
//     webViewController.reload();
//   }
//
//   void loadHome() {
//     loadUrl(searchEngine.value);
//   }
//
//   void changeSearchEngine(String engine) {
//     searchEngine.value = engine;
//     // Load the home page with the new search engine after change
//     loadHome();
//   }
// }
class WebController extends GetxController {
  late InAppWebViewController webViewController;
  var searchHistory = <String>[].obs;
  var searchEngine = 'https://www.google.com'.obs;
  var isLoading = true.obs;  // Track the loading state
  var progress = 0.0.obs;    // Track the progress

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  void loadUrl(String url) {
    if (!url.startsWith('https://') && !url.startsWith('http://')) {
      url = '${searchEngine.value}/search?q=$url';
    }
    isLoading.value = true;  // Start loading
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }

  void addSearchHistory(String search) async {
    if (search.isNotEmpty && !searchHistory.contains(search)) {
      searchHistory.add(search);
      await saveSearchHistory();
    }
  }

  Future<void> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('searchHistory');
    if (history != null) {
      searchHistory.addAll(history);
    }
  }

  Future<void> saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', searchHistory);
  }

  Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('searchHistory');
    searchHistory.clear();
  }

  void navigateToHistory(String url) {
    loadUrl(url);
  }

  void goBack() {
    webViewController.goBack();
  }

  void goForward() {
    webViewController.goForward();
  }

  void refreshPage() {
    webViewController.reload();
  }

  void loadHome() {
    loadUrl(searchEngine.value);
  }

  void changeSearchEngine(String engine) {
    searchEngine.value = engine;
    loadHome();
  }
}


// class WebController extends GetxController {
//   late InAppWebViewController webViewController;
//   var searchHistory = <String>[].obs;       // Store all searches and URLs
//   var searchQueries = <String>[].obs;       // Store only search queries
//   var searchEngine = 'https://www.google.com'.obs;
//   var isLoading = true.obs;
//   var progress = 0.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadSearchHistory();
//   }
//
//   // Modify loadUrl method to distinguish between search queries and URLs
//   void loadUrl(String query) {
//     String url;
//     if (!query.startsWith('https://') && !query.startsWith('http://')) {
//       // It's a search query
//       url = '${searchEngine.value}/search?q=$query';
//       addSearchQuery(query);  // Store the search query separately
//     } else {
//       // It's a direct URL
//       url = query;
//     }
//     isLoading.value = true;
//     webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
//   }
//
//   void addSearchHistory(String entry) async {
//     if (entry.isNotEmpty && !searchHistory.contains(entry)) {
//       searchHistory.add(entry);
//       await saveSearchHistory();
//     }
//   }
//
//   // Add only search queries to the searchQueries list
//   void addSearchQuery(String query) async {
//     if (query.isNotEmpty && !searchQueries.contains(query)) {
//       searchQueries.add(query);
//       await saveSearchQueries();
//     }
//   }
//
//   Future<void> loadSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? history = prefs.getStringList('searchHistory');
//     if (history != null) {
//       searchHistory.addAll(history);
//     }
//
//     // Load search queries
//     List<String>? queries = prefs.getStringList('searchQueries');
//     if (queries != null) {
//       searchQueries.addAll(queries);
//     }
//   }
//
//   Future<void> saveSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('searchHistory', searchHistory);
//   }
//
//   // Save search queries separately
//   Future<void> saveSearchQueries() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('searchQueries', searchQueries);
//   }
//
//   Future<void> clearSearchHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('searchHistory');
//     searchHistory.clear();
//   }
//
//   Future<void> clearSearchQueries() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('searchQueries');
//     searchQueries.clear();
//   }
//
//   void navigateToHistory(String url) {
//     loadUrl(url);
//   }
//
//   void goBack() {
//     webViewController.goBack();
//   }
//
//   void goForward() {
//     webViewController.goForward();
//   }
//
//   void refreshPage() {
//     webViewController.reload();
//   }
//
//   void loadHome() {
//     loadUrl(searchEngine.value);
//   }
//
//   void changeSearchEngine(String engine) {
//     searchEngine.value = engine;
//     loadHome();
//   }
// }
