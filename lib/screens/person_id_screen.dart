import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/components/show_error.dart';
import 'package:feedall/screens/person_profile_screen.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class PersonIDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Person(),
    );
  }
}

class Person extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();

  Widget _idPrompt(var context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: background2,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: primary, width: 2, style: BorderStyle.solid)),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.white,
                hintText:
                    AppLocalizations.of(context).translate("enter_person_id"),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: primary),
        width: 200,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        alignment: Alignment.topCenter,
        child: Icon(
          Icons.person,
          size: 200,
          color: background3,
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
        shadowColor: dark,
        color: dark,
        borderRadius: BorderRadius.circular(15.0),
        child: FlatButton(
          onPressed: () {
            int pid = 0;
            try {
              pid = int.parse(_idController.text);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonProfileScreen(
                        personid: pid,
                      )));
            } catch (e) {
              showError('invalid_id', context);
            }
          },
          child: Text(
            AppLocalizations.of(context).translate("submit_btn_text"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background2,
        drawer: FeedAllDrawer(context),
        appBar: FeeadAllAppBar(context, 'serve_customer'),
        body: Builder(
          builder: (context) => SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                        _submitBtn(context)
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
