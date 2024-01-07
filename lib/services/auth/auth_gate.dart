import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
            // user logged in
            if(snapshot.hasData){
              return HomePage();
            }
            //user is not logget in
            else{
              return LoginOrRegister();
            }
        },
      ),
    );
  }
}