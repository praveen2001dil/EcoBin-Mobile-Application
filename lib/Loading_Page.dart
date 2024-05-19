// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';

void main() {
  runApp(const LoadingPage());
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ECOBIN",
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/unsplash_OdBFUurPHjo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Powered by ECOBIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Karma',
                    fontFamilyFallback: const <String>['Karma'],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/recycle.png',
                    width: 250.0,
                    height: 250.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Garbage Management System",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
