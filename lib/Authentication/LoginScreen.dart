import 'package:expirochef/Authentication/Components/MyButton.dart';
import 'package:expirochef/Authentication/Components/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void showErrorMessage(String message) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(message),
      );
    });
  }


  void signUserIn() async {
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      showErrorMessage(e.code);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              MyTextField(controller: emailController, hintText: "Email", obscureText: false),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true),
              MyButton(
                onTap: signUserIn,
                text: "Sign In",
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                      child: Text("Register now", style: TextStyle(color: Colors.blue),)),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
