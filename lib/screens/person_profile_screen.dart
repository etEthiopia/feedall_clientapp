import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PersonProfileScreen extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();

  Widget _errorSection(
      BuildContext context, String url, dynamic downloadProgress) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: primary),
        width: 200,
        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        alignment: Alignment.topCenter,
        child: Icon(
          Icons.person,
          size: 200,
          color: background3,
        ));
  }

  Widget _loadingSection(
      BuildContext context, String url, dynamic downloadProgress) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: primary),
        width: 200,
        height: 200,
        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        alignment: Alignment.topCenter,
        child: SpinKitFadingCube(
          size: MediaQuery.of(context).orientation == Orientation.portrait
              ? 100
              : 50,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? light : background2,
              ),
            );
          },
        ));
  }

  Widget _loadimage(String image) {
    return CachedNetworkImage(
      imageUrl: image,
      progressIndicatorBuilder: _loadingSection,
      errorWidget: _errorSection,
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: dark, width: 5),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _name(String name) {
    return Text(
      name,
      style: TextStyle(color: light, fontSize: 30),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _level(var context, int level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${AppLocalizations.of(context).translate('level')}",
          style: TextStyle(color: light, fontSize: 35),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          " ${level.toString()}",
          style: TextStyle(
              color: primary, fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ],
    );
  }

  Widget _sizedBox() {
    return SizedBox(
      height: 20.0,
    );
  }

  Widget _cancelBtn(var context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: 1,
        shadowColor: light,
        color: light,
        borderRadius: BorderRadius.circular(15.0),
        child: FlatButton(
          onPressed: () {
            // _signin();
          },
          child: Text(
            AppLocalizations.of(context).translate("cancel_btn_text"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
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
            // _signin();
          },
          child: Text(
            AppLocalizations.of(context).translate("confirm_btn_text"),
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
      appBar: FeeadAllAppBar(context, 'empty_header'),
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
                    _loadimage(
                        'https://firebasestorage.googleapis.com/v0/b/feedall.appspot.com/o/black_person.jpg?alt=media&token=e4cd7591-ae21-4858-b7b7-a1287d4c4f09'),
                    _sizedBox(),
                    _name('Abebe Kebede'),
                    _sizedBox(),
                    _level(context, 4),
                    _sizedBox(),
                    _sizedBox(),
                    _cancelBtn(context),
                    _sizedBox(),
                    _submitBtn(context)
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
