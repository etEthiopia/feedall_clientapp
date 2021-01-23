import 'package:feedall/app_localizations.dart';
import 'package:feedall/components/drawer.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class DayStatScreen extends StatefulWidget {
  @override
  _DayStatScreenState createState() => _DayStatScreenState();
}

class _DayStatScreenState extends State<DayStatScreen> {
  DateTime selectedDate = DateTime.now();

  Widget _foodCourse(var context, int course, int amount) {
    Color bgcolor = light;
    String coursename = 'breakfast';
    Icon icon = Icon(
      Icons.breakfast_dining,
      color: Colors.white,
      size: 16,
    );
    switch (course) {
      case 2:
        bgcolor = primary;
        coursename = 'lunch';
        icon = Icon(
          Icons.lunch_dining,
          color: Colors.white,
          size: 16,
        );
        break;
      case 3:
        bgcolor = dark;
        coursename = 'dinner';
        icon = Icon(
          Icons.dinner_dining,
          color: Colors.white,
          size: 16,
        );
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: background3,
          offset: const Offset(1.5, 1.0),
          blurRadius: 2.0,
          spreadRadius: 1.5,
        ),
      ], color: bgcolor, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text(
            amount.toString() +
                " " +
                AppLocalizations.of(context).translate("plates"),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                AppLocalizations.of(context).translate(coursename),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget _total(var context, int amount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/plate.png"),
            fit: BoxFit.contain,
          ),
          color: Colors.grey[600],
          boxShadow: [
            BoxShadow(
              color: background,
              offset: const Offset(1.5, 1.0),
              blurRadius: 2.0,
              spreadRadius: 1.5,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).translate("total"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            amount.toString(),
            style: TextStyle(color: Colors.white, fontSize: 70),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

  Widget _sizedBox() {
    return SizedBox(
      height: 20.0,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: FeedAllDrawer(context),
        appBar: AppBar(
          title: Text(selectedDate.toLocal().toString().split(' ')[0]),
          actions: [
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(right: 10),
              ),
            )
          ],
          backgroundColor: dark,
        ),
        backgroundColor: background2,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        _sizedBox(),
                        _foodCourse(context, 1, 507),
                        _sizedBox(),
                        _foodCourse(context, 2, 1259),
                        _sizedBox(),
                        _foodCourse(context, 3, 910),
                        _sizedBox(),
                        _sizedBox(),
                        _total(context, 2756)
                      ],
                    )))));
  }
}
