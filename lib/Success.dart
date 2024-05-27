import 'package:eco_bin_original/Garbage_showing_Map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Success());
}

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.only(left: 35, top: 20),
                  child: Text(
                    "SET UP COMPLETE!!!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 50, 199, 55),
                      fontSize: 32,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 10,
                  ),
                  child: Text(
                    "Your Account Is Now Fully",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 140),
                  child: Text(
                    "Set Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Container(
                  height: 54,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 14, 219, 21),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const GarbageshowingMap(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Proceed To Dashboard!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Image.asset(
                  'assets/Group_308.jpg',
                  width: 400.0,
                  height: 400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
