import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

enum FormType { login, register }

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _email, _name, _password, _phoneNumber;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();

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
    if (validateDetails()) {
      try {
        AuthResult result = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text));


        var user = await FirebaseAuth.instance.currentUser();

        UserUpdateInfo info = new UserUpdateInfo();
        info.displayName = _nameController.text;
        user.updateProfile(info);

        Firestore.instance.collection('users').document('${user.uid}').setData({
          'name': _nameController.text,
          'uid' : user.uid,
          'email': user.email,
          'contactNumber': _contactController.text,
        });



        print("############### REGISTER ACCOUNT SUCCESSFUL ##############");

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Login SUCCESSFULL"),
        ));
        showAlertDialog(context, "Welcome","Your account was registered. Go to the next tab to login and view your details");
      } catch (e) {
        print("#######################  REGISTER ACCOUNT FAILED ###################");
        showAlertDialog(context, "Registration Error", "The error provided was :- \n"
            "${e}"
            "\n ~~~ END OF TRANSMISSION ~~~");

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.hashCode.toString()),
        ));
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15),
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      AppLocalizations.of(context).translate('tagness'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 40),
                    ),
                  )),
              Divider(
                height: 30,
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
                                    children: buildInputs(context)
                                    /*<Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText:
                                            AppLocalizations.of(context)
                                                .translate('enter_email'),
                                            fillColor: Colors.white,
                                            filled: true),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: AppLocalizations.of(
                                                context)
                                                .translate('enter_password'),
                                            fillColor: Colors.white,
                                            filled: true),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText:
                                            AppLocalizations.of(context)
                                                .translate('enter_name'),
                                            fillColor: Colors.white,
                                            filled: true),
                                      ),
                                    ),
                                  ]*/
                                    ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () => validateAndSubmit(context),
                            color: Theme.of(context).primaryColorLight,
                            child: Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('create_an_account'),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          )
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
    );
  }

  List<Widget> buildInputs(BuildContext context) {
    return [
      new TextFormField(
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0)
            ),
            labelText: AppLocalizations.of(
                context)
                .translate('enter_email'),
            labelStyle: Theme.of(context).textTheme.headline6
        ),
        validator: (value) => value.isEmpty ? "Email can\'t be empty" : null,
        controller: _emailController,
      ),
      Divider(height: 10,),
      new TextFormField(
        style: Theme.of(context).textTheme.headline6,

        keyboardType: TextInputType.visiblePassword,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0)
            ),
            labelText: AppLocalizations.of(
                context)
                .translate('enter_password'),
            labelStyle: Theme.of(context).textTheme.headline6
        ),
        validator: (value) => value.isEmpty ? "Password can\'t be empty" : null,
        obscureText: true,
        controller: _passwordController,
      ),
      Divider(height: 10,),
      new TextFormField(
        style: Theme.of(context).textTheme.headline6,

        keyboardType: TextInputType.text,
        validator: (value) => value.isEmpty ? "Name can\'t be empty" : null,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0)
            ),
            labelText: AppLocalizations.of(
                context)
                .translate('enter_name'),
            labelStyle: Theme.of(context).textTheme.headline6
        ),
        controller: _nameController,
      ),
      Divider(height: 10,),
      new TextFormField(
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.phone,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0)
            ),
            labelText: "Contact Number",
            labelStyle: Theme.of(context).textTheme.headline6
        ),
        validator: (value) => value.isEmpty ? "Contact Number can\'t be empty" : null,
        controller: _contactController,
      ),
    ];
  }

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok joe"),
      onPressed: () {Navigator.pop(context);},
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
}
