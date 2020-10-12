import 'package:flutter/material.dart';
import 'package:roashan/ui/homePage.dart';
import 'package:roashan/ui/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      getUserData().then((value) {
          if(type == null){
            Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => new LoginPage()));
          }
          else{
Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => new HomePage()));
          }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     height: 200.0,
        // width:200.0,
        //     image: AssetImage("files/imgs/splash.jpg")
        //   )
      ),
      child: Center(
        child: Image(
          // height: 250.0,
          // width: 250.0,
          // color: Colors.,
          image: AssetImage("files/imgs/splash.jpg"),
          fit: BoxFit.contain,
        ),
      ),
    ));
  }

  String type;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString("type");
    });
  }
}
