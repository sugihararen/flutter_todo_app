import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splash.jpeg"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                'TODO',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
