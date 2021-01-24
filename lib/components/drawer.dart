import 'package:feedall/app_localizations.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:feedall/models/client.dart';
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
    Client.client = Client();
    Navigator.pushReplacementNamed(context, '/login');
  }

  return Drawer(
    child: Container(
      color: background3,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(Client.client.name ?? 'Feed All'),
            accountEmail: Text(Client.client.clientId ?? 'No Hunger'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: background1,
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[50]),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[50]),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[50]),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[50]),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[50]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, '/navigation');
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //     child: Row(
          //       children: <Widget>[
          //         Icon(
          //           Icons.navigate_before,
          //           color: primary,
          //         ),
          //         SizedBox(
          //           width: 20,
          //         ),
          //         Text(
          //           "BACK TO NAVIGATION",
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold, color: Colors.amber[50]),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
