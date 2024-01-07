import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 
final emailController = TextEditingController();

final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();
void signUp() async{
  if(passwordController.text!=confirmPasswordController.text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match!')));
    return;
  }
final  authService = Provider.of<AuthService>(context,listen: false);
try{
  await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
}catch (e){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height: 50,),
              Icon(Icons.message,
              size: 80,
              ), 
              SizedBox(height: 50,),    
              Text(
                'Let\'s create an account for you!',
              
              style: TextStyle(fontSize: 18,),),
            SizedBox(height: 20,),
            MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
            SizedBox(height: 10,),
            MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 10,),
            MyTextField(controller: confirmPasswordController, hintText: 'Confirm password', obscureText: true),
              SizedBox(height: 25,),
              MyButton(text: 'Sign Up', onTap:signUp,),
              SizedBox(height:30 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member? '),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Login now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  )
                ],
              )
            
            ],),
          ),
        ),
      )
    );
  }
}