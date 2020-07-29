
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qrlisttracker/blocs/theme.dart';
import 'package:qrlisttracker/widgets/user_transaction.dart';

enum ThemeType{
  light,
  dark
}

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xfff5f5f5),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        title: TextStyle(color: Colors.black),
        subtitle: TextStyle(color: Colors.grey),
        subhead: TextStyle(color: Colors.grey)),
    appBarTheme: AppBarTheme(
        color: Color(0xff1f655d),
        actionsIconTheme: IconThemeData(color: Colors.white)));

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff1f655d),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        title: TextStyle(color: Color(0xff40bf7a)),
        subtitle: TextStyle(color: Colors.white),
        subhead: TextStyle(color: Color(0xff40bf7a))),
    appBarTheme: AppBarTheme(color: Color(0xff1f655d)));


class Home extends StatefulWidget {

  static var _currentTheme = ThemeType.dark;

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) {
        return ThemeChanger(lightTheme);
      },
      child: new MyAppMaterialAppWithTheme(),
    );
  }
}


  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "fe",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                            'assets/images/autoly.png',
                            fit: BoxFit.scaleDown,
                          )),
                    ],
                  )));
        });
  }
  
  class MyAppMaterialAppWithTheme extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    // TODO: implement build
    return Test();
  }
}

class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Card Title
                  new UserTransaction(), //Custom Widget
                ]),
          ),
        ),
      ),
    );
  }
}