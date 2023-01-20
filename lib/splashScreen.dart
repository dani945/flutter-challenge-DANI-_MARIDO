import 'package:flutter/material.dart';
import 'dart:async';

import 'package:infosyst/loginPage.dart';


class SplashScreen extends StatefulWidget{

  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 2);
    return Timer(duration, (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),

      // );
    });
  }

  @override 
  Widget build(BuildContext context){

    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Column(
          children: <Widget>[
            Image.asset("assets/header-splash.png"),
            Expanded(child: Image.asset("assets/logo.png"),),
            Image.asset("assets/footer-splash.png")
          ],
        ),
    );
  }

}