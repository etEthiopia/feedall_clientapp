import 'package:feedall/components/drawer.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  Widget _routeBtn(var context, String route, String title) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 1,
        shadowColor: dark,
        color: light,
        borderRadius: BorderRadius.circular(15.0),
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/$route',
            );
          },
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _sizedBox() {
    return SizedBox(
      height: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: FeedAllDrawer(context),
        backgroundColor: background2,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        _routeBtn(context, 'login', 'Login'),
                        _sizedBox(),
                        _routeBtn(context, 'person_id', 'Person ID'),
                        _sizedBox(),
                        _routeBtn(context, 'day_stat', 'Day Stat'),
                        _sizedBox(),
                        _routeBtn(
                            context, 'account_balance', 'Account Balance'),
                        _sizedBox(),
                        _routeBtn(context, 'settings', 'Settings'),
                        _sizedBox(),
                        _routeBtn(context, 'person_detail', 'Person Profile')
                      ],
                    )))));
  }
}
