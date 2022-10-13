import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/modules/home/home_screen.dart';
import 'package:quotes_app/routes/app_route.dart';
import 'package:quotes_app/util/notification_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/edit/edit_quote_screen.dart';
import 'util/pref_util.dart';

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  print('remoteMessageTITLE:::: ${remoteMessage.notification!.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Prefs.init();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // await FirebaseNotificationUtil.init();
  NotificationUtil.init();
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    // FirebaseNotificationUtil.getInitialMessage();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('getInitialMessage::: ${message.notification!.title}');
      }
    });

    // 2. This method only call when App in forground it mean app must be opened
    // FirebaseNotificationUtil.getOnMessage();

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    // FirebaseNotificationUtil.getOnMessageOpenedApp();

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('onMessageOpenedApp_TITLE::: ${message.notification!.title}');
      print('onMessageOpenedApp_BODY::: ${message.notification!.body}');
    });

    // getCurrentTheme();
  }

  getCurrentTheme() async {
    isDarkTheme = await Prefs.isDarkTheme() ?? false;
    print('isDarkTheme::: $isDarkTheme');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: AppRoutes.editQuote,
          page: () => EditQuoteScreen(),
        ),
      ],
    );
  }
}
