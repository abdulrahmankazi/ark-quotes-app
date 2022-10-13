import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/constants/string_constant.dart';
import 'package:quotes_app/style/quotes_style.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstant.appName),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              tooltip: StringConstant.shuffle,
              onPressed: () {
                homeController.shuffleQuotes();
              },
              icon: Icon(
                Icons.shuffle_outlined,
              ),
            ),
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          */ /*NotificationUtil.showDelayedNotification(
            scheduleDate: DateTime.now().add(
              Duration(seconds: 5),
            ),
            title: 'Scheduled Notification',
            body: 'Scheduled Notification after 30 seconds',
          );*/ /*

          NotificationUtil.showNotification(
            title: 'Test',
            body: 'This is notification body',
          );
        },
        label: Text('Notification'),
      ),*/
      /*drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              right: 4.0,
              left: 4.0,
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    StringConstant.darkMode,
                  ),
                  trailing: Icon(
                    Icons.dark_mode_outlined,
                  ),
                  onTap: () {
                    homeController.darkTheme();
                  },
                ),
                ListTile(
                  title: Text(
                    StringConstant.about,
                  ),
                  onTap: () {
                    homeController.about(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),*/
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: homeController.searchController,
                onChanged: (text) {
                  print(text);
                  homeController.searchText(text);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: StringConstant.searchQuote,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search_outlined),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      homeController.clearSearch();
                    },
                    icon: Icon(Icons.clear_outlined),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: homeController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: homeController.searchedQuotesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        homeController.getQuote(homeController
                                            .searchedQuotesList[index]),
                                        style: QuoteStyle.quoteTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '- ${homeController.getAuthor(homeController.searchedQuotesList[index])}',
                                        style: QuoteStyle.quoteAuthorStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          /*IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.speaker_outlined),
                                              color: Colors.grey.shade500,
                                            ),*/
                                          IconButton(
                                            onPressed: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                  text:
                                                      '${homeController.getQuote(homeController.searchedQuotesList[index])} \n - ${homeController.getAuthor(homeController.searchedQuotesList[index])}',
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      StringConstant.copied),
                                                  duration: Duration(
                                                    seconds: 1,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.copy_outlined),
                                            color: Colors.grey.shade500,
                                            splashColor: Colors.grey,
                                            tooltip: StringConstant.copy,
                                          ),
                                          /*IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons
                                                .favorite_outline_outlined),
                                            color: Colors.grey.shade500,
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
