import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newssile/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NEWS',
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text('sILE',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          SizedBox(height: 100),
            SpinKitWave(
              size: 50,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
