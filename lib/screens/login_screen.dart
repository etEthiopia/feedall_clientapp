import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/main.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();

  Widget _idPrompt(var context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: background2.withOpacity(0.8),
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: primary, width: 2, style: BorderStyle.solid)),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context).translate("enter_client_id"),
                hintStyle: TextStyle(color: light),
                icon: Icon(
                  Icons.home,
                  color: dark,
                ),
                border: InputBorder.none,
                isDense: true),
            keyboardType: TextInputType.emailAddress,
            controller: _idController,
            validator: (value) {
              if (value.isEmpty) {
                return "The ID cannot be empty";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _logoSection() {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        alignment: Alignment.topCenter,
        child: Image.asset(
          "images/logo.png",
          width: 100.0,
        ));
  }

  Widget _sizedBox() {
    return SizedBox(
      height: 20.0,
    );
  }

  Widget _submitBtn(var context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 1,
        shadowColor: light,
        color: dark,
        borderRadius: BorderRadius.circular(15.0),
        child: FlatButton(
          onPressed: () {
            _firestoreClients();
          },
          child: Text(
            AppLocalizations.of(context).translate("start_btn_text"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  _firestoreClients() async {
    clients
        .where('client_id', isEqualTo: 'dave_mother_bet_6256935')
        .get()
        .then((querySnapshot) {
      print(querySnapshot.docs[0].data());
    }).catchError((error) => print("Failed to get CLIENT: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      drawer: FeedAllDrawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Form(
                    child: Column(
                  children: [
                    _logoSection(),
                    _sizedBox(),
                    _idPrompt(context),
                    _sizedBox(),
                    _submitBtn(context),
                    _sizedBox(),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
