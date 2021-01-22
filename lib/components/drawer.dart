import 'package:feedall/app_localizations.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

Widget FeedAllDrawer(var context) {
  _settings() {
    Navigator.pushReplacementNamed(context, '/settings');
  }

  _feed() {
    Navigator.pushReplacementNamed(context, '/person_id');
  }

  _stat() {
    Navigator.pushReplacementNamed(context, '/day_stat');
  }

  _account() {
    Navigator.pushReplacementNamed(context, '/account_balance');
  }

  _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  return Drawer(
    child: Container(
      color: background,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("HM Mebeb Bet"),
            accountEmail: Text("Feed All"),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: background3,
                backgroundImage: AssetImage('images/logo.png'),
              ),
            ),
            decoration: BoxDecoration(color: primary),
          ),
          InkWell(
            onTap: () {
              _feed();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("serve_customer"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _stat();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("day_stat"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _account();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("account_balance"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _settings();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("settings"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: dark,
          ),
          InkWell(
            onTap: () {
              _logout();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("logout"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.navigate_before,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "BACK TO NAVIGATION",
                    style: TextStyle(fontWeight: FontWeight.bold, color: light),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
