import 'dart:io';

import 'package:flutter/material.dart';
import 'package:website_tester/db/app_db.dart';
import 'package:website_tester/screens/screens.dart';

import 'db/data/website.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  //final database = AppDB();

  runApp(MyApp(/*database*/));
}

class MyApp extends StatelessWidget {
  /*AppDB database;*/

  MyApp(/*this.database, */ {super.key}) {
    super.key;
    /*speedTesterScreen = SpeedTester(database);*/
  }

  final BrokenLinks brokenLinksScreen = BrokenLinks();
  final SpeedTester speedTesterScreen = SpeedTester();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/broken_links') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => brokenLinksScreen,
            transitionDuration: const Duration(),
          );
        }
        if (settings.name == '/speed_tester') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => speedTesterScreen,
            transitionDuration: const Duration(),
          );
        }

        return null;
      },
      initialRoute: "/broken_links",
    );
  }
}
