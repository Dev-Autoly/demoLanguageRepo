import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrlisttracker/class/User.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      void _signOut () async{
      await _firebaseAuth.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text("Welcome ${user.name},",style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25),),
                Divider(height: 20,),
                Text("Confirm your information below:",style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 20),),
                Text("Email : ${user.email}",style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),),
                Text("Contact Number : ${user.contactNumber}",style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),),
                Divider(height: 15,),
                RaisedButton(child: Text("Go back!",style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25)), onPressed: (){
                   _signOut();
                  Navigator.pop(context);
                },)
              ],
            ),
          ),

        ),
      ),
    );
  }
}
