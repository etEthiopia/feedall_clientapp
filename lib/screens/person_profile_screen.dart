import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/appbar.dart';
import 'package:feedall/components/loading.dart';
import 'package:feedall/components/show_error.dart';
import 'package:feedall/main.dart';
import 'package:feedall/models/person.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PersonProfileScreen extends StatelessWidget {
  PersonProfileScreen({this.personid});

  final int personid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersonProfile(
        personid: this.personid,
      ),
    );
  }
}

class PersonProfile extends StatefulWidget {
  PersonProfile({this.personid});
  final int personid;

  @override
  _PersonProfileState createState() =>
      _PersonProfileState(personid: this.personid);
}

class _PersonProfileState extends State<PersonProfile> {
  _PersonProfileState({this.personid});
  final int personid;
  Person personToFeed;
  bool loading;
  String errormessage;
  final TextEditingController _idController = TextEditingController();

  Widget _imagePlaceholder() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: primary),
        width: 200,
        alignment: Alignment.topCenter,
        child: Icon(
          Icons.person,
          size: 200,
          color: background3,
        ));
  }

  Widget _errorSection(
      BuildContext context, String url, dynamic downloadProgress) {
    return _imagePlaceholder();
  }

  Widget _loadingSection(
      BuildContext context, String url, dynamic downloadProgress) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: primary),
        width: 200,
        height: 200,
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
          border: Border.all(color: accent, width: 5),
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
        shadowColor: dark,
        color: light,
        borderRadius: BorderRadius.circular(15.0),
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
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
        shadowColor: dark,
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

  _getPersonData({var context, bool load = false}) async {
    if (load) {
      setState(() {
        loading = true;
      });
    }
    people
        .where('person_id', isEqualTo: this.personid)
        .get()
        .then((querySnapshot) {
      var persondoc = querySnapshot.docs[0].data();
      int meal = 0;
      DateTime mealtimedate = DateTime.now();
      if (mealtimedate.hour < 11) {
        meal = 1;
      } else if (mealtimedate.hour < 17) {
        meal = 2;
      } else if (mealtimedate.hour < 24) {
        meal = 3;
      }
      plates
          .where('person', isEqualTo: this.personid.toString())
          .get()
          .then((querySnapshot) {
        bool platefoundornot = false;
        for (QueryDocumentSnapshot qds in querySnapshot.docs) {
          Timestamp timestamp = qds.data()['timestamp'];
          print(
              "DATE ${DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000)}");
          if (DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000)
                  .toString()
                  .substring(0, 10) ==
              mealtimedate.toString().substring(0, 10)) {
            if (qds.data()['type'] == meal) {
              platefoundornot = true;
              break;
            }
          }
        }
        if (platefoundornot) {
          print("Person has been served");
          setState(() {
            errormessage = "person_was_served";
          });
          showError(errormessage, context);
        } else {
          setState(() {
            personToFeed = Person(
                level: persondoc['level'],
                personId: persondoc['person_id'],
                picture: persondoc['picture'],
                name: persondoc['name'],
                valid: true);
            loading = false;
          });
        }

        setState(() {
          loading = false;
        });
      }).catchError((error) {
        setState(() {
          loading = false;
        });
        print("Failed to get CLIENT: $error");
        setState(() {
          errormessage = "failed_to_update";
        });
        showError(errormessage, context);
      });
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      print("Failed to get CLIENT: $error");
      if (error.toString().trim() ==
          "RangeError (index): Invalid value: Valid value range is empty: 0") {
        setState(() {
          errormessage = "person_not_found";
        });
        showError(errormessage, context);
      } else {
        setState(() {
          errormessage = "error_happened";
        });
        showError(errormessage, context);
      }
    });
  }

  @override
  void initState() {
    _getPersonData(context: context, load: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background2,
        appBar: FeeadAllAppBar(context, 'empty_header'),
        body: Builder(
          builder: (context) => SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                reverse: true,
                child: !loading
                    ? Column(
                        children: [
                          Form(
                              child: Column(
                            children: [
                              this.personToFeed != null
                                  ? _loadimage(this.personToFeed.picture)
                                  : _imagePlaceholder(),
                              _sizedBox(),
                              this.personToFeed != null
                                  ? _name(this.personToFeed.name)
                                  : _name(AppLocalizations.of(context)
                                      .translate(errormessage)),
                              _sizedBox(),
                              this.personToFeed != null
                                  ? _level(context, this.personToFeed.level)
                                  : SizedBox(height: 0),
                              _sizedBox(),
                              _sizedBox(),
                              _cancelBtn(context),
                              _sizedBox(),
                              this.personToFeed != null
                                  ? _submitBtn(context)
                                  : SizedBox(height: 0),
                            ],
                          ))
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(child: Loading(context))),
              ),
            ),
          ),
        ));
  }
}
