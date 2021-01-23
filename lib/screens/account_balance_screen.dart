import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/components/loading.dart';
import 'package:feedall/components/show_error.dart';
import 'package:feedall/main.dart';
import 'package:feedall/models/client.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class AccountBalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountBalance(),
    );
  }
}

class AccountBalance extends StatefulWidget {
  @override
  _AccountBalanceState createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  bool loading = false;

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
            backgroundColor: Colors.white,
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
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            amount.toString() + " ETB",
            style: TextStyle(color: Colors.white, fontSize: 40),
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

  _getMoneyData({var context, bool load = false}) async {
    if (load) {
      setState(() {
        loading = true;
      });
    }
    clients
        .where('client_id', isEqualTo: Client.client.clientId)
        .get()
        .then((querySnapshot) {
      var clientdoc = querySnapshot.docs[0].data();
      Client.client.paid = clientdoc['paid'];
      Client.client.unpaid = clientdoc['unpaid'];
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      print("Failed to get CLIENT: $error");
      showError("failed_to_update", context);
    });
  }

  @override
  void initState() {
    _getMoneyData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Scaffold(
            backgroundColor: background2,
            drawer: FeedAllDrawer(context),
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context).translate("account_balance"),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    _getMoneyData(context: context, load: true);
                  },
                  child: Container(
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(right: 10),
                  ),
                )
              ],
              backgroundColor: dark,
            ),
            body: SafeArea(
                child: Container(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: !loading
                          ? Column(
                              children: [
                                _clientName(Client.client.name),
                                _sizedBox(),
                                _unpaidBalance(context, Client.client.unpaid),
                                _sSizedBox(),
                                _paidBalance(context, Client.client.paid),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(child: Loading(context))),
                    )))));
  }
}
