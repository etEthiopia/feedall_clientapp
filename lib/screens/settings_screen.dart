import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String lang;

  @override
  void initState() {
    AppLocalizations.getCurrentLang().then((value) => setState(() {
          lang = value.toString();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _logoSection() {
      return Container(
          margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          alignment: Alignment.topCenter,
          child: Image.asset(
            "images/logo.png",
            width: 100.0,
          ));
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: background3,
            title: Text(
              AppLocalizations.of(context)
                  .translate("confirmation_dialog_title"),
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate("restart_confirmation_dialog_text"),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("restart_later_btn_text"),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("restart_restart_btn_text"),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Phoenix.rebirth(context);
                },
              ),
            ],
          );
        },
      );
    }

    changeLang(String lang, String country) async {
      if (this.lang != lang + "_" + country) {
        Locale locale = Locale(lang, country);
        await AppLocalizations.storelang(locale);
        _showMyDialog();
      }
    }

    Widget _chooseLang() {
      return Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 17, bottom: 5),
              child: Text(
                AppLocalizations.of(context).translate("choose_lang_text"),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: this.lang != null
                          ? (this.lang == "am_ET" ? primary : background2)
                          : background2,
                      child: FlatButton(
                        onPressed: () {
                          changeLang("am", "ET");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 17,
                                margin: EdgeInsets.only(right: 5),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "images/et.png",
                                )),
                            Text(
                              "አማርኛ",
                              style: TextStyle(
                                color: this.lang != null
                                    ? (this.lang == "am_ET"
                                        ? Colors.white
                                        : Colors.white)
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: this.lang != null
                          ? (this.lang == "en_US" ? primary : background2)
                          : background2,
                      child: FlatButton(
                        onPressed: () {
                          changeLang("en", "US");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 5),
                                height: 17,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "images/uk.png",
                                )),
                            Text(
                              "English",
                              style: TextStyle(
                                color: this.lang != null
                                    ? (this.lang == "en_US"
                                        ? Colors.white
                                        : Colors.white)
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _sizedBox() {
      return SizedBox(
        height: 20.0,
      );
    }

    Widget _developer(String name) {
      return Text(
        AppLocalizations.of(context).translate(name),
        style:
            TextStyle(fontSize: 17, color: light, fontWeight: FontWeight.bold),
      );
    }

    Widget _sSizedBox() {
      return SizedBox(
        height: 10.0,
      );
    }

    Widget _ssSizedBox() {
      return SizedBox(
        height: 5.0,
      );
    }

    Widget _developers() {
      return Column(
        children: [
          Divider(
            color: primary,
          ),
          _sizedBox(),
          Text(
            AppLocalizations.of(context).translate("this_app_developed_by"),
            style: TextStyle(fontSize: 20, color: primary),
          ),
          _sSizedBox(),
          _developer('abdu'),
          _ssSizedBox(),
          _developer('dagi'),
          _sSizedBox(),
          _developer('dani'),
          _sSizedBox(),
          _developer('dave'),
          _ssSizedBox(),
          _developer('hermela')
        ],
      );
    }

    return Scaffold(
        drawer: FeedAllDrawer(context),
        appBar: FeeadAllAppBar(context, 'settings'),
        backgroundColor: background2,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _logoSection(),
                      _sizedBox(),
                      _chooseLang(),
                      _sizedBox(),
                      _sizedBox(),
                      _developers()
                    ],
                  ),
                ))));
  }
}
