import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/constants/string_constant.dart';
import 'package:quotes_app/routes/app_route.dart';
import 'package:quotes_app/util/pref_util.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var fullQuotesList = [];
  var searchedQuotesList = [].obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    loadQuotes();
    super.onInit();
  }

  Future loadQuotes() async {
    try {
      isLoading.value = true;
      var quotes = await rootBundle.loadString('assets/raw/quotes.json');
      fullQuotesList = await jsonDecode(quotes);

      fullQuotesList.shuffle();
      searchedQuotesList.value = fullQuotesList;
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getQuote(quote) {
    return quote['text'];
  }

  getAuthor(quote) {
    if (quote['author'] == null) {
      return StringConstant.anonymous;
    }
    return quote['author'];
  }

  void clearSearch() {
    searchController.text = '';
    searchText(searchController.text);
  }

  void searchText(String text) {
    if (text.trim().isEmpty || fullQuotesList.isEmpty) {
      searchedQuotesList.value = fullQuotesList;
    } else {
      searchedQuotesList.value = fullQuotesList
          .where(
            (element) =>
                element['text'].toString().toLowerCase().contains(text) ||
                element['author'].toString().toLowerCase().contains(text),
          )
          .toList();
    }
  }

  void shuffleQuotes() {
    try {
      isLoading.value = true;

      if (fullQuotesList.isNotEmpty) {
        if (searchController.text.trim().isNotEmpty) {
          searchedQuotesList.value.shuffle();
        } else {
          print('Shuffle');
          fullQuotesList.shuffle();
          searchedQuotesList.value = fullQuotesList;
        }
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  void darkTheme() {
    var isDarkTheme = Prefs.isDarkTheme() ?? false;
    print('Theme:::$isDarkTheme');

    Prefs.setDarkTheme(Prefs.darkTheme, !isDarkTheme);
    Get.changeTheme(isDarkTheme ? ThemeData.light() : ThemeData.dark());
  }

  void about(BuildContext context) {
    print('About');
    showAboutDialog(context: context);
  }

  void editQuote() {
    print('edit');
    // Get.toNamed(AppRoutes.editQuote, arguments: fullQuotesList);
  }
}
