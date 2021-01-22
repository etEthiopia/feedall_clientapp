import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class AccountBalanceScreen extends StatelessWidget {
  Widget _clientName(String name) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Image.asset(
            "images/ethiopian_plate.png",
            width: 100.0,
          ),
          _sSizedBox(),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget _unpaidBalance(var context, int amount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: background3,
          offset: const Offset(1.5, 1.0),
          blurRadius: 2.0,
          spreadRadius: 1.5,
        ),
      ], color: primary, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: background1,
            child: Icon(
              Icons.money_off,
              color: primary,
              size: 25,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.of(context).translate("total_unpaid"),
            style: TextStyle(color: background2, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            amount.toString() + " ETB",
            style: TextStyle(color: background2, fontSize: 40),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget _paidBalance(var context, int amount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: background3,
          offset: const Offset(1.5, 1.0),
          blurRadius: 2.0,
          spreadRadius: 1.5,
        ),
      ], color: dark, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.attach_money,
              color: dark,
              size: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.of(context).translate("total_paid"),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            amount.toString() + " ETB",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget _sizedBox() {
    return SizedBox(
      height: 20.0,
    );
  }

  Widget _sSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background2,
        drawer: FeedAllDrawer(context),
        appBar: FeeadAllAppBar(context, 'account_balance'),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        _clientName("HM Megeb Bet"),
                        _sizedBox(),
                        _unpaidBalance(context, 3405),
                        _sSizedBox(),
                        _paidBalance(context, 10510),
                      ],
                    )))));
  }
}
