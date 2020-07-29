import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../class/User.dart';
import '../screens/user_details.dart';
import '../app_localizations.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isSignIn = false;
  AnimationController _loginButtonController;

  @override
  void initState() {
    super.initState();

    isSignIn = false;
  }

  @override
  void dispose() {
    super.dispose();
    _loginButtonController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Firestore _firestore = Firestore.instance;

  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool validateDetails() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("##################### FORM VALIDATED!!!! ###################");
      return true;
    } else {
      print("##################### FORM INVALID!!!! ###################");
      return false;
    }
  }

  void validateAndSubmit(BuildContext context) async {
    String name = "";
    String email = "";
    String contactNumber = "";

    if (validateDetails()) {
      try {
        AuthResult result = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text));

        var _user = result.user;
        User user = null;
        var document = await Firestore.instance
            .collection('users')
            .document('${_user.uid}');
        document.get().then((document) {
          //user = new User(document.data['name'], document.data['email'], document.data['contactNumber']);
          name = document.data['name'];
          email = document.data['email'];
          contactNumber = document.data['contactNumber'];
          user = new User(name, email, contactNumber);
          print(
              "~~~~~~~~~~~~~~~~~~~~~~~${document.data['name']} ${document.data['email']} ${document.data['contactNumber']}~~~~~~~~~~~~~~~~~~~~~~~~~");

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserDetails(user: user)));
        });

        print(
            "~~~~~~~~~~~~~~~~~~~~~~~${name} ${email} ${contactNumber}~~~~~~~~~~~~~~~~~~~~~~~~~");

//        if(!(user.name.isEmpty && user.email.isEmpty && user.contactNumber.isEmpty)) {
//
//        }

//        showUserAlertDialog(context,"Successfull","Login was successfull",user);
        print("############### SUCCESSFUL SIGN IN ############## \n ");

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Signed In!!"),
        ));
      } catch (e) {
        print("#######################  SIGN IN FAILED ###################");
        print("${e.toString()}");
        print("#######################  SIGN IN FAILED ###################");
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please provide important details"),
      ));
    }
  }

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
                Card(
                  child: Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          AppLocalizations.of(context).translate('tagness'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  elevation: 10,
                  color: Colors.black,
                ),
                Card(
                  child: Container(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          validator: (value) => value.isEmpty
                                              ? "Email can\'t be empty"
                                              : null,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0)),
                                              labelText:
                                                  AppLocalizations.of(context)
                                                      .translate('enter_email'),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          validator: (value) => value.isEmpty
                                              ? "Password can\'t be empty"
                                              : null,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0)),
                                              labelText: AppLocalizations.of(
                                                      context)
                                                  .translate('enter_password'),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Container(
                              width: 320.0,
                              height: 60.0,
                              alignment: FractionalOffset.center,
                              decoration: new BoxDecoration(
                                color: const Color.fromRGBO(247, 64, 106, 1.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(30.0)),
                              ),
                              child: new Text(
                                AppLocalizations.of(context)
                                    .translate('sign_in'),
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OpenSans",
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                            /*RaisedButton(
                              onPressed: () => validateAndSubmit(context),
                              color: Theme.of(context).primaryColorLight,
                              child: Container(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('sign_in'),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                      Theme.of(context).primaryColorDark),
                                ),
                              ),
                            ),*/

                            RaisedButton(
                              onPressed: () {
                                googleSignIn();
                              },
                              color: Theme.of(context).primaryColorLight,
                              child: Container(
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        const Radius.circular(30.0))),
                                width: 250,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(isSignIn
                                              ? _user.photoUrl
                                              : "https://www.kindpng.com/picc/m/145-1457893_transparent-no-icon-png-no-result-icon-png.png")),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Google Sign In",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                        Text(
                                            "${isSignIn ? _user.email : 'Email : Not logged in'}"),
                                        Text(
                                            "${isSignIn ? _user.displayName : 'Name : No Name'}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                  elevation: 10,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(authCredential));

    setState(() {
      isSignIn = true;
      _user = result.user;
    });
  }

  Future<void> googleSignOut() async {
    await _auth.signOut().then((value) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }

  showUserAlertDialog(BuildContext context, String title, User user) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Confirm Details"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
