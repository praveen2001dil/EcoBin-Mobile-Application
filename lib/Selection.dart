import 'package:eco_bin_original/Garbage_showing_Map.dart';
import 'package:eco_bin_original/Sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Selection());
}

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Selection the user",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text(
              "ECOBIN",
              style: TextStyle(
                fontSize: 55,
                fontFamily: 'Jaro',
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 9, 94, 2),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "WHO ARE YOU??",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 50, 199, 55),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "What kind of person are you joining us?",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/useravatar1.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "User",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'RobotoSlab-Bold',
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GarbageshowingMap()),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/adminavatar.jpg'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Admin",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'RobotoSlab-Bold',
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Image.asset(
                    'assets/bro.jpg',
                    width: 400.0,
                    height: 330.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
