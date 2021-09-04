import 'package:flutter/material.dart';
import 'package:tapexample/Tap.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TapExample(),
    );
  }
}

class TapExample extends StatelessWidget {
  const TapExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ElevatedButton\ndefault tap animation',
            style: GoogleFonts.bitter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Tap(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(200, 80),
                ),
              ),
              child: Text(
                'Tap me',
                style: GoogleFonts.bitter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Image Widget\nweighted tap animation\ntapWeight: 0.5',
            style: GoogleFonts.bitter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Tap(
            tapWeight: 0.8,
            child: Image.asset(
              'assets/genericavatar.jpg',
              fit: BoxFit.cover,
              height: 100,
              width: 220,
            ),
          ),
        ],
      ),
    ));
  }
}
