import 'package:flutter/material.dart';
import 'dart:async';

import 'package:infosyst/api/apiFuction.dart';
import 'package:infosyst/dashboard.dart';
import 'package:infosyst/listProductPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var userId = TextEditingController();
  var pass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  loginAction() async {
    if (userId.text == "" || pass.text == "") {
      alertdialogEror();
    } else {
      var res = await ApiFunction().loginApi(userId.text, pass.text);
      if (res["message"] != null) {
        alertdialogGagalLogin();
      } else {
        alertdialogLogin(res);
      }
    }
  }

  alertdialogEror() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(20)),
                    child: Image.asset("assets/header-login.png", height: 100),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Center(
                        child: Text(
                      "User ID dan atau Password anda belum diisi.",
                      textAlign: TextAlign.center,
                    )),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  alertdialogLogin(res) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(20)),
                    child: Image.asset("assets/header-login.png", height: 100),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Center(
                        child: Text(
                      "Login Berhasil",
                      textAlign: TextAlign.center,
                    )),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage(
                                  image: res["image"],
                                  firstname: res["firstName"],
                                  lastname: res["lastName"],
                                  email: res["email"],
                                )));
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  alertdialogGagalLogin() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(20)),
                    child: Image.asset("assets/header-login.png", height: 100),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Center(
                        child: Text(
                      "Login Gagal",
                      textAlign: TextAlign.center,
                    )),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset("assets/header-login.png"),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            child: TextField(
              controller: userId,
              decoration: InputDecoration(
                isDense: true,
                // hintText: "User ID",
                labelText: "User ID",
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          // Note: Same code is applied for the TextFormField as well
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            child: TextField(
              controller: pass,
              decoration: InputDecoration(
                isDense: true,
                // hintText: "Password",
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Colors.redAccent), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  child: const Text("Login", style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    loginAction();
                  }),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(child: Image.asset("assets/logo.png"))
        ],
      ),
    );
  }
}
