import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedall/app_localizations.dart';
import 'package:feedall/screens/account_balance_screen.dart';
import 'package:feedall/screens/day_stat_screen.dart';
import 'package:feedall/screens/login_screen.dart';
import 'package:feedall/screens/nav_screen.dart';
import 'package:feedall/screens/person_id_screen.dart';
import 'package:feedall/screens/person_profile_screen.dart';
import 'package:feedall/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

final storage = FlutterSecureStorage();

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference clients = firestore.collection('clients');
CollectionReference plates = firestore.collection('plates');
CollectionReference people = firestore.collection('people');
FirebaseApp app;

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  void initFirebaseApp() async {
    app = await Firebase.initializeApp();
  }

  @override
  void initState() {
    AppLocalizations.getCurrentLang().then((locale) => {
          setState(() {
            this.locale = locale;
          })
        });
    initFirebaseApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed All',
      locale: locale,
      supportedLocales: [Locale('en', 'US'), Locale('am', 'ET')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      routes: {
        '/login': (context) => LoginScreen(),
        '/person_id': (context) => PersonIDScreen(),
        '/day_stat': (context) => DayStatScreen(),
        '/account_balance': (context) => AccountBalanceScreen(),
        '/settings': (context) => SettingsScreen(),
        '/person_detail': (context) => PersonProfileScreen(),
        '/navigation': (context) => NavScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
