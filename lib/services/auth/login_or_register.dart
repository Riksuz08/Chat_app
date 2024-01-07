import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogInPage = true;
  void togglePages(){
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }
  @override
  Widget build(BuildContext context) {
     if(showLogInPage){
      return LoginPage(onTap: togglePages,);
     }else{
      return RegisterPage(onTap: togglePages,);
     
     }
  }
}