import 'package:expirochef/Authentication/LoginScreen.dart';
import 'package:flutter/material.dart';
import '';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget.child!), (route) => false);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpiroChef"),
      ),
      body: Center(
        child: Text("ExpiroChef", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
