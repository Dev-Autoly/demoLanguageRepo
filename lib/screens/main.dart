import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'register_view.dart';
import '../app_localizations.dart';
import '../blocs/theme.dart';
import 'all_charts.dart';
import 'home.dart';
import '../class/Language.dart';
import 'login_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum ThemeType { light, dark }
enum ViewState { login, home }

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color.fromRGBO(187, 134, 252, 1),
    accentColor: Color.fromRGBO(55, 0, 179, 1),
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black54),
        subtitle2: TextStyle(color: Color.fromRGBO(187, 134, 252, 1)),
        headline1: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Color.fromRGBO(55, 0, 179, 1))),
    appBarTheme: AppBarTheme(
        color: Color.fromRGBO(187, 134, 252, 1),

        actionsIconTheme: IconThemeData(color: Colors.white)));

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromRGBO(55, 0, 179, 1),
    accentColor: Colors.tealAccent,
    backgroundColor: Color.fromRGBO(187, 134, 252, 1),
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
        headline1: TextStyle(color: Color.fromRGBO(55, 0, 179, 1)),
        subtitle2: TextStyle(color: Color.fromRGBO(187, 134, 252, 1)),
        subtitle1: TextStyle(color: Color(0xff40bf7a))),


    appBarTheme: AppBarTheme(color: Color.fromRGBO(18, 18, 18, 1),
    actionsIconTheme: IconThemeData(color: Color.fromRGBO(187, 134, 252, 1))))
;

void main() {

  //FIREBASE Crashlytics
  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppMaterialAppWithThemeState state =
        context.findAncestorStateOfType<_MyAppMaterialAppWithThemeState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

class MyAppMaterialAppWithTheme extends StatefulWidget {
  @override
  _MyAppMaterialAppWithThemeState createState() =>
      _MyAppMaterialAppWithThemeState();
}

class _MyAppMaterialAppWithThemeState extends State<MyAppMaterialAppWithTheme> {
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'AE'),
        Locale('hi', 'IN'),
        Locale('fa', 'IR'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: theme.getTheme(),
      //THEME DATA BEFORE DARK & LIGHT MODE IMPLEMENTED (CUSTOM THEME)
      /* theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.bold)))),*/
      home: CurrentTabView(),
    );
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}

class CurrentTabView extends StatelessWidget {
  void showModal(BuildContext context) {
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

  void _changeLanguage(BuildContext context, Lanaguage language) {
    Locale _temp;
    switch (language.lanaguageCode) {
      case 'en':
        _temp = Locale(language.lanaguageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.lanaguageCode, 'AE');
        break;
      case 'hi':
        _temp = Locale(language.lanaguageCode, 'IN');
        break;
      case 'fr':
        _temp = Locale(language.lanaguageCode, 'FR');
        break;
      case 'fa':
        _temp = Locale(language.lanaguageCode, 'IR');
        break;
    }
    //Todo: implement MyApp callback
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header',
                      style:Theme.of(context).textTheme.headline6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  child: InkWell(
                    child: ExpansionTile(
                      title: Text(
                          AppLocalizations.of(context)
                              .translate('language_name'),
                          style: Theme.of(context)
                              .textTheme.headline6),
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            child: FlatButton(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('english'),
                                      style: Theme.of(context)
                                              .textTheme.headline6,
                                      textAlign: TextAlign.left,
                                    )),
                                onPressed: () {
                                  _changeLanguage(
                                      context, Lanaguage.lanagugeList[0]);
                                })),
                        Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            child: FlatButton(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      AppLocalizations.of(context).translate(
                                        'arabic',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme.headline6),
                                ),
                                onPressed: () {
                                  _changeLanguage(
                                      context, Lanaguage.lanagugeList[1]);
                                })),
                        Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            child: FlatButton(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('hindi'),
                                        style: Theme.of(context)
                                            .textTheme.headline6)),
                                onPressed: () {
                                  _changeLanguage(
                                      context, Lanaguage.lanagugeList[2]);
                                })),
                        Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            child: FlatButton(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('french'),
                                        style: Theme.of(context)
                                            .textTheme.headline6)),
                                onPressed: () {
                                  _changeLanguage(
                                      context, Lanaguage.lanagugeList[3]);
                                })),
                        Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            child: FlatButton(
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('farsi'),
                                        style: Theme.of(context)
                                            .textTheme.headline6)),
                                onPressed: () {
                                  _changeLanguage(
                                      context, Lanaguage.lanagugeList[4]);
                                })),
                      ],
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).translate('light_mode'),
                    style: Theme.of(context)
                        .textTheme.headline6,
                  ),
                  onTap: () {
                    _themeChanger.setTheme(lightTheme);
                  },
                  trailing: Icon(Icons.wb_sunny),
                ),
                ListTile(
                  title: Text(
                      AppLocalizations.of(context).translate('dark_mode'),
                      style:
                      Theme.of(context)
                          .textTheme.headline6),
                  onTap: () {
                    _themeChanger.setTheme(darkTheme);
                  },
                  trailing: Icon(Icons.remove_red_eye),
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Center(child: Text(AppLocalizations.of(context).translate('tagness'), style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'OpenSans' ),)),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.center_focus_strong),),
                Tab(icon: Icon(Icons.verified_user)),
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.insert_chart),)

              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  if (_themeChanger.getTheme() == darkTheme) {
                    _themeChanger.setTheme(lightTheme);
                  } else {
                    _themeChanger.setTheme(darkTheme);
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModal(context);
            },
          ),
          body: TabBarView(
            children: <Widget>[
              RegisterView(),
              LoginView(),
              Home(),
              AllCharts(),

            ],
          )),
    );
  }
}




