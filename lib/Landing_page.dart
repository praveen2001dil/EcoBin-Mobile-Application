import 'package:eco_bin_original/Login.dart';
import 'package:flutter/material.dart';
import 'Sign_up.dart';
// Import the SignUp page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ECOBIN',
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Landing_page",
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              "ECOBIN",
              style: TextStyle(
                color: Color.fromARGB(255, 9, 94, 2),
                fontSize: 55,
                fontFamily: 'Jaro',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0, right: 140),
                child: Text(
                  "The Most\nComprehensive ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 77, 89, 99),
                    fontSize: 28,
                    fontFamily: 'RobotoSlab-SemiBold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 15.0, right: 100),
                child: Text(
                  "Waste Management \nPlatform",
                  style: TextStyle(
                    color: Color.fromARGB(255, 50, 199, 55),
                    fontSize: 28,
                    fontFamily: 'RobotoSlab-SemiBold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 20),
                child: Container(
                  height: 54,
                  width: 350,
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
                                  const SignUp(),
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
                      "Join Us Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'RobotoSlab-Black',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Login(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        "Log In",
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 199, 55),
                          fontSize: 20,
                          fontFamily: 'RobotoSlab-Bold',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }
}
