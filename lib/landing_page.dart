import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary_app/my_home_page.dart';
import 'package:personal_diary_app/services/auth.dart';
import 'package:personal_diary_app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {

  final AuthBase auth;

  const LandingPage({Key? key, required this.auth}) : super(key: key);
  

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
   User? _user;


   //init state for holding the home screen after sign in(need not to sign in again and again)
  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }


  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser, 
        auth: widget.auth,
      );
    }
    return MyHomePage(
      onSignOut: () => _updateUser(null),
       auth: widget.auth,
    ); 
      }
}
