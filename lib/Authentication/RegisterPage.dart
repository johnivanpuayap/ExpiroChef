import 'package:flutter/material.dart';

import 'package:expirochef/Authentication/Components/MyButton.dart';
import 'package:expirochef/Authentication/Components/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void showErrorMessage(String message) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(message),
      );
    });
  }


  void signUserUp() async {
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      if (confirmPasswordController.text == passwordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      } else {
        showErrorMessage("passwords dont match");
      }

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
        title: Text("Register"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Register", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              MyTextField(controller: emailController, hintText: "Email", obscureText: false),
              MyTextField(controller: passwordController, hintText: "Password", obscureText: true),
              MyTextField(controller: confirmPasswordController, hintText: "Confirm Password", obscureText: true),
              MyButton(
                onTap: signUserUp,
                text: "Sign Up",
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 4,),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Login now", style: TextStyle(color: Colors.blue),)),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
